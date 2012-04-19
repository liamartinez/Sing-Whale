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
            theWhale.update();
            break;            
    }
}

//------------------------------------------------------------------
void songThree::activate() {
    mgr.setCurScene(SONG_THREE_FIRST);
    
    for (int i = 0; i < SONG_THREE_TOTAL; i++) {
        songThree[i].loadImage("story/3-" + ofToString(i) + ".png"); 
    }
    
    button.setPos(ofGetWidth() - 150,180);
    button.setImage(&arrow);
    
    cout << "Activate Song Three" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);

    
}

//------------------------------------------------------------------
void songThree::deactivate() {
    cout << "Deactivate songThree" << endl;
    
    for (int i = 0; i < SONG_THREE_TOTAL; i++) {
        songThree[i].clear(); 
    }
    
}


//------------------------------------------------------------------
void songThree::draw() {

    button.draw();
    drawGrid();
    ofTranslate(0, tweenVal);    
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255); 
    
    string message = "";
    //int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_THREE_FIRST:
            songThree[SONG_THREE_FIRST].draw(0,0);   
            button.draw();
            break;
            
        case SONG_THREE_SECOND:
            songThree[SONG_THREE_SECOND].draw(0,0);   
            button.draw();
            break;
            
        case SONG_THREE_THIRD:
            songThree[SONG_THREE_THIRD].draw(0,0);             
            break;
                        
    }
    
    ofDisableAlphaBlending();

    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songThree::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void songThree::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void songThree::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(button.isPressed()) {
            if(mgr.getCurScene() < SONG_THREE_TOTAL - 1) {
                mgr.setCurScene(mgr.getCurScene() + 1); 
            }
    }
    button.touchUp(touch);
}

//--------------------------------------------------------------

void songThree::touchDoubleTap(ofTouchEventArgs &touch){
    
}