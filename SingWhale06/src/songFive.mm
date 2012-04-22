//
//  songFive.cpp
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songFive.h"

//------------------------------------------------------------------
void songFive::setup() {
    
    
}



//------------------------------------------------------------------
void songFive::update() {
    switch(mgr.getCurScene()) {
        case SONG_FIVE_FIRST:
            //theWhale.update();
            break;      
        case SONG_FIVE_SECOND:
            //particles
            
            if (blowHoleOn) {
                ps.applyForce(gravity);
                ps.update();
                
                if (ofGetFrameNum() % 3 == 0){
                for(int i=0; i<2; i++) {
                    ps.addParticle(ofGetWidth()/2, 165);
                }
            }
            }
    
            break; 
    }
}

//------------------------------------------------------------------
void songFive::activate() {
    mgr.setCurScene(SONG_FIVE_FIRST);
    
    /*
    for (int i = 0; i < SONG_FIVE_TOTAL; i++) {
        songFive[i].loadImage("story/5-" + ofToString(i) + ".png"); 
    }
     */
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Five" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);
    
    button.setPos(ofGetWidth() - 150,180);
    button.setImage(&arrow);
    
    //particles
    gravity.y = 0.2;	
    blowHoleOn = true; 
}

//------------------------------------------------------------------
void songFive::deactivate() {
    cout << "Deactivate songFive" << endl;

    
    blowHoleOn = false; 
}


//------------------------------------------------------------------
void songFive::draw() {
    //button.draw();
    ofTranslate(0, tweenVal);    
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255); 
    
    string message = "";
    //int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_FIVE_FIRST:
            songFivePic[SONG_FIVE_FIRST].draw(0,0);  
            button.draw();
            break;
            
        case SONG_FIVE_SECOND:
            ofEnableAlphaBlending(); 
            ofSetColor(255, 255, 255);
            if (blowHoleOn) ps.draw();
            songFivePic[SONG_FIVE_SECOND].draw(0,0);   
            ofDisableAlphaBlending(); 
            break;
    }
    ofDisableAlphaBlending();
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songFive::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void songFive::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songFive::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(button.isPressed()) {
        if(mgr.getCurScene() < SONG_FIVE_TOTAL - 1) {
            mgr.setCurScene(mgr.getCurScene() + 1); 
        }
    }
    button.touchUp(touch);
}

//--------------------------------------------------------------

void songFive::touchDoubleTap(ofTouchEventArgs &touch){
    
}