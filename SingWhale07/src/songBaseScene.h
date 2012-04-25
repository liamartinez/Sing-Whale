//
//  songBaseScene.h
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_songBaseScene_h
#define SingWhale01_songBaseScene_h

#pragma once
#include "songSceneManager.h"
#include "swAssetManager.h"
#include "ofxSceneManagerScene.h"
#include "ofxTweenzor.h"



#include "whaleMove.h"
//#include "baseButton.h"

class songZero; 
class songSceneManager; //why is there a class declared here? 

class songBaseScene : public ofxSceneManagerScene {
public:
    songBaseScene();
    virtual void setup();
    virtual void update();
    virtual void draw();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);    
    void touchDoubleTap(ofTouchEventArgs &touch);
    
    void audioReceived 	(float * input, int bufferSize, int nChannels);
    
    
    string sceneName; //?
    
    songSceneManager* songSM;
    swAssetManager* swAssets;
    
    ofxSceneManager2 mgr;
    void drawGrid();
    void drawArrow(); 
    
    ofImage speakScreen;
    
    bool    drawSongMenu; 
    
    ofVec2f textStart; 
    
    void drawCircle(); 
    ofVec2f  circleLoc; 
    
    //whaleMove   theWhale; 
    
    //animate a little 
    float floatVal(); 
    float       amplitude;
    float       period; 
    float       dx;
    float       theta; 
    
    float       tweenVal; 
    
    ofImage arrow; 

    //scene pictures
    
    /*
    ofImage songZeroPic[5]; 
    ofImage songOnePic; 
    ofImage songTwoPic[3]; 
    ofImage songThreePic[3];
    ofImage songFourPic[2];
    ofImage songFivePic[2];
     */

    ofSoundPlayer whaleSounds[8];
    
    bool playWhales; 
    
protected:
    
};

#endif