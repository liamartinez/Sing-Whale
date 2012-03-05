//
//  callScene.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "callScene.h"

//------------------------------------------------------------------
void callScene::setup() {
    
    
}



//------------------------------------------------------------------
void callScene::update() {
    switch(mgr.getCurScene()) {
        case CALL_SCENE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void callScene::activate() {
    mgr.setCurScene(CALL_SCENE_FIRST);
    
    
    
    callScreen.loadImage("images/wireframes-01.png");
    button.setImage(&callScreen,&callScreen);
    
    cout << "Activate Home" << endl;
    
    
}

//------------------------------------------------------------------
void callScene::deactivate() {
    cout << "Deactivate Home" << endl;
    
    callScreen.clear();
    
}


//------------------------------------------------------------------
void callScene::draw() {
    cout << "Drawing home screen" << endl;
    
    
    drawGrid();
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case CALL_SCENE_FIRST:
            
            ofEnableAlphaBlending();
            
            sceneName = "First Sub Scene!";
            
            ofSetColor(255, 255, 255); 
            callScreen.draw (0,0); 
            ofDisableAlphaBlending();
            
            break;
            
    }
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void callScene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void callScene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void callScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(button.isPressed()) {
        if(mgr.getCurScene() == CALL_SCENE_TOTAL-1) {
            swSM->setCurScene(SCENE_SPEAK);
        } else  {
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
    button.touchUp(touch);
}