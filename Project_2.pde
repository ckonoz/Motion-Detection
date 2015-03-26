/* 
 * Motion Detected Space Cat
 *
 * Small stars randomly appear all over the video to add to the
 * bleak outerspace setting. A large colorful space traveling cat 
 * follows any detected motion on the screen. 
 * Using Pure Data, notes produced by sine waves play with respect 
 * to the detected motion's location on the screen as well.
 *
 * Created 08 Dec 2014 by Corinne Jean Konoza
 * CS 276 Final Project
 * 
 */

import processing.video.*;
import oscP5.*;
import netP5.*;

// Global variables for connecting Pure Data
OscP5 oscP5;
NetAddress myRemoteLocation;

// Global variables for capturing video
Capture video;
 
// Global variables used for detecting motion
PImage prevFrame;
float threshold = 150;
int Mx = 0;
int My = 0;
int ave = 0;
int motionX = width/2;
int motionY = height/2;
int rsp = 25;
 
void setup() {
  // Initialize screen size
  size(640,480);
  
  // Connect to port 12000 to connect with Pure Data sketch
  oscP5 = new OscP5(this,12000);
  myRemoteLocation = new NetAddress("127.0.0.1",12000);
  
  // Set up the camera
  video = new Capture(this, width, height, 24);
  
  // Create image to compare video with
  prevFrame = createImage(video.width,video.height,RGB);
  
  // Start the video
  video.start();
}
 
void draw() {
  // Begin video and display
  if (video.available()) {
    prevFrame.copy(video,0,0,video.width,video.height,0,0,video.width,video.height); 
    prevFrame.updatePixels();
    video.read();
    grayscale(video);
  }
  
  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();

  // Code for comparing pixels in video and prevFrame to detect motion
  Mx = 0;
  My = 0;
  ave = 0;
  
  // Parse through all pixels in video and prevFrame using for loops
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      
      // Generate color of current pixel location
      int loc = x + y*video.width;            
      color current = video.pixels[loc];      
      color previous = prevFrame.pixels[loc]; 
      
      // Compare RGB values from colors of pixels in video
      // and prevFrame and find the difference
      float r1 = red(current); 
      float g1 = green(current); 
      float b1 = blue(current);
      float r2 = red(previous); 
      float g2 = green(previous); 
      float b2 = blue(previous);
      float diff = dist(r1,g1,b1,r2,g2,b2);
      
      // If the difference between colors is larger than the
      // threshold value then there is motion at that location
      if (diff > threshold) { 
        pixels[loc] = video.pixels[loc];
        Mx += x;
        My += y;
        ave++;
      } else {
        pixels[loc] = video.pixels[loc];
      }
    }
  }
  
  // Average of where motion was detected to make star steadier
  if(ave != 0){ 
    Mx = Mx/ave;
    My = My/ave;
  } 
 
  if (Mx > motionX + rsp/2 && Mx > 50){
    motionX+= rsp;
  } else if (Mx < motionX - rsp/2 && Mx > 50){
    motionX-= rsp;
  }
  
  if (My > motionY + rsp/2 && My > 50){
    motionY+= rsp;
  } else if (My < motionY - rsp/2 && My > 50){
    motionY-= rsp;
  }
    
  updatePixels();
  noStroke();
  
  // Draw large cat at location of motion
  cat(motionX, motionY, 100, 100); 
  
  // Draw other smaller stars to add variety to the video
  star(random(0,width), random(0,height), 12, 5); 
  star(random(0,width), random(0,height), 12, 5); 
  
  // Use the pythagorean theorem to create location value
  float val = sqrt(pow(motionX,2) + pow(motionY,2));
  
  // Play sounds according to location value created
  OscMessage myMessage = new OscMessage("/test");
  myMessage.add(val);
  oscP5.send(myMessage, myRemoteLocation); 
  
}

// Method used to transfer messages between Processing and PureData
void oscEvent(OscMessage theOscMessage) {
  print("## recieved an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}  
   
