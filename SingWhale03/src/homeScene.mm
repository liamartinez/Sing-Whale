//
//  homeScene.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "homeScene.h"

//------------------------------------------------------------------
void homeScene::setup() {
  
    
}



//------------------------------------------------------------------
void homeScene::update() {
    switch(mgr.getCurScene()) {
        case HOME_SCENE_FIRST:
            //Do stuff
            break;            
    }
}

//------------------------------------------------------------------
void homeScene::activate() {
    mgr.setCurScene(HOME_SCENE_FIRST);
    
    
    
    homeScreen.loadImage("images/title.png");
    button.setImage(&homeScreen,&homeScreen);
        
    cout << "Activate Home" << endl;
    
    
}

//------------------------------------------------------------------
void homeScene::deactivate() {
    cout << "Deactivate Home" << endl;
    
    homeScreen.clear();

}


//------------------------------------------------------------------
void homeScene::draw() {
    cout << "Drawing home screen" << endl;
    
    
    drawGrid();
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case HOME_SCENE_FIRST:
            
            ofEnableAlphaBlending();
            
            sceneName = "First Sub Scene!";
            
            ofSetColor(255, 255, 255); 
            homeScreen.draw (0,0); 
            ofDisableAlphaBlending();

            break;

    }
    
    
    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void homeScene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void homeScene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void homeScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(button.isPressed()) {
        if(mgr.getCurScene() == HOME_SCENE_TOTAL-1) {
            swSM->setCurScene(SCENE_CALL);
        } else  {
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
    button.touchUp(touch);
}