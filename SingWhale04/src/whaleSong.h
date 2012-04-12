//
//  whaleSong.h
//  SingWhale03
//
//  Created by Lia Martinez on 3/20/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale03_whaleSong_h
#define SingWhale03_whaleSong_h

#pragma once
#include <Accelerate/Accelerate.h>
#include "ofxMaxim.h"
#include "ofxiPhoneExtras.h"
#include "baseButton.h"
#include "ofxFreeType2.h"
#include "ofxXmlSettings.h"
#include "Tweenzor.h"
#include "ofxTweenzor.h"

#include "songPhrase.h"
#include "dorwing.h"

#define NUMREADINGS 10
#define SAMPLESIZE 70
#define THRESHOLD 50 

class testApp; 

class whaleSong  {
    
public:
    whaleSong(); 
    ~whaleSong();/* deconsructor is very useful */
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
	void audioReceivedIn(ofAudioEventArgs &args);
    
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
    ofxFreeType2    whitneySemiBold22;
    dorwing singing; 
    dorwing guide; 

    int     highest; 
    
    int             theBin;
    vector<int>     theBins;

	//UI    
    baseButton      beginButt; 
    bool            begin; 

    baseButton      skeletonButt;
    baseButton      resetButt; 
    bool            reset; 
    
    baseButton      saveButt;
    bool            saveMe; 
    
    baseButton      checkButt;
    bool            checkMe; 
    
    baseButton      correctButt;
    baseButton      tryAgainButt; 
    bool            correct;
    baseButton      checkDebugButt; 
    bool            checked; 

    //saving
    void            loadSong(string XMLname); 
    vector<int>     savedBins; 
    //ofxiPhoneFile   songData; 
    int             numberOfSongs; 
    vector<songPhrase>    songs; 
    int             whichSong;
    
    //checking
    bool            checkSong(); 
    string          message; 
    
    //setting
    void            setSong(int whichSong_);
    
    //clearing
    void            letsReset(); 
    
    //location for dorwing
    ofVec2f         songLoc; 
    int             songHeight; 
    
};

#endif
