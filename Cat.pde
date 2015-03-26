/* 
 * Cat 
 * 
 * Uses triangles and an ellipse to create the shape of a cat's head.
 *
 * Floats x and y describe the cat's position. Floats w and h
 * give the width and height of the desired feline.
 *
 * Created 07 Dec 2014 by Corinne Jean Konoza
 *
 *
 */
 
void cat(int x, int y, int w, int h) {
  smooth();
  noStroke();
  // Make each cat a random color
  fill(random(0,255),random(0,255),random(0,255));

  ellipseMode(CORNER);
  // Head
  ellipse(x,y-(h*0.25),w,h*0.75);
  beginShape(TRIANGLES);
  // Left ear
  vertex(x,y);
  vertex(x+(w*(1.0/3)),y-(h*0.25));
  vertex(x,y-(h*0.5));
  // Right ear
  vertex(x+w,y);
  vertex(x+w,y-(h*0.5));
  vertex(x+(w*(2.0/3)),y-(h*0.25));
  endShape();

}
