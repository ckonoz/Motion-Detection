/* 
 * Star 
 * 
 * Uses lines to create a star shape
 *
 * Source code: https://processing.org/examples/star.html
 *
 * Floats x and y describe the star's position. Radius is the outer
 * radius. It is used to generate an inner radius 1/3 the size of the
 * given outer radius. The number of points can be changed by
 * manipulating npoints. 
 *
 * Modified 07 Dec 2014 by Corinne Jean Konoza
 *
 *
 */
 
void star(float x, float y, float radius, int npoints) {
  
  // Make each star a random color
  // fill(random(0,255),random(0,255),random(0,255));
  fill(255);

  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * (radius*(1.0/3.0));
    sy = y + sin(a+halfAngle) * (radius*(1.0/3.0));
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
