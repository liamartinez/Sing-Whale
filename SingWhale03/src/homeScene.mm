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
    callButton.setLabel("INTRO",&swAssets->nevis22);
    callButton.disableBG();
    speakButton.setLabel("SPEAK TO \n   WHALE", &swAssets->nevis22);
    speakButton.disableBG();
        
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
    
    
    //drawGrid();
    
    
    string sceneName = "";
    switch(mgr.getCurScene()) {
        case HOME_SCENE_FIRST:
            
            ofEnableAlphaBlending();
            
            sceneName = "First Sub Scene!";
            
            ofSetColor(255, 255, 255); 
            homeScreen.draw (0,0); 

            callButton.draw(ofGetWidth()/4, ofGetHeight() - ofGetHeight()/3);
            speakButton.draw(ofGetWidth()/4*2,ofGetHeight() - ofGetHeight()/3);
            ofDisableAlphaBlending();

            break;

    }

}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void homeScene::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
    callButton.touchDown(touch);
    speakButton.touchDown(touch);
}


//--------------------------------------------------------------
void homeScene::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
    callButton.touchDown(touch);
    speakButton.touchDown(touch);
}


//--------------------------------------------------------------
void homeScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
    if(button.isPressed()) {
        if(mgr.getCurScene() == HOME_SCENE_TOTAL-1) {
            swSM->setCurScene(SCENE_CALL);
        } else  {
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
     */
    
    if(callButton.isPressed()) swSM->setCurScene(SCENE_CALL);
    if(speakButton.isPressed()) swSM->setCurScene(SCENE_SPEAK);

    
    speakButton.touchUp(touch);
    button.touchUp(touch);
    callButton.touchUp(touch);
}