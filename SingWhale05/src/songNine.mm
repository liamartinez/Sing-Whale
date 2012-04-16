//
//  songNine.cpp
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songNine.h"

//------------------------------------------------------------------
void songNine::setup() {
    
    
}



//------------------------------------------------------------------
void songNine::update() {
    switch(mgr.getCurScene()) {
        case SONG_NINE_FIRST:
            theWhale.update();
            break;            
    }
}

//------------------------------------------------------------------
void songNine::activate() {
    mgr.setCurScene(SONG_NINE_FIRST);
    
    songNine.loadImage("images/speak_sleepy.png");
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Nine" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);
    
    
}

//------------------------------------------------------------------
void songNine::deactivate() {
    cout << "Deactivate songNine" << endl;
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songNine::draw() {
    
    
    drawGrid();
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_NINE_FIRST:
            
            ofEnableAlphaBlending();
            
            //message = "zZZzz"; 
            //songNine.draw(0,0);
            
            theWhale.draw(); 
            theWhale.translateFloat = true; 
            theWhale.blowHoleOn = true; 
            
            ofSetColor(255, 255, 255); 
            //homeScreen.draw (0,0);    
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    ofSetColor(0);
    textW = swAssets->nevis48.getStringWidth(message);
    swAssets->nevis48.drawString(message, textStart.x - textW/2, textStart.y);
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songNine::touchDown(ofTouchEventArgs &touch){
    //button.touchDown(touch);
}


//--------------------------------------------------------------
void songNine::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songNine::touchUp(ofTouchEventArgs &touch){
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

void songNine::touchDoubleTap(ofTouchEventArgs &touch){
    theWhale.touchDoubleTap(touch);
    
}