//
//  songTwo.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "songTwo.h"

//------------------------------------------------------------------
void songTwo::setup() {
    
    
}



//------------------------------------------------------------------
void songTwo::update() {
    switch(mgr.getCurScene()) {
        case SONG_TWO_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void songTwo::activate() {
    mgr.setCurScene(SONG_TWO_FIRST);
    songTwo.loadImage("images/speak_sad.png");
    
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Two" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-450);

    
}

//------------------------------------------------------------------
void songTwo::deactivate() {
    cout << "Deactivate songTwo" << endl;
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songTwo::draw() {

    drawGrid();
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);

    switch(mgr.getCurScene()) {
        case SONG_ONE_FIRST:
            
            ofEnableAlphaBlending();
            
            message = "You're really mean"; 
            songTwo.draw(0,0);
            
            ofSetColor(255, 255, 255); 
            //homeScreen.draw (0,0);    
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    textW = swAssets->nevis22.getStringWidth(message);
    swAssets->nevis22.drawString(message, textStart.x - textW/2, textStart.y);

}

//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songTwo::touchDown(ofTouchEventArgs &touch){
    //button.touchDown(touch);
}


//--------------------------------------------------------------
void songTwo::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songTwo::touchUp(ofTouchEventArgs &touch){
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