//
//  songTwo.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "songTwo.h"

//------------------------------------------------------------------
void songTwo::setup() {
    
    
}



//------------------------------------------------------------------
void songTwo::update() {
    switch(mgr.getCurScene()) {
        case SONG_TWO_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void songTwo::activate() {
    mgr.setCurScene(SONG_TWO_FIRST);
    
    
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Two" << endl;
    
    
}

//------------------------------------------------------------------
void songTwo::deactivate() {
    cout << "Deactivate songTwo" << endl;
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songTwo::draw() {
    cout << "Drawing songTwo screen" << endl;
    
    
    drawGrid();
    ofDrawBitmapString("SONG TWO", ofGetWidth()/2, ofGetHeight()/2 + 20);
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case SONG_TWO_FIRST:
            
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
void songTwo::touchDown(ofTouchEventArgs &touch){
    //button.touchDown(touch);
}


//--------------------------------------------------------------
void songTwo::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songTwo::touchUp(ofTouchEventArgs &touch){
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