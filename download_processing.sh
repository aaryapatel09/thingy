#!/bin/bash
mkdir -p lib
echo "Downloading Processing Core library..."
curl -L https://github.com/processing/processing4/releases/download/processing-1293-4.3/processing-4.3-macos-x64.zip -o processing.zip
unzip -q processing.zip
cp Processing.app/Contents/Java/core/library/core.jar lib/
rm -rf processing.zip Processing.app
echo "Processing Core library downloaded to lib/core.jar"
