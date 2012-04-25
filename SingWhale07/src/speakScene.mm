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
    swAssets = swAssetManager::getInstance();
    
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
    
    //start with the waiting scene
    songSM->setCurScene(SONG_WAITING);
    
    songMenu.setup();
    songMenu.show(); 
    
    wSong.setup(); 
    
    //empty guide
    wSong.letsReset();
    
    //buttons and antenna
    BG.loadImage("story/7-BG.png");
    buttonUp.loadImage("images/button-up.png"); 
    buttonDown.loadImage("images/button-down.png");
    antenna.loadImage("images/antenna.png");
    for (int i = 0; i < 3; i++) {
        waves[i].loadImage ("images/antenna_waves-" + ofToString(i) + ".png"); 
    }
    menuBG.loadImage ("images/menuBG5.png"); 
    lines.loadImage("images/linesdark.png");
    sparks.loadImage("images/sparks.png");
    
    startSingingButt.setup(); 
    startSingingButt.setSize(150, 150);
    startSingingButt.bColor = true; 
    //startSingingButt.setLabel("x", &swAssets->nevis48);
    //startSingingButt.setImage(&buttonUp, &buttonDown);
    
    activateGuideButt.setup(); 
    //activateGuideButt.setLabel("activate", &whitneySemiBold22);
    activateGuideButt.setSize(100, 100);
    
    switchButt.setSize(100, 100);
    switchButt.bColor = true;
    switchOn = false; 
 
    
    for (int i = 0; i < SONG_TOTAL_SCENES - 2; i++) {
        layla[i].loadSound("sounds/" + ofToString(i) + ".caf");
    }
    
    correct.loadSound("sounds/bubbles.caf");
    incorrect.loadSound("sounds/tone.caf");
    noise.loadSound("sounds/noise.caf");

    
    //for the animated radio waves
    //waveNum = 0; 
    
    //tweenzor
    singWordSize = 1;
    Tweenzor::add(&singWordSize, singWordSize,0.7f, 0.f, 0.6f, EASE_IN_OUT_QUAD);
    Tweenzor::getTween( &singWordSize )->setRepeat( 5000, true ); 
    
    Tweenzor::addCompleteListener( Tweenzor::getTween(&singWordSize), this, &speakScene::onComplete);

}

//--------------------------------------------------------------
// this function is called on when the tween is complete //
void speakScene::onComplete(float* arg) {
    
    Tweenzor::add(&singWordSize, singWordSize,0.7f, 0.f, 0.6f, EASE_IN_OUT_QUAD);
	
	// add the complete listener again so that it will fire again, creating a loop //
    Tweenzor::addCompleteListener( Tweenzor::getTween(&singWordSize), this, &speakScene::onComplete);
    
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
            correct.play();
            correct.setVolume(0.3f);
            wSong.checked = false; 
            cout << "I THINK ITS RIGHT " << endl ;
        } else {
            songSM->setCurScene(SONG_WRONG);  
            songs[songSM->getCurScene()]->activate();
            incorrect.play();
            incorrect.setVolume(0.5f);
            wSong.checked = false;
            cout << "I THINK ITS WRONG " << endl ;
        }
        cout << "Speak Scene activating song " << songs[songSM->getCurScene()] << endl; 
    }
    
    //if the song is rotated in the right place, its switched on
    //if (songMenu.activate) 

    //set the song!
    if (switchOn ) {
        wSong.reset = true;
        switchOn = false; 
        wSong.dontCheck = false; 
        wSong.setSong(songMenu.getSongPressed());
        layla[songMenu.getSongPressed()].play();
        
    } 
    

    //if at the end, flash the "SING!" thing
 if (layla[songMenu.getSongPressed()].getPosition() > .9) {
        youSing = true; 
    }
        
    if (songMenu.poked) {
        switchOn = false;
        drawWords = true; 
        wSong.letsReset(); 
        wSong.reset = true;
        songMenu.poked = false; 
        youSing = false; 
        wSong.dontCheck = true;
        for (int i = 0; i < SONG_TOTAL_SCENES -2; i++) {
            layla[i].stop();
        }
        songSM->setCurScene(SONG_WAITING);
    }
}

