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
    
    songSeven.loadImage("story/7-0.png");
    songJellies.loadImage("story/7-jellies.png");
    songSevenBG.loadImage("story/7-BG.png");
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Seven" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);
    
    for (int i = 0; i < 15; i ++) {
    
    randLoc[i].x = ofRandom(-500, ofGetWidth());
    randLoc[i].y = ofRandom(ofGetHeight() - 200);
    randSize[i] = ofRandom(1300);
    randDelay[i] = ofRandom(1.f);
    randDur[i] = ofRandom(3.f, 8.f);
    
    Tweenzor::add(&randLoc[i].y, randLoc[i].y, randLoc[i].y + randSize[i], randDelay[i], randDur[i], EASE_IN_OUT_SINE);
    Tweenzor::getTween( &randLoc[i].y )->setRepeat( 20, true );
    }
}

//------------------------------------------------------------------
void songSeven::deactivate() {
    cout << "Deactivate songSeven" << endl;
    
    songSeven.clear();
    songJellies.clear();
    
}


//------------------------------------------------------------------
void songSeven::draw() {
    
    button.draw();
    songSevenBG.draw(0, 0);
    //drawGrid();
    ofTranslate(0, floatVal());    
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255); 
    
    string message = "";
    //int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_SEVEN_FIRST:
            songSeven.draw(0,0);   
            for (int i = 0; i < NUMJELLIES; i++) {
                songJellies.draw(randLoc[i].x, randLoc[i].y, randSize[i], randSize[i]);
            }
            break;
    }
    
    ofDisableAlphaBlending();

    /*
    ofSetColor(0);
    textW = swAssets->nevis48.getStringWidth(message);
    swAssets->nevis48.drawString(message, textStart.x - textW/2, textStart.y);
    */
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