class Button {
  float x, y;
  float w, h;
  String label;
  color buttonColor = color(50, 120, 200);
  color hoverColor = color(70, 140, 220);
  color textColor = color(255);
  
  Button(float x, float y, float w, float h, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
  }
  
  void display() {
    if (isOver()) {
      fill(hoverColor);
    } else {
      fill(buttonColor);
    }
    
    stroke(255);
    strokeWeight(2);
    rectMode(CENTER);
    rect(x, y, w, h, 10);
    
    fill(textColor);
    textAlign(CENTER, CENTER);
    textSize(16);
    text(label, x, y);
    rectMode(CORNER);
  }
  
  boolean isOver() {
    return (mouseX > x - w/2 && mouseX < x + w/2 && 
            mouseY > y - h/2 && mouseY < y + h/2);
  }
} 