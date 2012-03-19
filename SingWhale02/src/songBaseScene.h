//
//  songBaseScene.h
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_songBaseScene_h
#define SingWhale01_songBaseScene_h

#pragma once
#include "songSceneManager.h"
#include "swAssetManager.h"
#include "ofxSceneManagerScene.h"

class songSceneManager; //why is there a class declared here? 

class songBaseScene : public ofxSceneManagerScene {
public:
    songBaseScene();
    virtual void setup();
    virtual void update();
    virtual void draw();
    
    string sceneName; //?
    
    songSceneManager* songSM;
    swAssetManager* swAssets;
    
    ofxSceneManager2 mgr;
protected:
    void drawGrid();
};

#endif