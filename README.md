# Circuit Rush

A logic-based puzzle platformer game built with Processing.

## Game Overview

In Circuit Rush, you control a spark of electricity navigating through circuit boards to power a device. You must trigger switches in the correct order or combination to activate outputs and open paths to progress through each level.

## Key Features

1. **Logic Gate Puzzles**: Each level includes simple circuits (AND, OR, NOT, XOR, etc.)
2. **Platformer Mechanics**: Basic movement (left, right, jump) with electrical hazards to avoid
3. **Level Progression System**: Multiple levels with increasing difficulty
4. **In-Game Level Editor**: Create your own puzzles with a drag & drop editor
5. **Visual Circuit Theme**: Wires light up, gates pulse, and electric themes throughout

## How to Play

1. **Controls**:
   - A/D: Move left/right
   - W or Space: Jump
   - P or Escape: Pause/return to menu

2. **Gameplay**:
   - Step on switches to toggle them on/off
   - Gates will activate based on their logic type and input states
   - Reach the goal tile when it's activated to complete the level

## Level Editor

The game includes a simple level editor that allows you to:

1. Create your own levels using various tiles and logic components
2. Save your levels to files that can be loaded later
3. Test your creations

## Installation

1. Install Processing from [processing.org](https://processing.org/)
2. Open the CircuitRush.pde file in Processing
3. Click the Run button to start the game

## Project Structure

- **CircuitRush.pde**: Main game file with setup and draw loops
- **Player.pde**: Player character controls and physics
- **Tile.pde**: Basic building blocks for levels
- **Gate.pde**: Logic gate implementations (AND, OR, XOR, etc.)
- **SwitchTile.pde**: Interactive switches that provide input to gates
- **Level.pde**: Level loading and management
- **Goal.pde**: Level completion goal
- **LevelEditor.pde**: In-game level editor
- **Button.pde**: UI components for menus

## Credits

Created by [Your Name] for the Circuit Rush project.

## License

This project is released under the MIT License. 