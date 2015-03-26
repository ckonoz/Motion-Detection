/*
 * Grayscale
 *
 * Converts video to grayscale.
 *
 * Whenever R=G=B, you get gray;  to get the intensity of the gray, 
 * average the rgb values.  Output the old and new RGB values and 
 * display a grayscaled image
 *
 * Implements the Processing function filter(GRAY);
 *
 * Created May 2007 by rtomlinson
 * Modified 24 Sep 2007 by spc
 * Modified 08 Dec 2014 by Corinne Jean Konoza
 * Now uses Capture instead of PImage
 *
 */

void grayscale(Capture vid) {
   // for each pixel in pixels array
   vid.loadPixels();
   loadPixels();
   for (int col = 0; col < vid.width; col++) {
     for (int row = 0; row < vid.height; row ++) {
       // grab the color
       color c = vid.get(col, row);
       // grayscale intensity is average of RGB values
       float gray = red(c) + green(c) + blue(c);
       gray /= 3;
       c = color(gray, gray, gray);
       vid.set(col, row, c);
     }
   }
   updatePixels();
}
