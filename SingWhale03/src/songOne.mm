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
            break;            
    }
}

//------------------------------------------------------------------
void songOne::activate() {
    mgr.setCurScene(SONG_ONE_FIRST);

    
    cout << "Activate Song One" << endl;
    
    
}

//------------------------------------------------------------------
void songOne::deactivate() {
    cout << "Deactivate songOne" << endl;
   
}


//------------------------------------------------------------------
void songOne::draw() {

        
    drawGrid();
    ofDrawBitmapString("SONG ONE", ofGetWidth()/2, ofGetHeight()/2 + 20);
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case SONG_ONE_FIRST:
            
            ofEnableAlphaBlending();
            
            sceneName = "First Sub Scene!";
            
            ofSetColor(255, 255, 255); 
            //homeScreen.draw (0,0);    
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    
    
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