//
//  songFour.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songFour.h"

//------------------------------------------------------------------
void songFour::setup() {
    
    
}



//------------------------------------------------------------------
void songFour::update() {
    switch(mgr.getCurScene()) {
        case SONG_FOUR_FIRST:
           
            break;            
    }
}

//------------------------------------------------------------------
void songFour::activate() {
    mgr.setCurScene(SONG_FOUR_FIRST);
    
    /*
    for (int i = 0; i < SONG_FOUR_TOTAL; i++) {
        songFour[i].loadImage("story/4-" + ofToString(i) + ".png"); 
    }
     */
    
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Four" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);
    
    button.setPos(ofGetWidth() - 150,180);
    button.setImage(&arrow);
    
    whaleSounds[3].play();
}

//------------------------------------------------------------------
void songFour::deactivate() {
    cout << "Deactivate songFour" << endl;

}


//------------------------------------------------------------------
void songFour::draw() {
    
    
    //button.draw();
    ofTranslate(0, tweenVal);    

    
    string message = "";
    //int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_FOUR_FIRST:
            
            songFourPic[SONG_ZERO_FIRST].draw(0,0);   
            button.draw();
            break;
            
        case SONG_FOUR_SECOND:
            songFourPic[SONG_ZERO_SECOND].draw(0,0);             
            break;
    }
    

}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songFour::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void songFour::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
}


//--------------------------------------------------------------
void songFour::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(button.isPressed()) {
        if(mgr.getCurScene() < SONG_FOUR_TOTAL - 1) {
            mgr.setCurScene(mgr.getCurScene() + 1); 
        }
    }
    button.touchUp(touch);
}

//--------------------------------------------------------------

void songFour::touchDoubleTap(ofTouchEventArgs &touch){
    
}