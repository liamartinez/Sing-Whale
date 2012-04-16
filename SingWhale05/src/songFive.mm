//
//  songFive.cpp
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songFive.h"

//------------------------------------------------------------------
void songFive::setup() {
    
    
}



//------------------------------------------------------------------
void songFive::update() {
    switch(mgr.getCurScene()) {
        case SONG_FIVE_FIRST:
            theWhale.update();
            break;            
    }
}

//------------------------------------------------------------------
void songFive::activate() {
    mgr.setCurScene(SONG_FIVE_FIRST);
    
    for (int i = 0; i < SONG_FIVE_TOTAL; i++) {
        songFive[i].loadImage("story/5-" + ofToString(i) + ".png"); 
    }
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Five" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);
    
    button.setPos(0, 0);
    button.setSize(ofGetWidth(), ofGetHeight()-300);
}

//------------------------------------------------------------------
void songFive::deactivate() {
    cout << "Deactivate songFive" << endl;
    
    for (int i = 0; i < SONG_FIVE_TOTAL; i++) {
        songFive[i].clear();  
    }
    
}


//------------------------------------------------------------------
void songFive::draw() {
    button.draw();
    drawGrid();
    ofTranslate(0, floatVal());    
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255); 
    
    string message = "";
    //int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_FIVE_FIRST:
            songFive[SONG_FIVE_FIRST].draw(0,0);             
            break;
            
        case SONG_FIVE_SECOND:
            songFive[SONG_FIVE_SECOND].draw(0,0);             
            break;
    }
    ofDisableAlphaBlending();
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songFive::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void songFive::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songFive::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(button.isPressed()) {
        if(mgr.getCurScene() < SONG_FIVE_TOTAL - 1) {
            mgr.setCurScene(mgr.getCurScene() + 1); 
        }
    }
    button.touchUp(touch);
}

//--------------------------------------------------------------

void songFive::touchDoubleTap(ofTouchEventArgs &touch){
    
}