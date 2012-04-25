//
//  songBaseScene.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songBaseScene.h"

//------------------------------------------------------------------
songBaseScene::songBaseScene() {
    this->songSM = songSceneManager::getInstance(); //lia - find out what this means
    this->swAssets = swAssetManager::getInstance();
    
    //speakScreen.loadImage("images/BG.png");
    sceneName = "Scene Name not Set!";
    
    circleLoc.set(ofGetWidth()/2, ofGetHeight()/2); 
    
    //theWhale.setup(); 
    
    //for the animation
    amplitude = 20; 
    period = 500; 
    dx = (TWO_PI / period);
    theta += 0.02;
    
    arrow.loadImage("images/arrow_right.png");
    
    
    Tweenzor::init(); 
    
    Tweenzor::add(&tweenVal, 0.f, 50, 0.f, 8.f,  EASE_IN_OUT_SINE); 
    Tweenzor::getTween( &tweenVal )->setRepeat( 5, true );
    
    
    /*
    songOnePic.loadImage("story/1-0.png");
    for (int i = 0; i < 5; i++) {
        songZeroPic[i].loadImage("story/0-" + ofToString(i) + ".png"); 
    }
    
    
    for (int i = 0; i < 3; i++) {
        songTwoPic[i].loadImage("story/2-" + ofToString(i) + ".png"); 
    }
    
    
     

     
     for (int i = 0; i < 3; i++) {
     songThreePic[i].loadImage("story/3-" + ofToString(i) + ".png"); 
     }
     
     for (int i = 0; i < 2; i++) {
     songFourPic[i].loadImage("story/4-" + ofToString(i) + ".png"); 
     }
     
     for (int i = 0; i < 2; i++) {
     songFivePic[i].loadImage("story/5-" + ofToString(i) + ".png"); 
     }


    */

    
 
    playWhales = true; 
    
    if (playWhales) {
        for (int i = 0; i < 8; i++) {
            whaleSounds[i].loadSound("sounds/WS" + ofToString(i) + ".caf");
        }
    }
}


//------------------------------------------------------------------
void songBaseScene::setup() {
    
    //setup stuff goes here. Do I need an "activate"? 


}



//------------------------------------------------------------------
void songBaseScene::update() {
    
    //theWhale.update(); 
    Tweenzor::update(ofGetElapsedTimeMillis());
}



//------------------------------------------------------------------
void songBaseScene::draw() {
    
    
    
    //theWhale.draw(); 
    
}

//------------------------------------------------------------------
void songBaseScene::drawCircle() {
    ofSetColor(255, 100, 100);
    ofCircle(circleLoc, 100);
    
    
}

//-----------------------------------------------------------------
void songBaseScene::drawArrow() {
    
    arrow.draw(ofGetWidth() - 150, 300);
    
}
//------------------------------------------------------------------
void songBaseScene::drawGrid() {  //dont need this, but keep for now just in case. 
    
    //speakScreen.draw (0,0); 
    
    /*
    ofSetColor(255, 255, 255); 
    ofEnableAlphaBlending();
    
    ofDisableAlphaBlending();
     */
    
    /*
    int gridWidth = ofGetWidth() + MNH_GRID_CELL_SIZE; // lia - where is it getting these values?
    int gridHeight = ofGetHeight() + MNH_GRID_CELL_SIZE;
    
    glPushMatrix();
    glTranslatef(-MNH_GRID_CELL_SIZE/2, -MNH_GRID_CELL_SIZE/2, 0);
    
    //Draw Vertical Lines
    for(int i=1; i<ceil(gridHeight/MNH_GRID_CELL_SIZE); i++) {
        ofSetColor(235, 235, 235);
        ofLine(0, MNH_GRID_CELL_SIZE * i, gridWidth, MNH_GRID_CELL_SIZE * i);
    }
    
    //Draw Horizontal Lines
    for(int i=1; i<ceil(gridWidth/MNH_GRID_CELL_SIZE); i++) {
        ofSetColor(235, 235, 235);
        ofLine(MNH_GRID_CELL_SIZE * i, 0, MNH_GRID_CELL_SIZE * i, gridHeight);
    }
    
    glPopMatrix();
     */ 
}

//--------------------------------------------------------------

float songBaseScene::floatVal() {
    
    float val; 
    
    val = sin(theta)*amplitude;
    theta+=dx;    
    
    return val; 
    
}


//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songBaseScene::touchDown(ofTouchEventArgs &touch){

    //theWhale.touchDown(touch);
    
}


//--------------------------------------------------------------
void songBaseScene::touchMoved(ofTouchEventArgs &touch){

    //wSong.touchMoved(touch);
    //theWhale.touchMoved(touch);
    
}


//--------------------------------------------------------------
void songBaseScene::touchUp(ofTouchEventArgs &touch){

    //wSong.touchUp(touch);
    //theWhale.touchUp(touch);
    
    
}
//--------------------------------------------------------------
void songBaseScene::touchDoubleTap(ofTouchEventArgs &touch){
    
    //wSong.touchUp(touch);
    //theWhale.touchDoubleTap(touch);
    
}

void songBaseScene::audioReceived 	(float * input, int bufferSize, int nChannels){
    //wSong.audioReceived(input, bufferSize, nChannels); 
    //cout << "from speakscene" << input << endl; 
}





