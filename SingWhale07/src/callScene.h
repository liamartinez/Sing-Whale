//
//  callScene.h
//  SingWhale01
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_callScene_h
#define SingWhale01_callScene_h

#pragma once
#include "swBaseScene.h"
#include "baseButton.h"
#include "whaleSong.h"

#include "ofxImageSequence.h"

enum {
    CALL_SCENE_FIRST,
    CALL_SCENE_SECOND,
    CALL_SCENE_THIRD,
    CALL_SCENE_FOURTH,
    CALL_SCENE_FIFTH,
    CALL_SCENE_SIXTH,
    CALL_SCENE_SEVENTH,
    CALL_SCENE_EIGHTH, 
    CALL_SCENE_NINTH, 
    CALL_SCENE_TENTH,
    CALL_SCENE_ELEVENTH,
    CALL_SCENE_TWELFTH, 
    CALL_SCENE_THIRTEENTH,
    CALL_SCENE_FOURTEENTH,
    CALL_SCENE_FIFTEENTH,
    CALL_SCENE_SIXTEENTH, 
    CALL_SCENE_SEVENTEENTH,   
    CALL_SCENE_EIGHTEENTH, 
    CALL_SCENE_NINETEENTH, 
    CALL_SCENE_TOTAL
};

class callScene : public swBaseScene {
public:
    void setup();
    void update();
    void draw();
    
    void activate(); 
    void deactivate();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);

    //void audioReceived 	(float * input, int bufferSize, int nChannels);
    
    baseButton  next;
    baseButton  tryAgain; 
    baseButton  back; 
    ofImage     leftArrow; 
    ofImage     rightArrow; 
    
    string song; 
    ofVec2f     textStart; 
    
    whaleSong   wSong; 
    whaleSong   nameSong; 
    
    ofImage     BG; 
    
    baseButton      turtleButt; 
    ofImage     turtle;
    bool        letsSing; 
    
    //tweens
    float         strobey; 
    ofRectangle     guideArea; 
    int         songPos, songPos2; 
    
    bool layla1Play; 
    
private:
    
    bool    hasReturned; 
    ofImage callScreen; //lia - replace pictures here. 
    ofImage callWhale; 
    
    ofImage turtleBigLeft, turtleBigRight, turtleSmall, turtleMed1, turtleMed2; 
    ofImage laylaBG, laylaPic; 
    ofSoundPlayer laylaName, laylaFace, laylaHello; 
    
    /*
    ofImage laylaNameSq[136]; 
    ofImage laylaFaceSq[138];
    ofImage laylaHelloSq[107];
     */
    
    ofxImageSequence laylaNameSq;
    ofxImageSequence laylaFaceSq; 
    ofxImageSequence laylaHelloSq; 
    

    bool layla1, layla2, layla3; 
    
    float percent1, percent2, percent3; 

};

#endif
