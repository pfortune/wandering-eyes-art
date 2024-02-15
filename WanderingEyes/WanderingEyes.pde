/*
* Student Name:   Peter Fortune
* Student Number: 20011462
* Description:    This program utilises a randomised grid of nested squares, arcs, circles, and windows to create a visually dynamic 
*                 art piece, with additional interactive elements in the form of eyes that follow the movement of the mouse.
*/

// Define the number of columns and rows in the grid
int gridCols = 16; // columns in grid
int gridRows = 9; // rows in grid

// Keep track of the previously selected colour of a shape
int previousColour = -1; // previous colour of a shape

// Flag to check if the grid has been drawn or not
boolean gridDrawn = false;

// Flag to check if the drawing has been saved or not
boolean drawingSaved = false;

// Define the size of each box in the grid
int boxSize;

// Define colour variables for the adobe colour palette
color colour1, colour2, colour3, colour4, colour5;

// Define string variables for the student number and name
String studentNumber = " 20011462 ";
String studentName = " Peter Fortune ";

// This function is called once when the program starts
void setup() {
  // Set the size of the canvas to 1280 x 720 pixels
  size(1280, 720);

  // Turn off drawing stroke to get rid of outlines around shapes
  noStroke();

  // Set the location of the window to the top left corner of the screen
  surface.setLocation(0, 0);

  // Apply the Adobe colours to the colour palette used in the drawing
  setPalette(#DAFDBA, #9AEBA3, #45C4B0, #13678A, #012030);

  // Calculate the box size based on the number of columns and the canvas width
  boxSize = width / gridCols;
}

/**
 * This function is called repeatedly after setup, which updates the eyes on the screen.
 * It first checks if the grid has been drawn, and if not, draws the grid by calling the drawGrid method.
 * After the grid has been drawn, it draws eyes with different coordinates and colours by calling the drawEye method.
 */
void draw() {
  // check if the grid has been drawn, and if not, draw the grid
  if (!gridDrawn) {
    drawGrid();
    // set gridDrawn to true to indicate the grid has been drawn
    gridDrawn = true;
  }

  // Draw eyes with different coordinates and colours
  drawEye(11, 5, 0);
  drawEye(3, 6, 1);
  drawEye(15, 1, 2);
  drawEye(6, 4, 2);
  drawEye(2, 2, 3);
}

/**
 * Called when the right mouse button is pressed down. If it is the first time, save the drawing as "WanderingEyes.png".
 * After the first time, save a screenshot of the drawing with a unique filename that includes the current timestamp.
 */
void mousePressed() {
  // Check if the right mouse button is clicked
  if (mouseButton == RIGHT) {
    if (!drawingSaved) {
      // Save the image as "WanderingEyes.png" for the first time
      save("\\WanderingEyes.png");
      drawingSaved = true;
    } else {
      // Save a screenshot of the drawing to the sketch folder with a unique filename
      // The filename includes "WanderingEyes" and appends in milliseconds since the app has started running, to make it unique
      save("\\WanderingEyes" + millis() + ".png");
    }
  }
}

/**
 * This function is called when the mouse is clicked and released. If the left mouse button is clicked, the gridDrawn
 * variable is updated to false, which causes the grid to be redrawn in the draw() method.
 */
void mouseClicked() {
  // Check if the left mouse button is clicked
  if (mouseButton == LEFT) {
    // Update the gridDrawn variable to false, indicating that the grid needs to be redrawn
    gridDrawn = false;
  }
}

/**
 * This function generates a grid of random shapes and colours, based on the values of the gridRows and gridCols variables.
 *
 * It loops through each row and column of the grid, and for each cell, selects a random colour using the selectColour() function,
 * and then draws a random shape in the cell using the randomShape() function. If the current row is the first row, the student's name
 * is displayed using the displayStringInRow() function. If the current row is the last row, the student's number is displayed.
 */
void drawGrid() {
  // Loop through each row of the grid
  for (int y = 0; y < gridRows; y++) {
    // Loop through each column of the grid
    for (int x = 0; x < gridCols; x++) {
      // Draw a random shape in the current cell with a random colour
      selectColour();
      randomShape(x, y);

      // If the current row is the first row
      if (y == 0) {
        // Display the student's name at the top of the grid
        displayStringInRow(studentName, 0);
      }
      // If the current row is the last row
      else if (y == gridRows - 1) {
        // Display the student's number at the bottom of the grid
        displayStringInRow(studentNumber, gridRows - 1);
      }
    }
  }
}

/**
 * This function displays a given string in the specified row of the grid cell by cell. It performs the following steps:
 *
 * 1. Trims any whitespace from the beginning and end of the input string.
 * 2. Converts the string to uppercase.
 * 3. Sets the font size to 20.
 * 4. Draws a semi-transparent white rectangle behind each character.
 * 5. Draws a slightly transparent dark-coloured character for a drop-shadow effect.
 * 6. Draws the character in white at the calculated position.
 *
 * Parameters:
 * -  string : The string to be displayed in the row.
 * -  row : The row number in which the string will be displayed.
 */
void displayStringInRow(String string, int row) {
  // Trim any whitespace from the beginning and end of the input string and convert to uppercase
  string = string.toUpperCase().trim();

  // Set the font size to 20
  textSize(20);

  // Loop through each character in the string
  for (int i = 0; i < string.length(); i++) {
    // Calculate the width of the character
    float characterWidth = textWidth(string.charAt(i));

    // Draw a semi-transparent white rectangle behind the character
    fill(255, 255, 255, 20);
    rect(i * boxSize, row * boxSize + boxSize/5, boxSize, boxSize/2);

    // Draw a slightly transparent dark-coloured character for a drop-shadow effect
    fill(#012030, 80);
    text(string.charAt(i), i * boxSize + (boxSize - characterWidth) / 2 + 2, row * boxSize + boxSize / 2 + 2);

    // Draw the character in white at the calculated position
    fill(255);
    text(string.charAt(i), i * boxSize + (boxSize - characterWidth) / 2, row * boxSize + boxSize / 2);
  }
}

/**
 * This function sets the colour palette to be used in the drawing. It assigns the colours to the
 * variables colour1, colour2, colour3, colour4, and colour5. The selectColour() function uses
 * these variables to set the fill colour when a colour is selected.
 */
void setPalette(color a, color b, color c, color d, color e) {
  // Assign each colour to its corresponding variable
  colour1 = a;
  colour2 = b;
  colour3 = c;
  colour4 = d;
  colour5 = e;
}

/**
 * This function randomly selects a shape to draw based on a random number generated between 0 and 100.
 * The x and y parameters are used to determine the location on the grid to draw the shape.
 * The following shapes may be drawn:
 * - squares (20% chance)
 * - windows (20% chance)
 * - circles (20% chance)
 * - pause symbols (20% chance)
 * - arcs (20% chance)
 *
 * Parameters:
 * - x : the x-coordinate of the shape to be drawn.
 * - y : the x-coordinate of the shape to be drawn.
 */
void randomShape(int x, int y) {
  // Picks a number between 0 and 100, then rounds it down to a whole integer
  int randomNum = floor(random(100));

  if (randomNum < 20) {
    drawSquares(x, y, int(random(2, 5)));
  } else if (randomNum < 40) {
    drawWindow(x, y);
  } else if (randomNum < 60) {
    drawCircles(x, y, random(1, 6));
  } else if (randomNum < 80) {
    drawPause(x, y);
  } else {
    drawArcs(x, y);
  }
}

/**
 * This function draws a set of four arcs with different diameters and colours inside a square.
 * It first calls the drawSquares function to draw the square. Then it calls the selectColour function
 * to set the fill colour for each arc. The arc function is then used to draw each of the four arcs,
 * which takes the x and y coordinates of the center of the arc, the width and height of the ellipse that the arc
 * is a part of, and the start and stop angles of the arc in radians as arguments.
 *
 * Parameters:
 * - x : the x-coordinate of the square to draw arcs inside.
 * - y : the y-coordinate of the square to draw arcs inside.
 */
void drawArcs(int x, int y) {
  // Draw the square as the background for the arcs
  drawSquares(x, y, 1);

  // Draw first arc
  selectColour();
  arc(x*boxSize, y*boxSize, 150, 150, 0, radians(90));

  // Draw second arc
  selectColour();
  arc(x*boxSize, y*boxSize, 120, 120, 0, radians(90));

  // Draw third arc
  selectColour();
  arc(x*boxSize, y*boxSize, 90, 90, 0, radians(90));

  // Draw fourth arc
  selectColour();
  arc(x*boxSize, y*boxSize, 60, 60, 0, radians(90));
}

/**
 * Draws a series of squares, each decreasing in size and increasing in border thickness, starting from the specified location (x, y).
 * The number of squares drawn is determined by the depth parameter.
 *
 * Parameters:
 * - x : the x coordinate of the starting location for drawing the squares.
 * - y : the y coordinate of the starting location for drawing the squares.
 * - depth : the number of squares to be drawn.
 */
void drawSquares(int x, int y, int depth) {
  // Initialize the border thickness and scale of the first square
  float border = 0;
  float scale = 1;
  int count = 0;

  // Loop through the specified depth and draw each square with decreasing size and increasing border thickness
  while (count < depth && scale > 0.2) {
    // Set the fill colour of the square to a randomly selected colour
    selectColour();

    // Draw the square with the current border thickness and scale at the specified x and y location
    rect(x * boxSize + border, y * boxSize + border, boxSize * scale, boxSize * scale);

    // Increase the border thickness and decrease the scale for the next square
    border += boxSize * 0.1;
    scale -= 0.2;
    count++;
  }
}

/**
 * The function first draws a square using the drawSquares() function, and then draws a series of
 * concentric circles with decreasing sizes. The number of circles drawn is determined by the value of the depth parameter.
 *
 * Parameters:
 * - x : the x coordinate of the starting location for drawing the circles.
 * - y : the y coordinate of the starting location for drawing the circles.
 * - depth : the number of circles to be drawn.
 */
void drawCircles(int x, int y, float depth) {
  // Draw the square as the background for the circles
  drawSquares(x, y, 1);

  // Initialize scale and count variables
  float scale = 1;
  int count = 0;

  // Draw circles with decreasing size
  while (count < depth && scale > 0.2) {
    // Select a random colour for the circle
    selectColour();
    // Draw the circle at the center of the box with the specified scale
    ellipse(x * boxSize + boxSize/2, y * boxSize + boxSize/2, boxSize * scale, boxSize * scale);
    // Decrease the scale and increment the count
    scale -= 0.2;
    count++;
  }
}

/**
 * This function draws a pause button at the specified grid location (x, y). The pause button consists of
 * two rectangles of equal size, one on the left and one on the right, which represent the two vertical bars of
 * the pause symbol.
 *
 * Parameters:
 * - x : the x-coordinate of the grid location where the pause button will be drawn
 * - y : the y-coordinate of the grid location where the pause button will be drawn
 */
void drawPause(int x, int y) {
  // Draw the square as the background for the pause button
  drawSquares(x, y, 1);

  // Select a colour for the rectangles representing the pause symbol
  selectColour();

  // Draw the left rectangle of the pause symbol
  rect(x * boxSize + boxSize*0.15, y * boxSize + boxSize/6, boxSize/4, boxSize/1.5);

  // Draw the right rectangle of the pause symbol
  rect(x * boxSize + boxSize*0.6, y * boxSize + boxSize/6, boxSize/4, boxSize/1.5);
}

/**
 * Draws a window at the specified grid position.
 *
 * Parameters:
 * - x : the x-coordinate of the grid location where the window will be drawn
 * - y : the y-coordinate of the grid location where the window will be drawn
 */
void drawWindow(int x, int y) {
  // Draw the square as the background for the Window
  drawSquares(x, y, 1);

  // Select a colour for the rectangles representing the window
  selectColour();
  // Draw the four smaller squares in the center of the window
  rect(x * boxSize + boxSize * 0.15, y * boxSize + boxSize * 0.15, boxSize * 0.25, boxSize * 0.25);
  rect(x * boxSize + boxSize * 0.6, y * boxSize + boxSize * 0.6, boxSize * 0.25, boxSize * 0.25);
  rect(x * boxSize + boxSize * 0.6, y * boxSize + boxSize * 0.15, boxSize * 0.25, boxSize * 0.25);
  rect(x * boxSize + boxSize * 0.15, y * boxSize + boxSize * 0.6, boxSize * 0.25, boxSize * 0.25);
}

/**
 * This function is responsible for drawing an eye in a given location with a given colour. The function calculates
 * the distance between the mouse and the center of the eye to determine the position of the pupil. It first draws
 * the white part of the eye and then the iris with a diameter of eyeDiameter. Finally, it draws the pupil with a
 * diameter of pupilDiameter.
 *
 * Parameters:
 * - x : the x-coordinate of the grid location where the eye will be drawn
 * - y : the y-coordinate of the grid location where the eye will be drawn
 * - colour : the colour of the eye
 */
void drawEye(int x, int y, int colour) {

  float pupilX, pupilY;
  float eyeDiameter = boxSize/3;
  float pupilDiameter = boxSize/6;

  // Calculates the distance between the mouse and the center of the eye
  float centreX = x * boxSize + boxSize * 0.5;
  float centreY = y * boxSize + boxSize * 0.5;
  float d = dist(mouseX, mouseY, centreX, centreY);

  // If the mouse is outside the iris of the eye, set the pupil position relative to the iris
  if (d > eyeDiameter * 0.5 - pupilDiameter * 0.75) {
    pupilX = centreX + (mouseX - centreX) * (eyeDiameter - pupilDiameter) / d * 0.5;
    pupilY = centreY + (mouseY - centreY) * (eyeDiameter - pupilDiameter) / d * 0.5;
  } else {
    pupilX = centreX;
    pupilY = centreY;
  }

  // Draw the background box
  selectColour(colour + 1);
  rect(x * boxSize, y * boxSize, boxSize, boxSize);

  // Draw the white part of the eye
  fill(#ffffff);
  ellipse(x * boxSize + boxSize/2, y * boxSize + boxSize/2, boxSize, boxSize/3);

  // Draw and colour the iris
  selectColour(colour);
  ellipse(x * boxSize + boxSize/2, y * boxSize + boxSize/2, eyeDiameter, eyeDiameter);

  // Draw and colour the pupil
  selectColour(5);
  ellipse(pupilX, pupilY, pupilDiameter, pupilDiameter);
}

/**
 * This function selects a random colour from a set of pre-defined colours or a specific colour from the set.
 * If no arguments are passed, it generates a random integer between 0 and 5 and calls the selectColour(int) function with that integer.
 */
void selectColour() {
  int colourNumber = int(random(0, 5));
  selectColour(colourNumber);
}

/**
 * This function sets the colour to the specified colourNumber and checks whether this is the same as the previously selected colour.
 * If so, it selects a different colour. It then updates the previously selected colour.
 *
 * Parameters:
 * - colourNumber : the colour to be used
 */

void selectColour(int colourNumber) {
  color colour;
  if (colourNumber == 0) {
    colour = colour1;
  } else if (colourNumber == 1) {
    colour = colour2;
  } else if (colourNumber == 2) {
    colour = colour3;
  } else if (colourNumber == 3) {
    colour = colour4;
  } else {
    colour = colour5;
  }

  while (colour == getPreviousColour()) {
    colourNumber = (colourNumber + 1) % 5;
    if (colourNumber == 0) {
      colour = colour1;
    } else if (colourNumber == 1) {
      colour = colour2;
    } else if (colourNumber == 2) {
      colour = colour3;
    } else if (colourNumber == 3) {
      colour = colour4;
    } else {
      colour = colour5;
    }
  }

  fill(colour);
  setPreviousColour(colourNumber);
}

/**
 * This function retrieves the previously selected colour.
 *
 * Returns:
 * - the colour previously used
 */
color getPreviousColour() {
  if (previousColour == 0) {
    return colour1;
  } else if (previousColour == 1) {
    return colour2;
  } else if (previousColour == 2) {
    return colour3;
  } else if (previousColour == 3) {
    return colour4;
  } else {
    return colour5;
  }
}

/**
 * This function updates the previously selected colour with the index of the currently selected colour.
 *
 * Parameters:
 * - colourNumber : the index of the previously used colour
 */
void setPreviousColour(int colourNumber) {
  previousColour = colourNumber;
}
