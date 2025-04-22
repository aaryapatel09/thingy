class Tile {
  int x, y;
  boolean solid;

  Tile(int x, int y, boolean solid) {
    this.x = x;
    this.y = y;
    this.solid = solid;
  }

  void display() {
    if (solid) {
      fill(100);
      rect(x * 40, y * 40, 40, 40);
    }
  }
} 