#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxMaxim.h"
#include <sys/time.h>


class testApp : public ofxiPhoneApp{
    
public:
    ~testApp();/* deconsructor is very useful */
    void setup();
    void update();
    void draw();
    void exit();
    
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);
    void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
	
	void audioRequested 	(float * input, int bufferSize, int nChannels); /* output method */
	void audioReceived 	(float * input, int bufferSize, int nChannels); /* input method */
	
	
	int		initialBufferSize; /* buffer size */ 
	int		sampleRate;
	
    int		drawCounter, bufferCounter;
	float 	* buffer;
    
    float   scaledAve;
    float   smoothedAve;
	
	/* stick you maximilian stuff below */
	
	ofxMaxiFFTOctaveAnalyzer oct;
	int nAverages;
	float *ifftOutput;
	int ifftSize;
    	
	ofxMaxiIFFT ifft;
	ofxMaxiFFT mfft;
	int fftSize;
    
    vector <float>  aveHistory; 

    float   numCounted;
    int     highest; 
    
	
	
	
};