//------------------------------------------------------------------
void speakScene::activate() {
    cout << "Activate Speak" << endl;
    noise.setLoop(true);
    noise.play(); 
    noise.setVolume(0.5f);
}

//------------------------------------------------------------------
void speakScene::deactivate() {
    cout << "Deactivate Speak" << endl;
    
}


//------------------------------------------------------------------
void speakScene::draw() {
    
    BG.draw(0,0);
    
    //activateGuideButt.draw(200, ofGetHeight()-150); 
    guideArea.set (315, ofGetHeight() - 245, 685, 210); 
    ofNoFill();
    
    switchButt.setSize(guideArea.width, guideArea.height);
    ofSetColor(50); 
    switchButt.draw(guideArea.x, guideArea.y); 

    //DRAW WORDS AND DRAW GUIDE

        ofSetColor(200, 75, 90);
        swAssets->nevis48.drawString(songMenu.phrases[songMenu.currentSong], guideArea.x + 50 ,guideArea.y + guideArea.height/2);
  
        ofPushMatrix(); 
        ofTranslate(330, 100, -130);
        wSong.draw(); 
        ofPopMatrix(); 
        
        ofFill(); 
        ofSetColor(64, 94, 109);
        //ofSetColor(213, 226, 234);
    
    if (layla[songMenu.getSongPressed()].getIsPlaying()) {
        int songPos; 
        songPos = ofMap(layla[songMenu.getSongPressed()].getPosition(), 0, 1, 0, guideArea.width);
        ofRect(guideArea.x + songPos, guideArea.y, guideArea.width - songPos, guideArea.height + 300);
        ofNoFill(); 
    }

    ofEnableAlphaBlending(); 

    startSingingButt.draw (70, ofGetHeight() - 150); 

    //flashing antenna    
    bool on = true; 
    if (wSong.begin) {
        for (int i = 0; i < 3; i++) {
            if (ofGetFrameNum() %3 ==0) {
                ofEnableAlphaBlending();
                ofSetColor(255);
                if (on) sparks.draw(0,0);
                ofDisableAlphaBlending();
                //if (on) waves[i].draw(ofGetWidth() - 250, 290);
                on = !on; 
                /*
                 if (waveNum < 3) {
                 waveNum ++; 
                 } else {
                 waveNum = 0; 
                 }
                 cout << waveNum << endl; 
                 */
            }
        }
    }
    
    ofDisableAlphaBlending();
    
    //fix this mess
    songMenu.draw(); 
    
    /*
    startSingingButt.draw (45, ofGetHeight() - 200); 
    if (showSongButtons) wSong.drawButtons();
     */

    //if switched on and layla is finished, the turtle strobes
    if (youSing && !wSong.begin )  {
        
        lightSize = ofMap(singWordSize, .7f, 1, 100, 255);
        songMenu.lightUp (lightSize); 

    } else {
        songMenu.lightUp(255);
    }
         
    //lines
    ofPushMatrix();
    ofTranslate(40, 40);
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255);
    //menuBG.draw(0,-20);
    lines.draw(0,0);
    ofDisableAlphaBlending();
    ofPopMatrix();
         
    
    //the actual scene
    ofEnableAlphaBlending();
    ofSetColor(213, 226, 234); 
    ofPushMatrix(); 
    if(!songSM->getCurSceneChanged(false)) {
        songs[songSM->getCurScene()]->draw();
    }
    ofPopMatrix();     
    ofDisableAlphaBlending();
    

    
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
    activateGuideButt.touchDown(touch);
    switchButt.touchDown(touch);
    
    
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
                youSing = false; 
                if (wSong.atEnd) {
                    wSong.reset = true;
                    wSong.begin = true; 
                } else {
                    wSong.begin = !wSong.begin;
                }
            
        }
    } else {
        ofDrawBitmapString("choose something to say before you sing :)", 500, 400);
    }
    
    if (touch.x < (30 + 150) && touch.y > (ofGetHeight() - 150)) {
        startSingingButt.touchUp(touch);
    }
    
    if (activateGuideButt.isPressed()) {
        cout << "OK GO!" << endl; 
    }
    
    if (switchButt.isPressed()) {
        cout << "PRESSED *********" << endl; 
        switchOn = true;

        
    }
    
    activateGuideButt.touchUp(touch);
    switchButt.touchUp(touch);
    
    
    
}




