// Player class - handles movement, physics, and interactions

class Player {
  // Position and movement
  PVector position;
  PVector velocity;
  float speed = 5;
  float jumpForce = 12;
  float gravity = 0.5;
  
  // Size
  float size = 20;
  
  // State
  boolean isGrounded = false;
  boolean movingLeft = false;
  boolean movingRight = false;
  boolean isAlive = true;
  boolean hasWon = false;
  
  // Animation
  int sparkFrame = 0;
  int sparkFrameCount = 8;
  int sparkDelay = 3;
  int frameCounter = 0;
  
  Player(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
  }
  
  void update() {
    // Apply movement based on input
    velocity.x = 0;
    if (movingLeft) velocity.x -= speed;
    if (movingRight) velocity.x += speed;
    
    // Apply gravity
    if (!isGrounded) {
      velocity.y += gravity;
    }
    
    // Update position
    position.add(velocity);
    
    // Update animation
    frameCounter++;
    if (frameCounter >= sparkDelay) {
      sparkFrame = (sparkFrame + 1) % sparkFrameCount;
      frameCounter = 0;
    }
    
    // Check for collisions with level
    checkCollisions();
  }
  
  void display() {
    pushMatrix();
    translate(position.x, position.y);
    
    // Draw electricity effect
    fill(playerColor, 200);
    stroke(playerColor);
    strokeWeight(2);
    ellipse(0, 0, size, size);
    
    // Draw sparks
    drawSparks();
    
    popMatrix();
  }
  
  void drawSparks() {
    stroke(255, 255, 0, 200);
    strokeWeight(2);
    
    // Draw different spark patterns based on frame
    float sparkLength = size * 0.8;
    float angle = sparkFrame * (TWO_PI / sparkFrameCount);
    
    for (int i = 0; i < 4; i++) {
      float sparkAngle = angle + (i * PI/2);
      float x2 = cos(sparkAngle) * sparkLength;
      float y2 = sin(sparkAngle) * sparkLength;
      line(0, 0, x2, y2);
    }
  }
  
  void jump() {
    if (isGrounded) {
      velocity.y = -jumpForce;
      isGrounded = false;
    }
  }
  
  void checkCollisions() {
    // To be implemented - will check against level tiles, gates, hazards
    // This is a placeholder - will be expanded when level data is available
    
    // Simple ground check
    if (position.y > height - size/2) {
      position.y = height - size/2;
      velocity.y = 0;
      isGrounded = true;
    } else {
      isGrounded = false;
    }
    
    // Simple wall check
    if (position.x < size/2) {
      position.x = size/2;
    } else if (position.x > width - size/2) {
      position.x = width - size/2;
    }
  }
  
  void handleKeyPress(int code) {
    switch(code) {
      case LEFT:
        movingLeft = true;
        break;
      case RIGHT:
        movingRight = true;
        break;
      case UP:
      case 32: // Space
        jump();
        break;
    }
  }
  
  void handleKeyRelease(int code) {
    switch(code) {
      case LEFT:
        movingLeft = false;
        break;
      case RIGHT:
        movingRight = false;
        break;
    }
  }
  
  boolean intersects(float x, float y, float w, float h) {
    return (position.x + size/2 > x && 
            position.x - size/2 < x + w && 
            position.y + size/2 > y && 
            position.y - size/2 < y + h);
  }
  
  void reset(float x, float y) {
    position.x = x;
    position.y = y;
    velocity.x = 0;
    velocity.y = 0;
    isAlive = true;
    hasWon = false;
  }
} 