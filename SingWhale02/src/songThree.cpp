//
//  songFour.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songThree.h"

//------------------------------------------------------------------
void songThree::setup() {
    
    
}



//------------------------------------------------------------------
void songThree::update() {
    switch(mgr.getCurScene()) {
        case SONG_THREE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void songThree::activate() {
    mgr.setCurScene(SONG_THREE_FIRST);
    
    
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Three" << endl;
    
    
}

//------------------------------------------------------------------
void songThree::deactivate() {
    cout << "Deactivate songThree" << endl;
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songThree::draw() {
    cout << "Drawing songThree screen" << endl;
    
    
    drawGrid();
    ofDrawBitmapString("SONG THREE", ofGetWidth()/2, ofGetHeight()/2 + 20);
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case SONG_THREE_FIRST:
            
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
void songThree::touchDown(ofTouchEventArgs &touch){
    //button.touchDown(touch);
}


//--------------------------------------------------------------
void songThree::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songThree::touchUp(ofTouchEventArgs &touch){
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