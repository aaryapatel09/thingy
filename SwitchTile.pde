class SwitchTile {
  int x, y;
  boolean active = false;
  Gate connectedGate;
  int inputIndex;

  SwitchTile(int x, int y) {
    this.x = x;
    this.y = y;
  }

  void connect(Gate g, int inputIndex) {
    this.connectedGate = g;
    this.inputIndex = inputIndex;
  }

  void toggle() {
    active = !active;
    connectedGate.setInput(inputIndex, active);
  }

  void display() {
    fill(active ? color(0, 255, 0) : color(255, 0, 0));
    rect(x * 40, y * 40, 40, 40);
  }
} 