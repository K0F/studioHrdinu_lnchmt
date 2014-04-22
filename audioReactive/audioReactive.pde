

//import processing.opengl.*;
//import javax.media.opengl.GL;
import ddf.minim.*;

//PGraphicsOpenGL pgl; //need to use this to stop screen tearing
//GL gl;

Minim minim;
AudioInput in;

float sc = 1.5;
int start = 0;

void setup()
{
  size(1280,720,P2D);

  frameRate(60);

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


void draw()
{
  float trsh = 0.12;
  noStroke();

  //start = 0;

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
  
  for(int i = 0; i < height; i++)
  {
    stroke(in.left.get(i)*255);
    line(0,i,width,i);
  }
}


void stop()
{
  in.close();
  minim.stop();
  super.stop();
}