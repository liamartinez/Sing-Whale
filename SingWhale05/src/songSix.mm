//
//  songSix.cpp
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songSix.h"

//------------------------------------------------------------------
void songSix::setup() {
}



//------------------------------------------------------------------
void songSix::update() {
    switch(mgr.getCurScene()) {
        case SONG_SIX_FIRST:
            theWhale.update();
            break;            
    }
}

//------------------------------------------------------------------
void songSix::activate() {
    mgr.setCurScene(SONG_SIX_FIRST);
    
    for (int i = 0; i < SONG_SIX_TOTAL; i++) {
        songSix[i].loadImage("story/6-" + ofToString(i) + ".png"); 
    }

    cout << "Activate Song Six" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);
    
    button.setPos(0, 0);
    button.setSize(ofGetWidth(), ofGetHeight()-300);
    
}

//------------------------------------------------------------------
void songSix::deactivate() {
    cout << "Deactivate songSix" << endl;
    for (int i = 0; i < SONG_SIX_TOTAL; i++) {
        songSix[i].clear(); 
    }
}


//------------------------------------------------------------------
void songSix::draw() {
    
    
    button.draw();
    drawGrid();
    ofTranslate(0, tweenVal);    
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255); 
    
    string message = "";
    //int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_SIX_FIRST:
            songSix[SONG_SIX_FIRST].draw(0,0);             
            break;
            
        case SONG_SIX_SECOND:
            songSix[SONG_SIX_SECOND].draw(0,0);             
            break;
            
        case SONG_SIX_THIRD:
            songSix[SONG_SIX_THIRD].draw(0,0);             
            break;
            
        case SONG_SIX_FOURTH:
            songSix[SONG_SIX_FOURTH].draw(0,0);             
            break;

            
    }
    
    ofDisableAlphaBlending();
    
    
    //ofSetColor(0);
    //textW = swAssets->nevis48.getStringWidth(message);
    //swAssets->nevis48.drawString(message, textStart.x - textW/2, textStart.y);
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songSix::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void songSix::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void songSix::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(button.isPressed()) {
        if(mgr.getCurScene() < SONG_SIX_TOTAL - 1) {
            //cout << "less than max" << mgr.getCurScene() << endl; 
            mgr.setCurScene(mgr.getCurScene() + 1); 
        } else if (mgr.getCurScene() == SONG_SIX_TOTAL - 1) {
            mgr.setCurScene(SONG_SIX_FIRST);
        }

    }
    button.touchUp(touch);
}

//--------------------------------------------------------------

void songSix::touchDoubleTap(ofTouchEventArgs &touch){
    
}