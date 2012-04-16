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
    songSmallTalk[2] = "    I'm sorry, \ndid you say something?";
    songSmallTalk[3] = "   Yes?  ";
    songSmallTalk[4] = " Dum dee dum dee  ";

    songSmallTalkNum = (int)ofRandom(4); 
    
    //theWhale.setup(); 
    //theWhale.smileOn = true; 
    
    
}

//------------------------------------------------------------------
void songWaiting::deactivate() {
    cout << "Deactivate songWaiting" << endl;
    songWaiting.clear(); 
}


//------------------------------------------------------------------
void songWaiting::draw() {
    
    
    drawGrid();
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_ONE_FIRST:
            ofEnableAlphaBlending();

            ofPushMatrix();
            ofTranslate(0, floatVal());
            songWaiting.draw(0,0);
            message = songSmallTalk[songSmallTalkNum];
            ofPopMatrix();

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
