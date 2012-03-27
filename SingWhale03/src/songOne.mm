//
//  songOne.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "songOne.h"

//------------------------------------------------------------------
void songOne::setup() {
    
    
}



//------------------------------------------------------------------
void songOne::update() {
        
    switch(mgr.getCurScene()) {
        case SONG_ONE_FIRST:
            //Do stuff
        case SONG_ONE_SECOND:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void songOne::activate() {
    mgr.setCurScene(SONG_ONE_FIRST);

    cout << "Activate Song One" << endl;
    
    songOne.loadImage("images/speak_med.png");
    textStart.set(ofGetWidth()-200, ofGetHeight()-530);
    
    
}

//------------------------------------------------------------------
void songOne::deactivate() {
    cout << "Deactivate songOne" << endl;
   
}


//------------------------------------------------------------------
void songOne::draw() {

       
    drawGrid();
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_ONE_FIRST:
            ofEnableAlphaBlending();
            
            message = "  Hi there \n funny looking"; 
            songOne.draw(0,0);
            
            ofSetColor(255, 255, 255); 
            //homeScreen.draw (0,0);    
            ofDisableAlphaBlending();

            break; 
            
        case SONG_ONE_SECOND:
            

            break;
            
    }
    
    ofSetColor(0);
    textW = swAssets->nevis48.getStringWidth(message);
    swAssets->nevis48.drawString(message, textStart.x - textW/2, textStart.y);
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songOne::touchDown(ofTouchEventArgs &touch){

}


//--------------------------------------------------------------
void songOne::touchMoved(ofTouchEventArgs &touch){

}


//--------------------------------------------------------------
void songOne::touchUp(ofTouchEventArgs &touch){

}