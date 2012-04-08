#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "dorwing.h" 
#include "ofxMaxim.h"
#include "baseButton.h"
#include "ofxXmlSettings.h"
#include "song.h"

#define NUMREADINGS 10
#define SAMPLESIZE 100
#define THRESHOLD 50 

class testApp : public ofxiPhoneApp {
	
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
    
    void setupButtons(); 
    void drawButtons(); 
    void touchUpButtons(ofTouchEventArgs &touch);
    void touchDownButtons(ofTouchEventArgs &touch); 
	
	int		initialBufferSize; /* buffer size */ 
	int		sampleRate;
	
    int		drawCounter, bufferCounter;
	float 	* buffer;
    	
	/* stick you maximilian stuff below */
	
	ofxMaxiFFTOctaveAnalyzer oct;
	int nAverages;
    
	ofxMaxiFFT mfft;
	int fftSize;
    
    //smoothing the values
    int    readings [NUMREADINGS]; 
    int    index, total, average; 
    
    ofTrueTypeFont TTF;
    dorwing singing; 
    dorwing guide; 
    
    int     highest; 
    
    int             theBin;
    vector<int>     theBins;
    
    ofxFreeType2    whitneySemiBold22;
    
    baseButton      beginButt; 
    bool            begin; 
    baseButton      resetButt; 
    bool            reset; 
    baseButton      skeletonButt;    
    baseButton      saveButt;
    bool            saveMe; 
    baseButton      loadButt;
    bool            loadMe; 
    baseButton      checkButt;
    bool            checkMe; 
    baseButton      nextButt; 
    bool            nextMe; 
    
    //saving
    void            saveSong(int numSong); 
    void            loadSong(); 
    int             numberOfSongs; 
    vector<vector<int> >     songCount; 
    int             numSong; //counter outside
    vector<song>    songs; 
    int             whichSong;
    
    //checking
    bool            checkSong(); 
    string          message; 

};


