#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

class testApp : public ofxiPhoneApp{
	
public:
	void setup();
	void update();
	void draw();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);

	void audioIn( float * input, int bufferSize, int nChannels );

	int		initialBufferSize;
	int		sampleRate;
	int		drawCounter, bufferCounter;
	float 	* buffer;
	
    //new
    
    void BandPass(float * in, float* out, float freq, float width,int note);

    float *left;
    float *right;
    
    float *BP;
    
    float *amplitude;
    float *BPin1;
    float *BPin2;
    float *BPout1;
    float *BPout2;
    
    float bandw;
    
    
    
};

