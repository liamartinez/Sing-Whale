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
    
    songWrong.loadImage("story/wrong-0.png");
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Wrong" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-460);
    dontSpeakNum = (int)ofRandom(5); 
    

    
    
}

//------------------------------------------------------------------
void songWrong::deactivate() {
    cout << "Deactivate songWrong" << endl;
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songWrong::draw() {
    

    
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255); 
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_WRONG_FIRST:

            
            message = dontSpeak[dontSpeakNum];
            songWrong.draw(0,0);
 
            
            
            break;
            
    }
    
    ofDisableAlphaBlending();
    ofSetColor(0);
    textW = swAssets->nevis22.getStringWidth(message);
    swAssets->nevis22.drawString(message, textStart.x - textW/2, textStart.y);
    ofSetColor(255); 
    
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
    
    
}