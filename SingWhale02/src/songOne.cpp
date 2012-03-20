//
//  songOne.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "songOne.h"

//------------------------------------------------------------------
void songOne::setup() {
    
    
}



//------------------------------------------------------------------
void songOne::update() {
    switch(mgr.getCurScene()) {
        case SONG_ONE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void songOne::activate() {
    mgr.setCurScene(SONG_ONE_FIRST);
    
    
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song One" << endl;
    
    
}

//------------------------------------------------------------------
void songOne::deactivate() {
    cout << "Deactivate songOne" << endl;
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songOne::draw() {
    cout << "Drawing songOne screen" << endl;
    
    
    drawGrid();
    ofDrawBitmapString("SONG ONE", ofGetWidth()/2, ofGetHeight()/2 + 20);
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case SONG_ONE_FIRST:
            
            ofEnableAlphaBlending();
            
            sceneName = "First Sub Scene!";
            
            ofSetColor(255, 255, 255); 
            //homeScreen.draw (0,0);    
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songOne::touchDown(ofTouchEventArgs &touch){
    //button.touchDown(touch);
}


//--------------------------------------------------------------
void songOne::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songOne::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
    if(button.isPressed()) {
        if(mgr.getCurScene() == SONG_ONE_TOTAL-1) {
            swSM->setCurScene(SCENE_CALL);
        } else  {
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
    button.touchUp(touch);
     
     */
}