class Level {
  Tile[][] tiles;
  ArrayList<SwitchTile> switches = new ArrayList<SwitchTile>();
  ArrayList<Gate> gates = new ArrayList<Gate>();
  Goal goal;
  boolean levelCompleted = false;
  
  Level(String filename) {
    tiles = new Tile[20][15];
    
    // Initialize all tiles as empty
    for (int i = 0; i < tiles.length; i++) {
      for (int j = 0; j < tiles[0].length; j++) {
        tiles[i][j] = new Tile(i, j, false);
      }
    }
    
    // Try to load level from file
    String[] lines = loadStrings(filename);
    
    if (lines != null && lines.length > 0) {
      parseLevel(lines);
    } else {
      // If file loading fails, create a default level
      createDefaultLevel();
    }
  }
  
  void parseLevel(String[] lines) {
    int rows = min(lines.length, tiles[0].length);
    
    // Parse the tiles
    for (int y = 0; y < rows; y++) {
      String line = lines[y];
      int cols = min(line.length(), tiles.length);
      
      for (int x = 0; x < cols; x++) {
        char c = line.charAt(x);
        
        switch(c) {
          case '#': // Solid tile
            tiles[x][y] = new Tile(x, y, true);
            break;
          case 'S': // Switch
            SwitchTile s = new SwitchTile(x, y);
            switches.add(s);
            break;
          case 'A': // AND gate
            Gate andGate = new Gate("AND", x, y);
            gates.add(andGate);
            break;
          case 'O': // OR gate
            Gate orGate = new Gate("OR", x, y);
            gates.add(orGate);
            break;
          case 'X': // XOR gate
            Gate xorGate = new Gate("XOR", x, y);
            gates.add(xorGate);
            break;
          case 'N': // NOT gate
            Gate notGate = new Gate("NOT", x, y);
            gates.add(notGate);
            break;
          case 'G': // Goal
            goal = new Goal(x, y);
            break;
        }
      }
    }
    
    // If no goal was defined, create a default one
    if (goal == null) {
      goal = new Goal(18, 13);
    }
    
    // Connect switches to gates - for now we'll connect them in order
    // This is a simple implementation, in a full game you might want a more advanced system
    if (switches.size() > 0 && gates.size() > 0) {
      if (switches.size() >= 2 && gates.size() >= 1) {
        // First two switches to first gate
        switches.get(0).connect(gates.get(0), 0);
        switches.get(1).connect(gates.get(0), 1);
      }
      
      if (switches.size() >= 4 && gates.size() >= 2) {
        // Next two switches to second gate
        switches.get(2).connect(gates.get(1), 0);
        switches.get(3).connect(gates.get(1), 1);
      }
      
      if (gates.size() >= 3) {
        // Create a goal gate requiring outputs from the first two gates
        gates.get(0).connectedGate = gates.get(2);
        gates.get(0).outputIndex = 0;
        gates.get(1).connectedGate = gates.get(2);
        gates.get(1).outputIndex = 1;
        
        // Connect the goal
        goal.connect(gates.get(2));
      } else if (gates.size() >= 1) {
        // Otherwise just connect the goal to the first gate
        goal.connect(gates.get(0));
      }
    }
  }
  
  void createDefaultLevel() {
    // Example hardcoded layout
    for (int i = 0; i < 20; i++) {
      tiles[i][14] = new Tile(i, 14, true); // ground row
    }

    switches.add(new SwitchTile(5, 13));
    switches.add(new SwitchTile(8, 13));

    Gate g = new Gate("AND", 6, 12);
    gates.add(g);

    switches.get(0).connect(g, 0);
    switches.get(1).connect(g, 1);
    
    // Add some platform tiles
    tiles[10][10] = new Tile(10, 10, true);
    tiles[11][10] = new Tile(11, 10, true);
    tiles[12][10] = new Tile(12, 10, true);
    
    // Add an OR gate
    Gate orGate = new Gate("OR", 15, 12);
    gates.add(orGate);
    
    // Add switches for OR gate
    switches.add(new SwitchTile(14, 13));
    switches.add(new SwitchTile(16, 13));
    
    switches.get(2).connect(orGate, 0);
    switches.get(3).connect(orGate, 1);
    
    // Add a goal that requires both gates to be active
    Gate goalGate = new Gate("AND", 18, 10);
    gates.add(goalGate);
    goalGate.setInput(0, false);
    goalGate.setInput(1, false);
    
    // Connect the output of first two gates to the goal gate
    g.connectedGate = goalGate;
    g.outputIndex = 0;
    orGate.connectedGate = goalGate;
    orGate.outputIndex = 1;
    
    // Create the goal
    goal = new Goal(18, 13);
    goal.connect(goalGate);
  }

