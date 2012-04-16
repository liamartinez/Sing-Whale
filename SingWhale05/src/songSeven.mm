//
//  songSeven.cpp
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songSeven.h"

//------------------------------------------------------------------
void songSeven::setup() {
    
    
}



//------------------------------------------------------------------
void songSeven::update() {
    switch(mgr.getCurScene()) {
        case SONG_SEVEN_FIRST:
            theWhale.update();
            break;            
    }
}

//------------------------------------------------------------------
void songSeven::activate() {
    mgr.setCurScene(SONG_SEVEN_FIRST);
    
    songSeven.loadImage("images/speak_sleepy.png");
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Seven" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);
    
    
}

//------------------------------------------------------------------
void songSeven::deactivate() {
    cout << "Deactivate songSeven" << endl;
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songSeven::draw() {
    
    
    drawGrid();
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_SEVEN_FIRST:
            
            ofEnableAlphaBlending();
            
            //message = "zZZzz"; 
            //songSeven.draw(0,0);
            
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
void songSeven::touchDown(ofTouchEventArgs &touch){
    //button.touchDown(touch);
}


//--------------------------------------------------------------
void songSeven::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songSeven::touchUp(ofTouchEventArgs &touch){
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

void songSeven::touchDoubleTap(ofTouchEventArgs &touch){
    theWhale.touchDoubleTap(touch);
    
}