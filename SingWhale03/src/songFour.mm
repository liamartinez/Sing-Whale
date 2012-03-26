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
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void songFour::activate() {

    mgr.setCurScene(SONG_FOUR_FIRST);
        
    dontSpeak[0] = "    I'm sorry, \nI don't speak armadillo";
    dontSpeak[1] = "    I'm sorry, \nI don't speak dolphin";
    dontSpeak[2] = "    I'm sorry, \nI don't speak chihuahua";
    dontSpeak[3] = "What was that?";
    dontSpeak[4] = "Perhaps if you \n  ENUNCIATE?";
    
    songFour.loadImage("images/speak_med.png");
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Three" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-550);
    dontSpeakNum = (int)ofRandom(4); 
    
    
}

//------------------------------------------------------------------
void songFour::deactivate() {
    cout << "Deactivate songFour" << endl;
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songFour::draw() {
    
    
    drawGrid();
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_FOUR_FIRST:
            
            ofEnableAlphaBlending();
            
            message = dontSpeak[dontSpeakNum];
            songFour.draw(0,0);
            
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
void songFour::touchDown(ofTouchEventArgs &touch){
    //button.touchDown(touch);
}


//--------------------------------------------------------------
void songFour::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songFour::touchUp(ofTouchEventArgs &touch){
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