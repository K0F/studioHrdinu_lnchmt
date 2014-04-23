
// audio /////////////
import dff.minim.*;
import dff.minim.analysis.*;

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
  fft.linAverages(30);

  ///////////////////////
}

void draw(){

  // audio ///////////////
  fft.forward(aIn.mix);
  ///////////////////////

}

void 













