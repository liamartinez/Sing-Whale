//
//  songZero.cpp
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songZero.h" 

//------------------------------------------------------------------
void songZero::setup() {
    
    
}



//------------------------------------------------------------------
void songZero::update() {
    switch(mgr.getCurScene()) {
        case SONG_ZERO_FIRST:
            theWhale.update();
            break;            
    }
}

//------------------------------------------------------------------
void songZero::activate() {
    
    gen = ofRandom(1);
    
    if (gen == 0) {
        mgr.setCurScene(SONG_ZERO_FIRST);
    } else {
        mgr.setCurScene(SONG_ZERO_THIRD);
    }
    
    
    
    for (int i = 0; i < SONG_ZERO_TOTAL; i++) {
        songZero[i].loadImage("story/0-" + ofToString(i) + ".png"); 
    }
    
    
    //songZero.loadImage("images/speak_sleepy.png");
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Zero" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);
    
    button.setPos(0, 0);
    button.setSize(ofGetWidth(), ofGetHeight()-300);
    
    
}

//------------------------------------------------------------------
void songZero::deactivate() {
    cout << "Deactivate songZero" << endl;
    for (int i = 0; i < SONG_ZERO_TOTAL; i++) {
        songZero[i].clear();  
    }
}


//------------------------------------------------------------------
void songZero::draw() {
    
    button.draw();
    drawGrid();
    ofTranslate(0, floatVal());    
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255); 
    
    string message = "";
    //int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_ZERO_FIRST:
            songZero[SONG_ZERO_FIRST].draw(0,0);             
            break;
            
        case SONG_ZERO_SECOND:
            songZero[SONG_ZERO_SECOND].draw(0,0);             
            break;
            
        case SONG_ZERO_THIRD:
            songZero[SONG_ZERO_THIRD].draw(0,0);             
            break;
            
        case SONG_ZERO_FOURTH:
            songZero[SONG_ZERO_FOURTH].draw(0,0);             
            break;
            
        case SONG_ZERO_FIFTH:
            songZero[SONG_ZERO_FIFTH].draw(0,0);             
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
void songZero::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void songZero::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void songZero::touchUp(ofTouchEventArgs &touch){
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
    
    if(button.isPressed()) {
        
        if (gen == 0) {
            if(mgr.getCurScene() < SONG_ZERO_SECOND) {
                mgr.setCurScene(mgr.getCurScene() + 1); 
            }
        } else {
            if(mgr.getCurScene() < SONG_ZERO_TOTAL < 1) {
                mgr.setCurScene(mgr.getCurScene() + 1); 
            }
        }
    }
    button.touchUp(touch);
}

//--------------------------------------------------------------

void songZero::touchDoubleTap(ofTouchEventArgs &touch){
    //theWhale.touchDoubleTap(touch);
    
}