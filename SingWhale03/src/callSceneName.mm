//
//  callSceneName.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "callSceneName.h"

//------------------------------------------------------------------
void callSceneName::setup() {
    
    
}



//------------------------------------------------------------------
void callSceneName::update() {
    switch(mgr.getCurScene()) {
        case CALL_SCENE_FIRST:
            //Do stuff
            break;  
        case CALL_SCENE_SECOND:
            //Do stuff
            break;    
        case CALL_SCENE_THIRD:
            //Do stuff
            break;    
    }
}

//------------------------------------------------------------------
void callSceneName::activate() {
    //start with the first scene when activated. 
    mgr.setCurScene(ofRandom(CALL_SCENE_NAME_TOTAL));
    
    
    
    //load here, not setup
    callScreen.loadImage("images/BG.png");
    callDuck.loadImage("images/call1.png");
    callPail.loadImage("images/call3.png");
    next.setLabel("CORRECT", &swAssets->nevis22);
    tryAgain.setLabel("TRY AGAIN", &swAssets->nevis22);
    song = " -> SONG INTERFACE HERE <- " ; 

    cout << "Activate CallName" << endl;
    
    
}

//------------------------------------------------------------------
void callSceneName::deactivate() {
    cout << "Deactivate CallName" << endl;
    
    callScreen.clear();
    callDuck.clear(); 
    callPail.clear(); 
    
}


//------------------------------------------------------------------
void callSceneName::draw() {
    cout << "Drawing CallName screen" << endl;
    
    ofSetColor(255, 255, 255);
    callScreen.draw(0,0);
    
    
    string message = "";
    next.draw(ofGetWidth() - 550, ofGetHeight()-100); 
    tryAgain.draw(ofGetWidth()/2 - 300, ofGetHeight()-100); 

    switch(mgr.getCurScene()) {
        case CALL_SCENE_NAME_DUCK:
            ofEnableAlphaBlending();
            callDuck.draw(0,0);
            ofDisableAlphaBlending(); 
            message = "You did it wrong! You called a duck!"; 
            break;
            
        case CALL_SCENE_NAME_PAIL:
            ofEnableAlphaBlending();
            ofSetColor(255, 255, 255);
            callPail.draw(0,0);
            ofDisableAlphaBlending(); 
            message = "You called a pail! A pail is not a WHALE"; 
            break;
            
        case CALL_SCENE_NAME_SNAIL:
            message = "Okay, that's a snail. You are getting closer"; 
            break;
    }
    
    ofSetColor(8, 44, 49);
    ofDrawBitmapString(message, 300, ofGetHeight()/3); 
    ofDrawBitmapString(song, ofGetWidth()/2 - 300, ofGetHeight() - ofGetHeight()/4);
    
    
}



//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void callSceneName::touchDown(ofTouchEventArgs &touch){
    tryAgain.touchDown(touch);
    next.touchDown(touch);
}


//--------------------------------------------------------------
void callSceneName::touchMoved(ofTouchEventArgs &touch){
    tryAgain.touchMoved(touch);
    next.touchMoved(touch);
}


//--------------------------------------------------------------
void callSceneName::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(tryAgain.isPressed()) mgr.setCurScene(ofRandom(CALL_SCENE_NAME_TOTAL));  
    
    if(next.isPressed()) swSM->setCurScene(SCENE_CALL); 

    tryAgain.touchUp(touch);
    next.touchUp(touch);
}