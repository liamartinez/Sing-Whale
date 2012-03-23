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


#include "ofMain.h"
#include "ofxiPhoneExtras.h"
#include <Accelerate/Accelerate.h>
#include "ofxMaxim.h"
#include "baseButton.h"
#include "ofxFreeType2.h"
#include "ofxXmlSettings.h"
#include "ofxiPhoneFile.h"
//#include <sys/time.h>

#include "grid.h"

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
	void audioReceived 	(float * input, int bufferSize, int nChannels); /* input method */
	//void audioReceived(ofAudioEventArgs & audio);
	
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
    int     gridLen; 
    int     sampleSize; 
    int     tightness; 
    
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
    ofxiPhoneFile   songData; 
    
    //checking
    bool            checkSong(); 
    string          message; 
    int             threshold; 
    
};

#endif
