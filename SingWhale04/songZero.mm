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
    mgr.setCurScene(SONG_ZERO_FIRST);
    
    songZero.loadImage("images/speak_sleepy.png");
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Zero" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);
    
    
}

//------------------------------------------------------------------
void songZero::deactivate() {
    cout << "Deactivate songZero" << endl;
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songZero::draw() {
    
    
    drawGrid();
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_ZERO_FIRST:
            
            ofEnableAlphaBlending();
            
            //message = "zZZzz"; 
            //songZero.draw(0,0);
            
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
void songZero::touchDown(ofTouchEventArgs &touch){
    //button.touchDown(touch);
}


//--------------------------------------------------------------
void songZero::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
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
}

//--------------------------------------------------------------

void songZero::touchDoubleTap(ofTouchEventArgs &touch){
    theWhale.touchDoubleTap(touch);
    
}