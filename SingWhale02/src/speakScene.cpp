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
    
    
}



//------------------------------------------------------------------
void speakScene::update() {
           // Tweenzor::update();
    if(songSM->getCurSceneChanged()) {
        for(int i=0; i<SONG_TOTAL_SCENES; i++) {
            songs[i]->deactivate();
        }
        
        songs[songSM->getCurScene()]->activate();
    }
    
    songs[songSM->getCurScene()]->update();
    
    //menu.update();
}

//------------------------------------------------------------------
void speakScene::activate() {
    /*
    mgr.setCurScene(SPEAK_SCENE_FIRST);
    
    
    
    speakScreen.loadImage("images/wires-03.png");
    button.setImage(&speakScreen,&speakScreen);
    
    cout << "Activate Speak" << endl;
    */
    
}

//------------------------------------------------------------------
void speakScene::deactivate() {
    cout << "Deactivate Speak" << endl;
    
    speakScreen.clear();
    
}


//------------------------------------------------------------------
void speakScene::draw() {
    cout << "Drawing Speak screen" << endl;
    
    if(!songSM->getCurSceneChanged(false)) {
        songs[songSM->getCurScene()]->draw();
    }
    
    //menu.draw();
    
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
    
    //menu.touchDown(touch);
}


//--------------------------------------------------------------
void speakScene::touchMoved(ofTouchEventArgs &touch){
    //button.touchMoved(touch);
        songs[songSM->getCurScene()]->touchDown(touch);
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
    //menu.touchUp(touch);
    
    /*
    if(menu.touchMenuRes){
        
        cout<<"touch menu res true"<<endl;
        scenes[swSM->getCurScene()]->activate();
        
    }
    menu.touchMenuRes = false;
     */
}