//
//  swBaseScene.h
//  SingWhale01
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_swBaseScene_h
#define SingWhale01_swBaseScene_h

#pragma once
#include "swSceneManager.h"
#include "swAssetManager.h"
#include "ofxSceneManagerScene.h"

class swSceneManager; //why is there a class declared here? 

class swBaseScene : public ofxSceneManagerScene {
public:
    swBaseScene();
    virtual void setup();
    virtual void update();
    virtual void draw();
    
    string sceneName;
    
    swSceneManager* swSM;
    swAssetManager* swAssets;
    
    
    ofxSceneManager2 mgr;
protected:
    void drawGrid();
};

#endif
