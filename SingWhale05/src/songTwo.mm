//
//  songTwo.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "songTwo.h"

//------------------------------------------------------------------
void songTwo::setup() {
    
    
}



//------------------------------------------------------------------
void songTwo::update() {

    switch(mgr.getCurScene()) {
               
        case SONG_TWO_FIRST:
            //Do stuff
            theWhale.update();
            break;            
    }
}

//------------------------------------------------------------------
void songTwo::activate() {
    mgr.setCurScene(SONG_TWO_FIRST);
    
    for (int i = 0; i < SONG_TWO_TOTAL; i++) {
        songTwo[i].loadImage("story/2-" + ofToString(i) + ".png"); 
    }
    
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Two" << endl;
    /*
    textStart.set(ofGetWidth()-200, ofGetHeight()-450);
    theWhale.frownOn = true; 
    */
    
    button.setPos(ofGetWidth() - 150,180);
    button.setImage(&arrow);


    
}

//------------------------------------------------------------------
void songTwo::deactivate() {
    cout << "Deactivate songTwo" << endl;
    for (int i = 0; i < SONG_TWO_TOTAL; i++) {
        songTwo[i].clear(); 
    }
    
    //homeScreen.clear();
    
}


//------------------------------------------------------------------
void songTwo::draw() {

    button.draw();
    drawGrid();
    ofTranslate(0, tweenVal);    
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255); 
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);

    switch(mgr.getCurScene()) {
        case SONG_TWO_FIRST:
            songTwo[SONG_TWO_FIRST].draw(0,0);  
            button.draw();
            break;
            
        case SONG_TWO_SECOND:
            songTwo[SONG_TWO_SECOND].draw(0,0);  
            button.draw();
            break;
            
        case SONG_TWO_THIRD:
            songTwo[SONG_TWO_THIRD].draw(0,0);  
            break;
            
    }
    
    ofDisableAlphaBlending();
    
    /*
    ofSetColor(0);
    textW = swAssets->nevis22.getStringWidth(message);
    swAssets->nevis22.drawString(message, textStart.x - textW/2, textStart.y);
     */
}

//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songTwo::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void songTwo::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void songTwo::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    
    if(button.isPressed()) {
        cout <<"scene num " << mgr.getCurScene() << endl; 
        if(mgr.getCurScene() < SONG_TWO_TOTAL -1) {
            mgr.setCurScene(mgr.getCurScene() + 1);   
            
        }
    }
     button.touchUp(touch);
    

}

//--------------------------------------------------------------

void songTwo::touchDoubleTap(ofTouchEventArgs &touch){
    //theWhale.touchDoubleTap(touch);
    
}