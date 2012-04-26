//
//  callSceneName.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "callSceneName.h"

//------------------------------------------------------------------
void callSceneName::setup() {
    
    
}



//------------------------------------------------------------------
void callSceneName::update() {
    
    //nameSong.update(); 
    wSong.update();
    if (wSong.atEnd) wSong.begin = false;
    
    Tweenzor::update(ofGetElapsedTimeMillis());
    switch(mgr.getCurScene()) {
        case CALL_SCENE_FIRST:
            //Do stuff
            break;  
        case CALL_SCENE_SECOND:
            //Do stuff
            break;    
        case CALL_SCENE_THIRD:
            //Do stuff
            break;    
    }
}

//------------------------------------------------------------------
void callSceneName::activate() {
    //start with the first scene when activated. 
    mgr.setCurScene(ofRandom(CALL_SCENE_NAME_TOTAL));
    
    nameSong.setup(); 
    
    //load here, not setup
    callScreen.loadImage("story/7-BG.png");
    callDuck.loadImage("images/call1.png");
    callPail.loadImage("images/call3.png");
    //next.setLabel("CORRECT", &swAssets->nevis22);
    //tryAgain.setLabel("TRY AGAIN", &swAssets->nevis22);

    cout << "Activate CallName" << endl;
    
    textStart.set(ofGetWidth()/2, ofGetHeight()/3);
    wSong.loadSong("intro/hello.xml");
    wSong.setSong(0);
}

//------------------------------------------------------------------
void callSceneName::deactivate() {
    cout << "Deactivate CallName" << endl;
    
    callScreen.clear();
    callDuck.clear(); 
    callPail.clear(); 
    
}


//------------------------------------------------------------------
void callSceneName::draw() {
    cout << "Drawing CallName screen" << endl;
    
    ofSetColor(255, 255, 255);
    callScreen.draw(0,0);
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);

    next.draw(ofGetWidth() - 550, ofGetHeight()-100); 
    tryAgain.draw(ofGetWidth()/2 - 300, ofGetHeight()-100); 

    switch(mgr.getCurScene()) {
        case CALL_SCENE_NAME_DUCK:
            ofEnableAlphaBlending();
            callDuck.draw(0,0);
            ofDisableAlphaBlending(); 
            
            ofPushMatrix();
            ofTranslate(300, -200);
            wSong.draw();
            ofPopMatrix();
            
            //check the song
            wSong.begin = false; 
            wSong.reset = true; 
            wSong.dontCheck = false; 
            if(wSong.checked) {
                if (wSong.correct) {
                    mgr.setCurScene(mgr.getCurScene() + 1);   
                    wSong.checked = false; 
                } else {
                    swSM->setCurScene(SCENE_CALL_NAME); 
                    //hasReturned = true;
                    wSong.checked = false;
                }
            }
            
            turtleButt.lightUp (strobey); 
            turtleButt.draw(100, ofGetHeight() - 200);
            
            message = "You did it wrong! You called a duck!"; 
            break;
            
        case CALL_SCENE_NAME_PAIL:
            ofEnableAlphaBlending();
            ofSetColor(255, 255, 255);
            callPail.draw(0,0);
            ofDisableAlphaBlending(); 
            message = "You called a pail! A pail is not a WHALE"; 
            
            ofPushMatrix();
            ofTranslate(300, -200);
            wSong.draw();
            ofPopMatrix();
            
            //check the song
            wSong.begin = false;
            wSong.reset = true; 
            wSong.dontCheck = false; 
            if(wSong.checked) {
                if (wSong.correct) {
                    mgr.setCurScene(mgr.getCurScene() + 1);   
                    wSong.checked = false; 
                } else {
                    swSM->setCurScene(SCENE_CALL_NAME); 
                    //hasReturned = true;
                    wSong.checked = false;
                }
            }
            
            turtleButt.lightUp (strobey); 
            turtleButt.draw(100, ofGetHeight() - 200);
            break;
            
        case CALL_SCENE_NAME_SNAIL:
            message = "Okay, that's a snail. You are getting closer"; 
            ofPushMatrix();
            ofTranslate(300, -200);
            wSong.draw();
            ofPopMatrix();
            
            //check the song
            wSong.begin = false;
            wSong.reset = true; 
            wSong.dontCheck = false; 
            if(wSong.checked) {
                if (wSong.correct) {
                    mgr.setCurScene(mgr.getCurScene() + 1);   
                    wSong.checked = false; 
                } else {
                    swSM->setCurScene(SCENE_CALL_NAME); 
                    //hasReturned = true;
                    wSong.checked = false;
                }
            }
            
            turtleButt.lightUp (strobey); 
            turtleButt.draw(100, ofGetHeight() - 200);
            break;
    }
    
    ofSetColor(8, 44, 49);

    textW = swAssets->nevis48.getStringWidth(message);
    swAssets->nevis48.drawString(message, textStart.x - textW/2, textStart.y);

    ofSetColor(255, 255, 255);
    
}



//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void callSceneName::touchDown(ofTouchEventArgs &touch){
    tryAgain.touchDown(touch);
    next.touchDown(touch);
    nameSong.touchDown(touch);
}


//--------------------------------------------------------------
void callSceneName::touchMoved(ofTouchEventArgs &touch){
    tryAgain.touchMoved(touch);
    next.touchMoved(touch);
    nameSong.touchMoved(touch);
}


//--------------------------------------------------------------
void callSceneName::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(tryAgain.isPressed()) mgr.setCurScene(ofRandom(CALL_SCENE_NAME_TOTAL));  
    
    if(next.isPressed()) swSM->setCurScene(SCENE_CALL); 

    tryAgain.touchUp(touch);
    next.touchUp(touch);
    nameSong.touchUp(touch);
}