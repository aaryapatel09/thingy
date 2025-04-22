# Importing Circuit Rush into Eclipse

1. Install Processing from https://processing.org/download/
2. Run ./download_processing.sh to download the Processing core.jar
3. Create an Eclipse project:
   - File > New > Java Project
   - Name it "CircuitRush"
   - Click Finish
4. Copy the project files:
   - Copy all .pde files to the project src folder
   - Create a folder called "data" in the project and copy level files there
   - Add core.jar to the build path (Right-click project > Build Path > Add External JARs)
5. Create a Java wrapper class:
   - Right-click src folder > New > Class
   - Name it "CircuitRushApp"
   - Make it extend PApplet
   - Add a main method that calls PApplet.main("CircuitRushApp")
   - Convert all top-level Processing functions to class methods

Alternative: Use Processing's Export to Application feature to create a runnable jar.
