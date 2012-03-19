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
    }
}

//------------------------------------------------------------------
void callScene::activate() {
    //start with the first scene when activated. 
    mgr.setCurScene(CALL_SCENE_FIRST);
    
    //load here, not setup
    callScreen.loadImage("images/wires-02.png");
    next.setLabel("NEXT", &swAssets->nevis22);
    song = " -> SONG INTERFACE HERE <- " ; 


    cout << "Activate Call" << endl;
    
    
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
    next.draw(ofGetWidth() - 200, ofGetHeight()-100); 


    string message = "";
    switch(mgr.getCurScene()) {
        case CALL_SCENE_FIRST:
            message = "Hi! Before anything else, let's call Plulu"; 
            break;
            
        case CALL_SCENE_SECOND:
            message = "This is how you say her name."; 
            ofDrawBitmapString(song, ofGetWidth()/2 - 300, ofGetHeight() - ofGetHeight()/4);
            break;
            
        case CALL_SCENE_THIRD:
            message = "Wheee! You did it! Here comes Plulu!"; 
            break;
    }
    

    ofSetColor(8, 44, 49);
    ofDrawBitmapString(message, 300, ofGetHeight()/3); 
    
}



//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void callScene::touchDown(ofTouchEventArgs &touch){
    next.touchDown(touch);
}


//--------------------------------------------------------------
void callScene::touchMoved(ofTouchEventArgs &touch){
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
    next.touchUp(touch);
}