  void display() {
    for (Tile[] row : tiles) {
      for (Tile t : row) t.display();
    }
    for (SwitchTile s : switches) s.display();
    for (Gate g : gates) g.display();
    
    // Display goal
    goal.display();
    
    // Display wires to connect switches to gates
    stroke(120);
    strokeWeight(2);
    
    for (int i = 0; i < switches.size(); i++) {
      SwitchTile s = switches.get(i);
      Gate g = s.connectedGate;
      if (g != null) {
        // Draw wire from switch to gate
        if (s.active) {
          stroke(0, 255, 0);
        } else {
          stroke(255, 0, 0);
        }
        line(s.x * 40 + 20, s.y * 40 + 20, g.x * 40 + 20, g.y * 40 + 20);
      }
    }
    
    // Draw wires connecting gates
    for (Gate g : gates) {
      if (g.connectedGate != null) {
        if (g.output) {
          stroke(0, 255, 255);
        } else {
          stroke(0, 100, 100);
        }
        line(g.x * 40 + 20, g.y * 40 + 20, 
             g.connectedGate.x * 40 + 20, g.connectedGate.y * 40 + 20);
      }
    }
    
    // Show level completed message
    if (levelCompleted) {
      fill(0, 0, 0, 200);
      rect(0, 0, width, height);
      
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(48);
      text("Level Completed!", width/2, height/2 - 40);
      
      textSize(24);
      text("Press SPACE to continue", width/2, height/2 + 40);
    }
  }

  void checkTriggers(Player p) {
    // Check if player reached the goal
    if (goal.checkPlayerReached(p)) {
      levelCompleted = true;
      return;
    }
    
    for (SwitchTile s : switches) {
      if (p.tileX() == s.x && p.tileY() == s.y) {
        s.toggle();
      }
    }

    for (Gate g : gates) {
      g.calculate();
      // Update connected gates
      if (g.connectedGate != null) {
        g.connectedGate.setInput(g.outputIndex, g.output);
      }
    }
    
    // Update goal state
    goal.update();
    
    // Check collision with tiles
    checkCollisions(p);
  }
  
  void checkCollisions(Player p) {
    // Check floor collision
    int tileX = p.tileX();
    int tileY = p.tileY() + 1; // Check tile below player
    
    // Ground check
    if (tileY < tiles[0].length && tileX >= 0 && tileX < tiles.length) {
      if (tiles[tileX][tileY].solid) {
        p.y = tileY * 40 - p.h;
        p.ySpeed = 0;
        p.onGround = true;
      }
    }
    
    // Wall collision (left and right)
    int leftTileX = floor((p.x - 1) / 40);
    int rightTileX = floor((p.x + p.w + 1) / 40);
    int playerTileY = floor(p.y / 40);
    
    // Left wall
    if (leftTileX >= 0 && leftTileX < tiles.length && playerTileY >= 0 && playerTileY < tiles[0].length) {
      if (tiles[leftTileX][playerTileY].solid) {
        p.x = (leftTileX + 1) * 40;
        p.xSpeed = 0;
      }
    }
    
    // Right wall
    if (rightTileX >= 0 && rightTileX < tiles.length && playerTileY >= 0 && playerTileY < tiles[0].length) {
      if (tiles[rightTileX][playerTileY].solid) {
        p.x = rightTileX * 40 - p.w;
        p.xSpeed = 0;
      }
    }
  }
} 