//
//  songFour.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songFour.h"

//------------------------------------------------------------------
void songFour::setup() {
    
    
}



//------------------------------------------------------------------
void songFour::update() {
    switch(mgr.getCurScene()) {
        case SONG_FOUR_FIRST:
            theWhale.update();
            break;            
    }
}

//------------------------------------------------------------------
void songFour::activate() {
    mgr.setCurScene(SONG_FOUR_FIRST);
    
    for (int i = 0; i < SONG_FOUR_TOTAL; i++) {
        songFour[i].loadImage("story/4-" + ofToString(i) + ".png"); 
    }
    
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Four" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);
    
    button.setPos(0, 0);
    button.setSize(ofGetWidth(), ofGetHeight()-300);
    
    
}

//------------------------------------------------------------------
void songFour::deactivate() {
    cout << "Deactivate songFour" << endl;
    for (int i = 0; i < SONG_FOUR_TOTAL; i++) {
        songFour[i].clear();  
    }
    
}


//------------------------------------------------------------------
void songFour::draw() {
    
    
    button.draw();
    drawGrid();
    ofTranslate(0, floatVal());    
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255); 
    
    string message = "";
    //int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_FOUR_FIRST:
            songFour[SONG_ZERO_FIRST].draw(0,0);             
            break;
            
        case SONG_FOUR_SECOND:
            songFour[SONG_ZERO_SECOND].draw(0,0);             
            break;
    }
    
    ofDisableAlphaBlending();
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songFour::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void songFour::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songFour::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(button.isPressed()) {
        if(mgr.getCurScene() < SONG_FOUR_TOTAL - 1) {
            mgr.setCurScene(mgr.getCurScene() + 1); 
        }
    }
    button.touchUp(touch);
}

//--------------------------------------------------------------

void songFour::touchDoubleTap(ofTouchEventArgs &touch){
    
}