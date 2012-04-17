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
        

        songs[SONG_ZERO]     = new songZero();
        songs[SONG_ONE]      = new songOne();
        songs[SONG_TWO]      = new songTwo();
        songs[SONG_THREE]    = new songThree();
        songs[SONG_FOUR]     = new songFour(); 
        songs[SONG_FIVE]     = new songFive();
        songs[SONG_SIX]      = new songSix();
        songs[SONG_SEVEN]    = new songSeven(); 
        songs[SONG_EIGHT]    = new songEight();
        songs[SONG_NINE]     = new songNine();
        songs[SONG_WRONG]     = new songWrong();
        songs[SONG_WAITING]   = new songWaiting(); 
        
        

        try {
            for(int i=0; i<SONG_TOTAL_SCENES; i++) {
                songs[i]->setup();
            }
        } catch(string error) {
            cout << "View not intitialized! Please make sure every scene is created above!" << endl;
        }
    
    //Tweenzor::init(); 
    
    //start with the waiting scene
    songSM->setCurScene(SONG_WAITING);

    songMenu.setup();
    songMenu.show(); 
    
    wSong.setup(); 
    
    //empty guide
    wSong.letsReset();
    
    //buttons and antenna
    buttonUp.loadImage("images/button-up.png"); 
    buttonDown.loadImage("images/button-down.png");
    antenna.loadImage("images/antenna.png");
    for (int i = 0; i < 3; i++) {
        waves[i].loadImage ("images/antenna_waves-" + ofToString(i) + ".png"); 
    }
    menuBG.loadImage ("images/menuBG3.png"); 
    
    startSingingButt.setup(); 
    startSingingButt.setImage(&buttonUp, &buttonDown);
    
    
}



//------------------------------------------------------------------
void speakScene::update() {
    
    //Tweenzor::update(ofGetElapsedTimeMillis());
    
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
            cout << "I THINK ITS RIGHT " << endl ;
        } else {
            songSM->setCurScene(SONG_WRONG);  
            songs[songSM->getCurScene()]->activate();
            wSong.checked = false;
            cout << "I THINK ITS WRONG " << endl ;
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
    
    
    if (songMenu.poked) {
        wSong.letsReset(); 
        wSong.reset = true;
        songMenu.poked = false; 
    }

}

//------------------------------------------------------------------
void speakScene::activate() {
    
    cout << "Activate Speak" << endl;

    
}

//------------------------------------------------------------------
void speakScene::deactivate() {
    cout << "Deactivate Speak" << endl;
 
    
}


//------------------------------------------------------------------
void speakScene::draw() {
    
    ofPushMatrix(); 
    if(!songSM->getCurSceneChanged(false)) {
        songs[songSM->getCurScene()]->draw();
    }
    ofPopMatrix(); 
   
    ofPushMatrix(); 
    ofTranslate(300, 30, -130);
    wSong.draw(); 
    ofPopMatrix(); 
    
    ofEnableAlphaBlending(); 
    ofSetColor(255, 255, 255);
    menuBG.draw(0,-20);
    for (int i = 0; i < 3; i++) {
        
        //if (ofGetElapsedTimeMillis() - lastTime < dur) { 
            if (wSong.begin) {
                waves[i].draw(ofGetWidth() - 230, ofGetHeight() - 400);
            }
        //}
    }
    ofDisableAlphaBlending();
    
    songMenu.draw(); 
    if (showSongButtons) wSong.drawButtons();


    startSingingButt.draw (30, ofGetHeight() - 200); 
    
}

//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void speakScene::touchDown(ofTouchEventArgs &touch){
    
    songs[songSM->getCurScene()]->touchDown(touch);
    
    songMenu.touchDown(touch);
    
    wSong.touchDown(touch);

    
    if (touch.x < (30 + 150) && touch.y > (ofGetHeight() - 150)) {
        startSingingButt.touchDown(touch);
    }
}


//--------------------------------------------------------------
void speakScene::touchMoved(ofTouchEventArgs &touch){

    songs[songSM->getCurScene()]->touchDown(touch);
    songMenu.touchMoved(touch);
    
    wSong.touchMoved(touch);

}


//--------------------------------------------------------------
void speakScene::touchUp(ofTouchEventArgs &touch){

    songs[songSM->getCurScene()]->touchUp(touch);
    songMenu.touchUp(touch);
    
    
     if(songMenu.touchMenuRes){
     
     cout<<"touch menu res true "<<songSM->getCurScene() <<endl;
     //songs[songSM->getCurScene()]->activate();
     //wSong.letsReset(); 
     //wSong.setSong(songMenu.getSongPressed()); //lia
     
     }
     songMenu.touchMenuRes = false;

    
     wSong.touchUp(touch);
     if (showSongButtons) wSong.touchDownButtons(touch);
    showSongButt.touchUp(touch);
    
    //if you press play and the song is done, reset and try again. if not, just pause it. 

    if (touch.x < (30 + 150) && touch.y > (ofGetHeight() - 150)) {
        if (startSingingButt.isPressed()) {
            if (wSong.atEnd) {
                wSong.reset = true;
                wSong.begin = true; 
            } else {
                wSong.begin = !wSong.begin;
            }
        }
    }

    if (touch.x < (30 + 150) && touch.y > (ofGetHeight() - 150)) {
        startSingingButt.touchUp(touch);
    }
    

    
}




