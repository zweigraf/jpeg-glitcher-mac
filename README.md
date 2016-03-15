# jpeg-glitcher-mac
Glitching JPEGs. One at a time.

## Dependencies 

None. Until now at least.

## Usage

Open ```JPEGGlitcher.xcodeproj``` and ```Run``` the ```JPEGGlitcher``` scheme. Click "New Image" to open an image. 
The image will be modified (glitched) and the modified version displayed in the window. 
Click "Reglitch" until you are satisfied with the output. Then, click "Export Image" to save the glitched image to your disk.

This tool works best when modifying JPEG images, but also sometimes works on PNG images.

## Details

The algorithm (```ViewController.glitchData()```) currently selects up to ten consecutive bytes at a random point 
in the binary representation of the image and modifies them randomly. 

Results vary from not noticeable to "completely broke the image". 

## Known Issues

- selecting really wide images will widen the window considerably, making it basically unusable

