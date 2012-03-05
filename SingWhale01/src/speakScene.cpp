//
//  speakScene.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 2/27/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "speakScene.h"

//------------------------------------------------------------------
void speakScene::setup() {
    
    
}



//------------------------------------------------------------------
void speakScene::update() {
    switch(mgr.getCurScene()) {
        case SPEAK_SCENE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void speakScene::activate() {
    mgr.setCurScene(SPEAK_SCENE_FIRST);
    
    
    
    speakScreen.loadImage("images/wireframes-05.png");
    button.setImage(&speakScreen,&speakScreen);
    
    cout << "Activate Home" << endl;
    
    
}

//------------------------------------------------------------------
void speakScene::deactivate() {
    cout << "Deactivate Home" << endl;
    
    speakScreen.clear();
    
}


//------------------------------------------------------------------
void speakScene::draw() {
    cout << "Drawing home screen" << endl;
    
    
    drawGrid();
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case SPEAK_SCENE_FIRST:
            
            ofEnableAlphaBlending();
            
            sceneName = "First Sub Scene!";
            
            ofSetColor(255, 255, 255); 
            speakScreen.draw (0,0); 
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void speakScene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void speakScene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void speakScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(button.isPressed()) {
        if(mgr.getCurScene() == SPEAK_SCENE_TOTAL-1) {
            swSM->setCurScene(SCENE_HOME);
        } else  {
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
    button.touchUp(touch);
}