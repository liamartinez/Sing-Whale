//
//  swBaseScene.cpp
//  SingWhale01
//
//  Created by Stephen Varga on 6/8/11.
//  modified by Lia Martinez on 2/26/12.
//

#include <iostream>

#include "swBaseScene.h"

//------------------------------------------------------------------
swBaseScene::swBaseScene() {
    this->swSM = swSceneManager::getInstance(); //lia - find out what this means
    this->swAssets = swAssetManager::getInstance();
    
    sceneName = "Scene Name not Set!";
}


//------------------------------------------------------------------
void swBaseScene::setup() {
}



//------------------------------------------------------------------
void swBaseScene::update() {
}



//------------------------------------------------------------------
void swBaseScene::draw() {
}


//------------------------------------------------------------------
void swBaseScene::drawGrid() {  //dont need this, but keep for now just in case. 
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
}


