//import processing.opengl.*;
//import javax.media.opengl.GL;
import oscP5.*;
import netP5.*;

OscP5 oscP5;

import ddf.minim.*;

float data[];
int NUMBER_OF_VALUES = 9;

//PGraphicsOpenGL pgl; //need to use this to stop screen tearing
//GL gl;

Minim minim;
AudioInput in;

int port = 8888;

/////////////////////////////////////////

float sc = 1.5;
int start = 0;
float trsh = 0.12;

/////////////////////////////////////////

void init(){
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  super.init();
}

/////////////////////////////////////////

void setup()
{
  size(1280,720,P2D);

  oscP5 = new OscP5(this,port);
  
  frameRate(60);

  data = new float[NUMBER_OF_VALUES];

/*
   pgl = (PGraphicsOpenGL) g; //processing graphics object
   gl = pgl.beginGL(); //begin opengl
   gl.setSwapInterval(1); //set vertical sync on
   pgl.endGL(); //end opengl
*/

  minim = new Minim(this);
  //minim.debugOn();

  in = minim.getLineIn();
  in.disableMonitoring();  

  noSmooth();
}

/////////////////////////////////////////

void oscEvent(OscMessage theOscMessage) {
  if(theOscMessage.checkAddrPattern("/control")==true) {
    for(int i = 0 ; i < data.length;i++)
      data[i] = (float)theOscMessage.get(i).floatValue();
  }
}

void draw()
{

  if(frameCount < 5)
    frame.setLocation(0,0);
  
  noStroke();

  //start = 0;

  // detekce

/*
  for(int i = 0; i < 200 ; i++)
  {


    if(in.right.get(i)<0.01) {
      if(in.right.get(i+1)<0.01) {

        for(int q = 2;q<100;q++) {
          if(abs(in.right.get(i+q)-0)>trsh) {
            start = i;
            break;
          }
        }
        break;
      }
    }
  }
*/
  
  for(int i = 0; i < height; i++){
    stroke(in.left.get(i)*255);
    line(0,i,width,i);
  }
}

/////////////////////////////////////////

void stop()
{
  in.close();
  minim.stop();
  super.stop();
}

/////////////////////////////////////////
