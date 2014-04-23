
// audio /////////////
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput aIn;

FFT fft;

//////////////////////

void setup(){
  size(400,300);

  // audio //////////////
  //
  minim = new Minim(this);
  aIn = minim.getLineIn();
  fft = new FFT(aIn.bufferSize(),aIn.sampleRate());
  fft.linAverages(24);
  aIn.enableMonitoring();
  minim.debugOn();
  ///////////////////////
}

void draw(){
  background(0);

  // audio ///////////////
  fft.forward(aIn.mix);
  for(int i = 0; i<fft.avgSize(); i++){
    int w = int(width/fft.avgSize());    
    fill(255);
    rect(i*w,0,w,fft.getAvg(i)*100);
  }
  ///////////////////////

}















