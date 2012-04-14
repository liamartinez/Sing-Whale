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
        songs[SONG_FOUR]     = new songFour(); 
        

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
    
    wSong.setup(); 
    
    //showSongButt.setup(); 
    //showSongButt.setLabel("Show Song Buttons", &whitneySemiBold22);
        
    //start singing button
    startSingingButt.setup(); 
    //startSingingButt.setLabel("sing", &whitneySemiBold22);
    
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
    
    wSong.update(); 
    wSong.loadSong("positions.xml");
    
    //if the user song is correct, then activate that scene. 
    //if the user is wrong, make fun of them in song 4. 
    if(wSong.checked) {
        if (wSong.correct) {
            songSM->setCurScene(songMenu.getSongPressed());
            songs[songSM->getCurScene()]->activate();
            wSong.checked = false; 
        } else {
            songSM->setCurScene(SONG_FOUR);  
            songs[songSM->getCurScene()]->activate();
            wSong.checked = false;
        }
        cout << "Speak Scene activating song " << songs[songSM->getCurScene()] << endl; 
    }
    
    //if the song is rotated in the right place, its switched on
    if (songMenu.activate) switchOn = true; 
    
    //set the song!
    if (switchOn) {
        switchOn = false; 
        wSong.setSong(songMenu.getSongPressed());        
    }
    
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
    if (showSongButtons) wSong.drawButtons();
    
    //showSongButt.draw(50, 50);
    
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
    
    ofPushMatrix(); 
    ofTranslate(300, -50);
    wSong.draw(); 
    ofPopMatrix(); 
    
    startSingingButt.draw (50, ofGetHeight() - 100); 
    
}

//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void speakScene::touchDown(ofTouchEventArgs &touch){
    
    songs[songSM->getCurScene()]->touchDown(touch);
    
    songMenu.touchDown(touch);
    
    wSong.touchDown(touch);
    
    //if (showSongButtons) wSong.touchDownButtons(touch);
    //showSongButt.touchDown(touch);

    startSingingButt.touchDown(touch);
}


//--------------------------------------------------------------
void speakScene::touchMoved(ofTouchEventArgs &touch){

    songs[songSM->getCurScene()]->touchDown(touch);
    songMenu.touchMoved(touch);
    
    wSong.touchMoved(touch);

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
     
     cout<<"touch menu res true "<<songSM->getCurScene() <<endl;
     //songs[songSM->getCurScene()]->activate();
     //wSong.letsReset(); 
     //wSong.setSong(songMenu.getSongPressed()); //lia
     
     }
     songMenu.touchMenuRes = false;
    
    /*
    if (showSongButt.isPressed()) {
        showSongButtons = !showSongButtons; 
    }

    if (showSongButtons == true) wSong.setupButtons();
     */
    
     wSong.touchUp(touch);
     if (showSongButtons) wSong.touchDownButtons(touch);
    showSongButt.touchUp(touch);
    
    //if you press play and the song is done, reset and try again. if not, just pause it. 
    if (startSingingButt.isPressed()) {
        if (wSong.atEnd) {
            wSong.reset = true;
            wSong.begin = true; 
        } else {
            wSong.begin = !wSong.begin;
        }
    }
    
    startSingingButt.touchUp(touch);
    

    
}




