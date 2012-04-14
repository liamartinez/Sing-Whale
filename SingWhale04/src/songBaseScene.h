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

#include "whaleMove.h"
//#include "baseButton.h"

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
    
    ofImage speakScreen;
    
    bool    drawSongMenu; 
    
    ofVec2f textStart; 
    
    void drawCircle(); 
    ofVec2f  circleLoc; 
    
    whaleMove   theWhale; 
    
    //animate a little 
    float floatVal(); 
    float       amplitude;
    float       period; 
    float       dx;
    float       theta; 
    
    
protected:
    
};

#endif