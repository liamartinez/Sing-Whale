//
//  songWaiting.cpp
//  SingWhale05
//
//  Created by Lia Martinez on 4/16/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "songWaiting.h"

//------------------------------------------------------------------
void songWaiting::setup() {
    
}



//------------------------------------------------------------------
void songWaiting::update() {
    //theWhale.update();
    switch(mgr.getCurScene()) {
        case SONG_WAITING_FIRST:

            break;            
    }
}

//------------------------------------------------------------------
void songWaiting::activate() {
    mgr.setCurScene(SONG_WAITING_FIRST);    
    cout << "Activate Song Waiting" << endl;    
    songWaiting.loadImage("story/waiting-0.png");
    textStart.set(ofGetWidth()-200, ofGetHeight()-530);
        
    songSmallTalk[0] = " Hi, \n  what's up?  ";
    songSmallTalk[1] = "   La la la    ";
    songSmallTalk[2] = "   Is there anything you \n wanted to ask?";
    songSmallTalk[3] = "   Yes?  ";
    songSmallTalk[4] = " Dum dee dum dee  ";

    songSmallTalkNum = (int)ofRandom(4); 
    
    //theWhale.setup(); 
    //theWhale.smileOn = true; 
    
    
}

//------------------------------------------------------------------
void songWaiting::deactivate() {
    cout << "Deactivate songWaiting" << endl;
}


//------------------------------------------------------------------
void songWaiting::draw() {

    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255); 
    
    switch(mgr.getCurScene()) {
        case SONG_ONE_FIRST:

            ofPushMatrix();
            ofTranslate(0, floatVal());
            
            songWaiting.draw(0,0);
            message = songSmallTalk[songSmallTalkNum];
            ofPopMatrix();

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
void songWaiting::touchDown(ofTouchEventArgs &touch){

}


//--------------------------------------------------------------
void songWaiting::touchMoved(ofTouchEventArgs &touch){

}


//--------------------------------------------------------------
void songWaiting::touchUp(ofTouchEventArgs &touch){

    
}
//--------------------------------------------------------------

void songWaiting::touchDoubleTap(ofTouchEventArgs &touch){

    
}
