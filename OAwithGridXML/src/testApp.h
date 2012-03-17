#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxMaxim.h"
#include "baseButton.h"
#include "ofxFreeType2.h"
#include "ofxXmlSettings.h"
#include <sys/time.h>

#include "grid.h"


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

	ofxMaxiFFT mfft;
	int fftSize;
    
    vector <float>  heightHistory; 
    int     sampleSize; 

    float   numCounted;
    int     highest; 
    
    int             theBin;
    vector<int>     theBins;
    
    grid            guide; 
    grid            grid; 

	//UI
    baseButton      beginButt; 
    bool            begin; 
    ofxFreeType2    whitneySemiBold22;
    
    baseButton      skeletonButt;
    baseButton      resetButt; 
    bool            reset; 
    
    baseButton      saveButt;
    bool            saveMe; 
    
    baseButton      loadButt;
    bool            loadMe; 
    
    baseButton      checkButt;
    bool            checkMe; 
    
    //saving
    void            saveSong(); 
    void            loadSong(); 
    vector<int>     savedBins; 
    
    //checking
    bool            checkSong(); 
    string          message; 
    int             threshold; 
    
};


