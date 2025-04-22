class LevelEditor {
  Tile[][] tiles;
  ArrayList<EditorButton> toolButtons = new ArrayList<EditorButton>();
  String currentTool = "NONE";
  String[] toolTypes = {"TILE", "SWITCH", "AND", "OR", "XOR", "NOT", "GOAL", "ERASE"};
  
  int gridWidth = 20;
  int gridHeight = 15;
  int cellSize = 40;
  
  LevelEditor() {
    tiles = new Tile[gridWidth][gridHeight];
    
    // Initialize all tiles as empty
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[0].length; j++) {
        tiles[i][j] = new Tile(i, j, false);
      }
    }
    
    // Create toolbar buttons
    for (int i = 0; i < toolTypes.length; i++) {
      toolButtons.add(new EditorButton(60 + i * 90, 30, 80, 40, toolTypes[i]));
    }
  }
  
  void display() {
    // Draw the grid
    for (int x = 0; x < gridWidth; x++) {
      for (int y = 0; y < gridHeight; y++) {
        stroke(60);
        fill(30);
        rect(x * cellSize, y * cellSize, cellSize, cellSize);
      }
    }
    
    // Draw toolbar
    fill(40);
    rect(0, 0, width, 60);
    
    // Draw tool buttons
    for (EditorButton button : toolButtons) {
      button.display();
    }
    
    // Show current tool
    fill(255);
    textAlign(LEFT, CENTER);
    textSize(14);
    text("Current Tool: " + currentTool, 10, 30);
    
    // Draw save button
    EditorButton saveButton = new EditorButton(width - 100, 30, 80, 40, "SAVE");
    saveButton.display();
  }
  
  void handleClick(int mx, int my) {
    // Check if clicking on toolbar
    if (my < 60) {
      // Check tool buttons
      for (EditorButton button : toolButtons) {
        if (button.isOver(mx, my)) {
          currentTool = button.label;
          return;
        }
      }
      
      // Check save button
      EditorButton saveButton = new EditorButton(width - 100, 30, 80, 40, "SAVE");
      if (saveButton.isOver(mx, my)) {
        saveLevel();
        return;
      }
    } else {
      // Place object in grid
      int gridX = mx / cellSize;
      int gridY = my / cellSize;
      
      if (gridX >= 0 && gridX < gridWidth && gridY >= 0 && gridY < gridHeight) {
        placeObject(gridX, gridY);
      }
    }
  }
  
  void placeObject(int x, int y) {
    // Clear existing object at this location
    tiles[x][y] = new Tile(x, y, false);
    
    // Place the new object
    switch(currentTool) {
      case "TILE":
        tiles[x][y] = new Tile(x, y, true);
        break;
      case "SWITCH":
        // In the real implementation, you would add a switch here
        fill(255, 0, 0);
        rect(x * cellSize, y * cellSize, cellSize, cellSize);
        break;
      case "AND":
      case "OR":
      case "XOR":
      case "NOT":
        // In the real implementation, you would add a gate here
        fill(0, 255, 255);
        rect(x * cellSize, y * cellSize, cellSize, cellSize);
        
        fill(255);
        textAlign(CENTER, CENTER);
        text(currentTool, x * cellSize + cellSize/2, y * cellSize + cellSize/2);
        break;
      case "GOAL":
        // In the real implementation, you would add a goal here
        fill(0, 255, 0);
        rect(x * cellSize, y * cellSize, cellSize, cellSize);
        break;
      case "ERASE":
        // Already cleared above
        break;
    }
  }
  
  void saveLevel() {
    // Convert the level to a string representation
    String[] levelData = new String[gridHeight];
    
    for (int y = 0; y < gridHeight; y++) {
      StringBuilder line = new StringBuilder();
      
      for (int x = 0; x < gridWidth; x++) {
        if (tiles[x][y].solid) {
          line.append('#');
        } else {
          // Here you would check for other object types
          // This is simplified for the demo
          line.append(' ');
        }
      }
      
      levelData[y] = line.toString();
    }
    
    // Add a timestamp to make the filename unique
    String filename = "data/level_" + year() + month() + day() + hour() + minute() + second() + ".txt";
    saveStrings(filename, levelData);
    
    // Show a message
    fill(0, 255, 0);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("Level saved as " + filename, width/2, height - 30);
  }
}

class EditorButton {
  float x, y;
  float w, h;
  String label;
  color buttonColor = color(60, 60, 60);
  color hoverColor = color(80, 80, 80);
  color textColor = color(255);
  
  EditorButton(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }
  
  void display() {
    if (isOver(mouseX, mouseY)) {
      fill(hoverColor);
    } else {
      fill(buttonColor);
    }
    
    stroke(120);
    strokeWeight(2);
    rectMode(CENTER);
    rect(x, y, w, h, 5);
    
    fill(textColor);
    textAlign(CENTER, CENTER);
    textSize(12);
    text(label, x, y);
    rectMode(CORNER);
  }
  
  boolean isOver(float mx, float my) {
    return (mx > x - w/2 && mx < x + w/2 && 
            my > y - h/2 && my < y + h/2);
  }
} 