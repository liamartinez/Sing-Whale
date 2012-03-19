//
//  callSceneName.h
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_callSceneName_h
#define SingWhale01_callSceneName_h


#pragma once
#include "swBaseScene.h"
#include "baseButton.h"
#include "callScene.h"

enum {
    CALL_SCENE_NAME_DUCK,
    CALL_SCENE_NAME_PAIL,
    CALL_SCENE_NAME_SNAIL,
    CALL_SCENE_NAME_TOTAL
};

class callSceneName : public callScene {
public:
    void setup();
    void update();
    void draw();
    
    void activate(); 
    void deactivate();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    
private:
    ofImage callScreen; //lia - replace pictures here. 
    
    /*
    //maybe put these buttons in base scene? 
    baseButton  next;
    baseButton  tryAgain; 
    
    string song; 
     */
};

#endif



