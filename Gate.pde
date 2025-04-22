class Gate {
  String type;
  boolean[] inputs = {false, false};
  boolean output;
  int x, y;
  
  // For connecting gates
  Gate connectedGate;
  int outputIndex;

  Gate(String type, int x, int y) {
    this.type = type;
    this.x = x;
    this.y = y;
  }

  void setInput(int index, boolean val) {
    inputs[index] = val;
  }

  void calculate() {
    if (type.equals("AND")) {
      output = inputs[0] && inputs[1];
    } else if (type.equals("OR")) {
      output = inputs[0] || inputs[1];
    } else if (type.equals("XOR")) {
      output = inputs[0] != inputs[1];
    } else if (type.equals("NOT")) {
      output = !inputs[0];
    } else if (type.equals("NAND")) {
      output = !(inputs[0] && inputs[1]);
    } else if (type.equals("NOR")) {
      output = !(inputs[0] || inputs[1]);
    }
  }

  void display() {
    fill(output ? color(0, 255, 255) : color(0));
    rect(x * 40, y * 40, 40, 40);
    
    // Draw gate type label
    fill(255);
    textAlign(CENTER, CENTER);
    text(type, x * 40 + 20, y * 40 + 20);
  }
} 