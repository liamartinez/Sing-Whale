//
//  callScene.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "callScene.h"

//------------------------------------------------------------------
void callScene::setup() {
    
    hasReturned = false; 
    
}



//------------------------------------------------------------------
void callScene::update() {
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
        case CALL_SCENE_FOURTH:
            //Do stuff
            break;    
    }
}

//------------------------------------------------------------------
void callScene::activate() {
    //start with the first scene when activated. 
    
    if (hasReturned) {
        mgr.setCurScene(CALL_SCENE_FOURTH);
    } else {
        mgr.setCurScene(CALL_SCENE_FIRST);
    }
    
    //load here, not setup
    callScreen.loadImage("images/BG.png");
    callWhale.loadImage("images/call2.png");
    next.setLabel("NEXT", &swAssets->nevis22);
    tryAgain.setLabel("TRY AGAIN", &swAssets->nevis22);
    song = " -> SONG INTERFACE HERE <- " ; 

    cout << "Activate Call" << endl;
    textStart.set(ofGetWidth()/2, ofGetHeight()/3);
    
}

//------------------------------------------------------------------
void callScene::deactivate() {
    cout << "Deactivate Call" << endl;
    
    callScreen.clear();
    
}


//------------------------------------------------------------------
void callScene::draw() {
    cout << "Drawing Call screen" << endl;
    
    ofSetColor(255, 255, 255);
    callScreen.draw(0,0);
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    next.draw(ofGetWidth() - 550, ofGetHeight()-100); 

    switch(mgr.getCurScene()) {
        case CALL_SCENE_FIRST:
            message = "Hi! Before anything else, \n     let's call Plulu"; 

            break;
            
        case CALL_SCENE_SECOND:
            message = "This is how you say her name."; 
            ofDrawBitmapString(song, ofGetWidth()/2 - 300, ofGetHeight() - ofGetHeight()/4);
            break;
            
        case CALL_SCENE_THIRD:
            message = "Now you try."; 
            tryAgain.draw(ofGetWidth()/2 - 300, ofGetHeight()-100); 
            next.setLabel("CORRECT", &swAssets->nevis22);
            ofDrawBitmapString(song, ofGetWidth()/2 - 300, ofGetHeight() - ofGetHeight()/4);
            break;
            
        case CALL_SCENE_FOURTH:
            message = "Wheee! You did it! \nHere comes Plulu!"; 
            ofEnableAlphaBlending();
            callWhale.draw(0,0);
            next.setLabel("NEXT", &swAssets->nevis22);
            ofDisableAlphaBlending();
            break;
    }
    
    
    textW = swAssets->nevis48.getStringWidth(message);
    swAssets->nevis48.drawString(message, textStart.x - textW/2, textStart.y);
    
}



//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void callScene::touchDown(ofTouchEventArgs &touch){
    tryAgain.touchDown(touch);
    next.touchDown(touch);
}


//--------------------------------------------------------------
void callScene::touchMoved(ofTouchEventArgs &touch){
    tryAgain.touchMoved(touch);
    next.touchMoved(touch);
}


//--------------------------------------------------------------
void callScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(next.isPressed()) {
        if(mgr.getCurScene() == CALL_SCENE_TOTAL-1) {
            //go to the next scene when we're done. 
            swSM->setCurScene(SCENE_SPEAK);         } 
        else  {
            //otherwise, go to the next subscene. 
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
    
    if(tryAgain.isPressed()) {
        swSM->setCurScene(SCENE_CALL_NAME); 
        hasReturned = true;
    }

    tryAgain.touchUp(touch);
    next.touchUp(touch);
}