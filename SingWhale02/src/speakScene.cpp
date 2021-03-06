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
    
    //Load Assets
    //swAssets = swAssetManager::getInstance();

        
        //setup scene manager/Scenes
        songSM = songSceneManager::getInstance();
        
        songs[SONG_ONE]      = new songOne();
        songs[SONG_TWO]      = new songTwo();
        songs[SONG_THREE]    = new songThree();

        try {
            for(int i=0; i<SONG_TOTAL_SCENES; i++) {
                songs[i]->setup();
            }
        } catch(string error) {
            cout << "View not intitialized! Please make sure every scene is created above!" << endl;
        }
    
    Tweenzor::init(); 
    
    songMenu.setup();
    songMenu.show(); 
}



//------------------------------------------------------------------
void speakScene::update() {
    
    Tweenzor::update();
    
    if(songSM->getCurSceneChanged()) {
        for(int i=0; i<SONG_TOTAL_SCENES; i++) {
            songs[i]->deactivate();
        }
        
        songs[songSM->getCurScene()]->activate();
    }
    
    songs[songSM->getCurScene()]->update();
    
    songMenu.update();
    
}

//------------------------------------------------------------------
void speakScene::activate() {
    /*
    mgr.setCurScene(SPEAK_SCENE_FIRST);
    
    
    
    speakScreen.loadImage("images/wires-03.png");
    button.setImage(&speakScreen,&speakScreen);
    
         */
    
    cout << "Activate Speak" << endl;

    
}

//------------------------------------------------------------------
void speakScene::deactivate() {
    cout << "Deactivate Speak" << endl;
    
    //speakScreen.clear();
    
}


//------------------------------------------------------------------
void speakScene::draw() {
    
    if(!songSM->getCurSceneChanged(false)) {
        songs[songSM->getCurScene()]->draw();
    }
    
    songMenu.draw(); 
    
    /*
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
    */
    
    
}

//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void speakScene::touchDown(ofTouchEventArgs &touch){
    //button.touchDown(touch);
    
    songs[songSM->getCurScene()]->touchDown(touch);
    
    songMenu.touchDown(touch);
}


//--------------------------------------------------------------
void speakScene::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
    songs[songSM->getCurScene()]->touchDown(touch);
    songMenu.touchMoved(touch);
}


//--------------------------------------------------------------
void speakScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    /*
     if(button.isPressed()) {
     if(mgr.getCurScene() == SPEAK_SCENE_TOTAL-1) {
     swSM->setCurScene(SCENE_HOME);
     } else  {
     mgr.setCurScene(mgr.getCurScene() + 1);      
     }
     }
     button.touchUp(touch);
     */
    
    songs[songSM->getCurScene()]->touchUp(touch);
    songMenu.touchUp(touch);
    
    
     if(songMenu.touchMenuRes){
     
     cout<<"touch menu res true"<<endl;
     songs[songSM->getCurScene()]->activate();
     
     }
     songMenu.touchMenuRes = false;
     
}



