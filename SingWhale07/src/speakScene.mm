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
    startSingingButt.setSize(100, 200);
    startSingingButt.bColor = true; 
    //startSingingButt.setLabel("x", &swAssets->nevis48);
    //startSingingButt.setImage(&buttonUp, &buttonDown);
    
    /*
    switchButt.setSize(100, 100);
    switchButt.bColor = true;
     */
    
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
    
    buttonState = 0; 
    noneLoaded = true; 

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
    
    ofSoundUpdate();
        
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
        youSing = false; 
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

    guideArea.set (315, ofGetHeight() - 245, 710, 210); 
    ofNoFill();

    //DRAW WORDS AND DRAW GUIDE

        ofSetColor(200, 75, 90);
        swAssets->nevis48.drawString(songMenu.phrases[songMenu.currentSong], guideArea.x + 50 ,guideArea.y + guideArea.height/3);
  
        ofPushMatrix(); 
        ofTranslate(330, 0);
        wSong.draw(); 
        ofPopMatrix(); 
        
        ofFill(); 
        ofSetColor(64, 94, 109);
    
    if (layla[songMenu.getSongPressed()].getIsPlaying()) {
        int songPos; 
        songPos = ofMap(layla[songMenu.getSongPressed()].getPosition(), 0, 1, 0, guideArea.width);
        ofRect(guideArea.x  + songPos, guideArea.y-100, guideArea.width - songPos, guideArea.height + 400);
        ofNoFill(); 
    }

    ofEnableAlphaBlending(); 
    //the image is inside swMenu. fix this. 
    startSingingButt.draw(50, ofGetHeight() - 250); 


    
    //the actual scene
    ofEnableAlphaBlending();
    ofSetColor(213, 226, 234); 
    ofPushMatrix(); 
    ofTranslate(0, -100);
    if(!songSM->getCurSceneChanged(false)) {
        songs[songSM->getCurScene()]->draw();
    }
    ofPopMatrix();     
    ofDisableAlphaBlending();
    
    //flashing antenna    
    bool on = true; 
    if (wSong.begin) {
        for (int i = 0; i < 3; i++) {
            if (ofGetFrameNum() %3 ==0) {
                ofEnableAlphaBlending();
                ofSetColor(255);
                if (on) sparks.draw(80,-60);
                ofDisableAlphaBlending();
                on = !on; 
            }
        }
    }
    
    ofDisableAlphaBlending();
    
    //fix this mess
    songMenu.draw(); 

    cout <<"YOU SING? " << youSing << " BEGIN? " << wSong.begin << endl; 
    //if switched on and layla is finished, the turtle strobes
    //if (youSing && !wSong.begin  )  {
    if (youSing  && !wSong.begin && !layla[songMenu.getSongPressed()].getIsPlaying()) {
        cout << "LIGHT UP " << endl; 
        lightSize = ofMap(singWordSize, .7f, 1, 100, 255);
        songMenu.lightUp (lightSize); 

    } else {
        songMenu.lightUp(255);
    }

}

//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void speakScene::touchDown(ofTouchEventArgs &touch){
    
    //songs[songSM->getCurScene()]->touchDown(touch);
    
    songMenu.touchDown(touch);
    
    //wSong.touchDown(touch);
    
    /*
    if (touch.x < (30 + 150) && touch.y > (ofGetHeight() - 300)) {
        startSingingButt.touchDown(touch);
    }
     */

    //switchButt.touchDown(touch);
    
     startSingingButt.touchDown(touch);
}


//--------------------------------------------------------------
void speakScene::touchMoved(ofTouchEventArgs &touch){
    
    //songs[songSM->getCurScene()]->touchDown(touch);
    songMenu.touchMoved(touch);
    
    //wSong.touchMoved(touch);
    
}


//--------------------------------------------------------------
void speakScene::touchUp(ofTouchEventArgs &touch){

    songs[songSM->getCurScene()]->touchUp(touch);
    
    /*
    songMenu.touchUp(touch);
    if(songMenu.touchMenuRes){
        
        cout<<"touch menu res true "<<songSM->getCurScene() <<endl;
        //songs[songSM->getCurScene()]->activate();
        //wSong.letsReset(); 
        //wSong.setSong(songMenu.getSongPressed()); //lia
        
    }
    songMenu.touchMenuRes = false;
    */
    
    /*
    wSong.touchUp(touch);
    if (showSongButtons) wSong.touchDownButtons(touch);
    showSongButt.touchUp(touch);
     */
    
    //if you press play and the song is done, reset and try again. if not, just pause it. 
    
    /*
    if (touch.x < (30 + 150) && touch.y > (ofGetHeight() - 300)) {
        if (startSingingButt.isPressed()) {
                youSing = false; 
                if (wSong.atEnd) {
                    wSong.reset = true;
                    wSong.begin = true; 
                } else {
                    wSong.begin = !wSong.begin;
                }
            
        }
    } 
     */

    cout << "buttonState " << buttonState << endl; 

   // if (touch.x < (30 + 150) && touch.y > (ofGetHeight() - 300)) {
        if (startSingingButt.isPressed()) {
            if (noneLoaded) {
                switchOn = true;
                noneLoaded = false; 
            }
            else if (!wSong.atEnd) {
                wSong.begin = !wSong.begin;
                 
            } else {
                wSong.reset = true;
                //wSong.begin = false; 
                switchOn = true;
                wSong.atEnd = false; 
                youSing = false; 
            }
        }
            /*
            switch (buttonState) {
                case 0:
                    switchOn = true;
                    break;
                    
                case 1:
                    wSong.begin = !wSong.begin;
                    break;
            }
            
            cout << "uh oh, pressed " << endl; 
            //if you're at the end, go to guide mode
            if (wSong.atEnd){
                
                cout << "AT END " << endl; 
                buttonState = 0;  
                wSong.reset = true;
                wSong.begin = false; 
                youSing = false;                 
            } 
            
            //if not at the end, stay at singing mode
            else {
                buttonState = 1; 
            }
        }
   // }
    */
    
    startSingingButt.touchUp(touch);
    
    if (touch.x < (30 + 150) && touch.y > (ofGetHeight() - 300)) {
        
    }
     

    /*
    if (switchButt.isPressed()) {
        cout << "PRESSED *********" << endl; 
        switchOn = true;

        
    }
     */

    //switchButt.touchUp(touch);
    
    
    
}




