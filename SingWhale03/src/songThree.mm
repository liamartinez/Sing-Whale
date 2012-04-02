//
//  songFour.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songThree.h"

//------------------------------------------------------------------
void songThree::setup() {
    
    
}



//------------------------------------------------------------------
void songThree::update() {
    switch(mgr.getCurScene()) {
        case SONG_THREE_FIRST:
            theWhale.update();
            break;            
    }
}

//------------------------------------------------------------------
void songThree::activate() {
    mgr.setCurScene(SONG_THREE_FIRST);
    
    songThree.loadImage("images/speak_sleepy.png");
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Three" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);

    
}

//------------------------------------------------------------------
void songThree::deactivate() {
    cout << "Deactivate songThree" << endl;
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songThree::draw() {

    
    drawGrid();
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_THREE_FIRST:
            
            ofEnableAlphaBlending();
            
            //message = "zZZzz"; 
            //songThree.draw(0,0);
            
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
void songThree::touchDown(ofTouchEventArgs &touch){
    //button.touchDown(touch);
}


//--------------------------------------------------------------
void songThree::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songThree::touchUp(ofTouchEventArgs &touch){
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