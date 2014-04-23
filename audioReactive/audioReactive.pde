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

float w = 12;
float h = 10;

float speed = 241.3;
float cycle = 50.0;
float amp= 800.0;

boolean inverse = false;



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

float val = 0.0;

void draw() {

  background(inverse?0:255);

  noStroke();

  val += (noise(frameCount/30.0)-val)/((noise(millis()/100.0))*40.0);

  int cnt = 0;

  for (float x = 0 ;x<width ;x+=w) {
    
    float one = noise(frameCount/10.0);
    

    float shift = noise(frameCount/10000.0+x/1000.0+val)*sin( x / cycle + frameCount / speed ) * amp;

    for (float y = (int)(-amp) ;y<height + amp;y+=h*2) {




      fill(inverse?255:0);
      rect(x, y+shift, w, h);
    }

    stroke(0);
    line(x, 0, x, height);
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
