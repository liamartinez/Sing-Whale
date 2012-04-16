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
   theWhale.update();
    switch(mgr.getCurScene()) {
        case SONG_ONE_FIRST:

            break;            
    }
}

//------------------------------------------------------------------
void songOne::activate() {
    mgr.setCurScene(SONG_ONE_FIRST);

    cout << "Activate Song One" << endl;
    
    songOne.loadImage("story/1-0.png");
    textStart.set(ofGetWidth()-200, ofGetHeight()-530);
    //theWhale.setup(); 
    //theWhale.smileOn = true; 
    
    
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
            
            //message = "  Hi there \n funny looking"; 
            
            ofPushMatrix();
            ofTranslate(0, floatVal());
            songOne.draw(0,0);
            ofPopMatrix();
            /*
            theWhale.draw(); 
            theWhale.translateFloat = true; 
             */
            
            
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
void songOne::touchDown(ofTouchEventArgs &touch){
    
    theWhale.touchDown(touch);

}


//--------------------------------------------------------------
void songOne::touchMoved(ofTouchEventArgs &touch){
    
    theWhale.touchMoved(touch); 

}


//--------------------------------------------------------------
void songOne::touchUp(ofTouchEventArgs &touch){
    
    theWhale.touchUp(touch);

}
//--------------------------------------------------------------

void songOne::touchDoubleTap(ofTouchEventArgs &touch){
    theWhale.touchDoubleTap(touch);

}
