class Goal {
  int x, y;
  boolean active = false;
  Gate connectedGate;
  
  Goal(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  void connect(Gate g) {
    this.connectedGate = g;
  }
  
  void update() {
    if (connectedGate != null) {
      active = connectedGate.output;
    }
  }
  
  void display() {
    if (active) {
      fill(0, 255, 0, 200);
      stroke(0, 255, 0);
    } else {
      fill(100, 100, 100, 150);
      stroke(100);
    }
    
    strokeWeight(2);
    rect(x * 40, y * 40, 40, 40);
    
    // Draw goal symbol
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("G", x * 40 + 20, y * 40 + 20);
  }
  
  boolean checkPlayerReached(Player p) {
    return active && p.tileX() == x && p.tileY() == y;
  }
} 