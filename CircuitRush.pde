// Circuit Rush - A Logic-Based Puzzle Platformer
// Main game file

// Game states
final int STATE_MENU = 0;
final int STATE_GAME = 1;
final int STATE_EDITOR = 2;
final int STATE_LEVEL_SELECT = 3;
final int STATE_LEVEL_COMPLETE = 4;
int gameState = STATE_MENU;

// Current level
int currentLevel = 1;
int maxLevel = 3;

Player player;
Level level;
LevelEditor editor;

// Colors
color bgColor = color(10, 20, 40);
color wireColor = color(30, 200, 200);
color activeWireColor = color(0, 255, 255);
color playerColor = color(255, 255, 0);

// UI elements
Button playButton;
Button editorButton;
Button backButton;
Button nextLevelButton;
Button menuButton;

void setup() {
  size(800, 600);
  frameRate(60);
  
  // Create UI elements
  playButton = new Button(width/2, height/2 - 50, 200, 50, "Play Game");
  editorButton = new Button(width/2, height/2 + 50, 200, 50, "Level Editor");
  backButton = new Button(100, 50, 120, 40, "Back");
  nextLevelButton = new Button(width/2, height/2 + 20, 200, 50, "Next Level");
  menuButton = new Button(width/2, height/2 + 90, 200, 50, "Main Menu");
  
  // Initialize game objects
  level = new Level("level1.txt");
  player = new Player(3, 12);
  editor = new LevelEditor();
}

void draw() {
  background(20);
  
  switch(gameState) {
    case STATE_MENU:
      drawMenu();
      break;
    case STATE_GAME:
      level.display();
      player.update();
      player.display();
      level.checkTriggers(player);
      
      // Check if level is completed
      if (level.levelCompleted) {
        gameState = STATE_LEVEL_COMPLETE;
      }
      break;
    case STATE_EDITOR:
      editor.display();
      break;
    case STATE_LEVEL_SELECT:
      drawLevelSelect();
      break;
    case STATE_LEVEL_COMPLETE:
      drawLevelComplete();
      break;
  }
}

void drawMenu() {
  fill(255);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("Circuit Rush", width/2, 120);
  
  textSize(18);
  text("A Logic-Based Puzzle Platformer", width/2, 180);
  
  playButton.display();
  editorButton.display();
}

void drawEditor() {
  // This is handled by the LevelEditor class
}

void drawLevelSelect() {
  fill(255);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Select Level", width/2, 60);
  
  backButton.display();
  
  // Display available levels
  for (int i = 1; i <= maxLevel; i++) {
    Button levelButton = new Button(width/2, 150 + i*70, 180, 50, "Level " + i);
    levelButton.display();
  }
}

void drawLevelComplete() {
  fill(0, 0, 0, 200);
  rect(0, 0, width, height);
  
  fill(255);
  textSize(48);
  textAlign(CENTER, CENTER);
  text("Level " + currentLevel + " Completed!", width/2, height/2 - 80);
  
  if (currentLevel < maxLevel) {
    nextLevelButton.display();
  }
  
  menuButton.display();
}

void keyPressed() {
  if (gameState == STATE_GAME) {
    if (key == 'a') player.moveLeft();
    if (key == 'd') player.moveRight();
    if (key == 'w' || key == ' ') player.jump();
    if (key == 'p' || key == ESCAPE) gameState = STATE_MENU;
  } else if (gameState == STATE_LEVEL_COMPLETE) {
    if (key == ' ' && currentLevel < maxLevel) {
      // Load next level
      currentLevel++;
      loadLevel(currentLevel);
      gameState = STATE_GAME;
    }
  }
}

void mousePressed() {
  switch(gameState) {
    case STATE_MENU:
      if (playButton.isOver()) {
        gameState = STATE_LEVEL_SELECT;
      } else if (editorButton.isOver()) {
        gameState = STATE_EDITOR;
      }
      break;
    case STATE_EDITOR:
      if (mouseY < 60 && mouseX < 100) {
        // Back button area in editor
        gameState = STATE_MENU;
      } else {
        editor.handleClick(mouseX, mouseY);
      }
      break;
    case STATE_LEVEL_SELECT:
      if (backButton.isOver()) {
        gameState = STATE_MENU;
      } else {
        // Check if a level button was clicked
        for (int i = 1; i <= maxLevel; i++) {
          Button levelButton = new Button(width/2, 150 + i*70, 180, 50, "Level " + i);
          if (levelButton.isOver()) {
            currentLevel = i;
            loadLevel(currentLevel);
            gameState = STATE_GAME;
          }
        }
      }
      break;
    case STATE_LEVEL_COMPLETE:
      if (nextLevelButton.isOver() && currentLevel < maxLevel) {
        currentLevel++;
        loadLevel(currentLevel);
        gameState = STATE_GAME;
      } else if (menuButton.isOver()) {
        gameState = STATE_MENU;
      }
      break;
  }
}

void loadLevel(int levelNum) {
  level = new Level("level" + levelNum + ".txt");
  player = new Player(3, 12);
} 