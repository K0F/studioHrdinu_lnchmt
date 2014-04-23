//import processing.opengl.*;
//import javax.media.opengl.GL;
import oscP5.*;
import netP5.*;


OscP5 oscP5;

import ddf.minim.*;
import ddf.minim.analysis.*;

float AMP = 3.0;

float data[];
int NUMBER_OF_VALUES = 9;

//PGraphicsOpenGL pgl; //need to use this to stop screen tearing
//GL gl;

Minim minim;
AudioInput in;

FFT fft;

int port = 8888;


/////////////////////////////////////////

float w = 12;
float h = 10;

float speed = 241.3;
float cycle = 50.0;
float amp= 800.0;

boolean inverse = false;

boolean showFFT = false;

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

  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.logAverages(60,3);

  data = new float[fft.avgSize()];

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

  float shift[] = new float[data.length];

  for (float x = 0 ;x<width ;x+=w) {

    float one = noise(frameCount/10.0);
    
    float sum = 1.0;

    for(int i = 0 ; i < data.length;i++){
      shift[i] = sin(frameCount/speed+x/(1000.0/(i/2.0+1.0)))*data[i]*((i+1.0)/5.0)*AMP;
      sum += shift[i];
    }


   
   /* 
    for(int i = 0 ; i < data.length;i++){
      shift += sin(((float)x)/(data[i]*100.0)+frameCount/1000.0)*data[i]*10.0;
    }
*/

    
    //noise(frameCount/10000.0+x/1000.0+val)*sin( x / cycle + frameCount / speed ) * amp;

    for (float y = (int)(-amp) ;y<height + amp;y+=h*2) {




      fill(inverse?255:0);
      rect(x, (y+sum+height*5)%height-h, w, h);
    }

    stroke(0);
    line(x, 0, x, height);
  }

  fill(255);

  fft.forward(in.mix);

  float smoothing = 20.0;

    for(int i = 0; i<fft.avgSize(); i++){
     // int w = int(width/fft.avgSize());    
      data[i] += (fft.getAvg(i)-data[i])/smoothing;
    //  rect(i*w,0,w,fft.getAvg(i)*10.0);
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
