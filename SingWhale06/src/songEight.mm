//
//  songEight.cpp
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songEight.h"

//------------------------------------------------------------------
void songEight::setup() {
    
    
}



//------------------------------------------------------------------
void songEight::update() {
    switch(mgr.getCurScene()) {
        case SONG_EIGHT_FIRST:
     
            break;            
    }
}

//------------------------------------------------------------------
void songEight::activate() {
    mgr.setCurScene(SONG_EIGHT_FIRST);
    
    for (int i = 0; i < SONG_EIGHT_TOTAL; i++) {
        songEight[i].loadImage("story/8-" + ofToString(i) + ".png"); 
    }
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Eight" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);
    
    button.setPos(ofGetWidth() - 150,180);
    button.setImage(&arrow);
    
    
}

//------------------------------------------------------------------
void songEight::deactivate() {
    cout << "Deactivate songEight" << endl;
    
    for (int i = 0; i < SONG_EIGHT_TOTAL; i++) {
        songEight[i].clear(); 
    }
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songEight::draw() {
    
    
    //button.draw();
    ofTranslate(0, tweenVal);    
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255); 
    
    string message = "";
    //int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_EIGHT_FIRST:
            songEight[SONG_EIGHT_FIRST].draw(0,0);  
            button.draw();
            break;
            
        case SONG_EIGHT_SECOND:
            songEight[SONG_EIGHT_SECOND].draw(0,0);   
            button.draw();
            break;
            
        case SONG_EIGHT_THIRD:
            songEight[SONG_EIGHT_THIRD].draw(0,0);    
            button.draw();
            break;
            
        case SONG_EIGHT_FOURTH:
            songEight[SONG_EIGHT_FOURTH].draw(0,0);             
            break;
            
    }
    
    ofDisableAlphaBlending();
    
    /*
    ofSetColor(0);
    textW = swAssets->nevis48.getStringWidth(message);
    swAssets->nevis48.drawString(message, textStart.x - textW/2, textStart.y);
    */
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songEight::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void songEight::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void songEight::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(button.isPressed()) {
        if(mgr.getCurScene() < SONG_EIGHT_TOTAL - 1) {
            mgr.setCurScene(mgr.getCurScene() + 1); 
        }
    }
    button.touchUp(touch);
}

//--------------------------------------------------------------

void songEight::touchDoubleTap(ofTouchEventArgs &touch){
    
}