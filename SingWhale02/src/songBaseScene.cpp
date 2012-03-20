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
    
    speakScreen.loadImage("images/wires-03.png");
    sceneName = "Scene Name not Set!";

}


//------------------------------------------------------------------
void songBaseScene::setup() {
    
    //setup stuff goes here. Do I need an "activate"? 
    
}



//------------------------------------------------------------------
void songBaseScene::update() {


}



//------------------------------------------------------------------
void songBaseScene::draw() {

}


//------------------------------------------------------------------
void songBaseScene::drawGrid() {  //dont need this, but keep for now just in case. 
    
    ofSetColor(255, 255, 255); 
    ofEnableAlphaBlending();
    speakScreen.draw (0,0); 
    ofDisableAlphaBlending();
    ofDrawBitmapString("SPEAK SCENE", ofGetWidth()/2, ofGetHeight()/2);
    
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

