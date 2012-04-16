//
//  songWrong.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songWrong.h"

//------------------------------------------------------------------
void songWrong::setup() {
    
    
}



//------------------------------------------------------------------
void songWrong::update() {
    
    theWhale.update(); 
    
    switch(mgr.getCurScene()) {
            
            
        case SONG_WRONG_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void songWrong::activate() {
    
    mgr.setCurScene(SONG_WRONG_FIRST);
    
    dontSpeak[0] = "    I'm sorry, \nI don't speak armadillo";
    dontSpeak[1] = "    I'm sorry, \nI don't speak dolphin";
    dontSpeak[2] = "    I'm sorry, \nI don't speak chihuahua";
    dontSpeak[3] = "What was that?";
    dontSpeak[4] = "Perhaps if you \n  ENUNCIATE?";
    
    songWrong.loadImage("images/speak_med.png");
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Wrong" << endl;
    textStart.set(ofGetWidth()-600, ofGetHeight()-550);
    dontSpeakNum = (int)ofRandom(4); 
    
    theWhale.wriggleOn = true; 
    
    
}

//------------------------------------------------------------------
void songWrong::deactivate() {
    cout << "Deactivate songWrong" << endl;
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songWrong::draw() {
    
    
    drawGrid();
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_WRONG_FIRST:
            
            ofEnableAlphaBlending();
            
            message = dontSpeak[dontSpeakNum];
            //songWrong.draw(0,0);
            theWhale.draw(); 
            
            
            ofSetColor(255, 255, 255); 
            //homeScreen.draw (0,0);    
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    ofSetColor(0);
    textW = swAssets->nevis22.getStringWidth(message);
    swAssets->nevis22.drawString(message, textStart.x - textW/2, textStart.y);
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songWrong::touchDown(ofTouchEventArgs &touch){
    //button.touchDown(touch);
}


//--------------------------------------------------------------
void songWrong::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songWrong::touchUp(ofTouchEventArgs &touch){
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
//--------------------------------------------------------------

void songWrong::touchDoubleTap(ofTouchEventArgs &touch){
    theWhale.touchDoubleTap(touch);
    
}