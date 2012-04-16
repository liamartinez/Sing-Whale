//
//  speakScene.h
//  SingWhale01
//
//  Created by Lia Martinez on 2/27/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_speakScene_h
#define SingWhale01_speakScene_h

#pragma once

#include "swBaseScene.h"
#include "songBaseScene.h"
#include "swAssetManager.h"

#include "songSceneManager.h"

#include "ofxTweenzor.h"

//create the main scenes
#include "songZero.h"
#include "songOne.h"
#include "songTwo.h"
#include "songThree.h"
#include "songFour.h"
#include "songFive.h"
#include "songSix.h"
#include "songSeven.h"
#include "songEight.h"
#include "songNine.h"
#include "songWrong.h"

// menu
#include "swMenu.h"

//whalesong
#include "whaleSong.h"


/*
enum {
    SPEAK_SCENE_FIRST,
    SPEAK_SCENE_TOTAL
};
 */

class speakScene : public swBaseScene {
public:
    void setup();
    void update();
    void draw();
    
    void activate(); 
    void deactivate();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    
    void audioReceived 	(float * input, int bufferSize, int nChannels);
    //void audioReceived(ofAudioEventArgs &audio);
    
    
    baseButton button;
    ofxFreeType2    whitneySemiBold22;
    
    songBaseScene* songs[SONG_TOTAL_SCENES];
    
    //Managers
    songSceneManager* songSM;
    swAssetManager* swAssets;
    
    //Menu
    swMenu songMenu;
    
    //whalesong
    whaleSong wSong; 

    bool            showSongButtons; 
    baseButton      showSongButt; 
    
    bool            switchOn; 
        
    //buttons and antenna
    ofImage buttonUp, buttonDown; 
    ofImage antenna; 
    ofImage antennaWaves[3]; 
    ofImage menuBG; 

    baseButton      startSingingButt; 

    
private:
    
    //ofImage speakScreen; //lia - replace pictures here. 
    /*
     ofImage homeScreen;
     ofImage postit; 
     */
    
    
};

#endif
