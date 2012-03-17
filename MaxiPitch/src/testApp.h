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
	
	float 	* lAudioOut; /* outputs */
	float   * rAudioOut;
    
	float * lAudioIn; /* inputs */
	float * rAudioIn;
	
	int		initialBufferSize; /* buffer size */ 
	int		sampleRate;
    
	/* stick you maximilian stuff below */
	/*
	double wave,sample,outputs[2], ifftVal;
	maxiMix mymix;
	maxiOsc osc;
	
	ofxMaxiFFTOctaveAnalyzer oct;
	int nAverages;
	float *ifftOutput;
	int ifftSize;
	
	ofxMaxiIFFT ifft;
	ofxMaxiFFT mfft;
	int fftSize;
	int bins, dataSize;
	
	float callTime;
	timeval callTS, callEndTS;
     */
    
	/* from PI */
     ofSoundStream soundStream;
	
	double outputs[2], wave;
    ofxMaxiOsc sine, sine1, sine2;
    int bin_number, bin_number1, bin_number2; float largests[3];
    
    ofxMaxiFFT fft; 
    ofxMaxiMix mix;
    float *inputL, *inputR;
    float estimatedPitch[3];
};


