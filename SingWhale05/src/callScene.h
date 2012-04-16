//
//  callScene.h
//  SingWhale01
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_callScene_h
#define SingWhale01_callScene_h

#pragma once
#include "swBaseScene.h"
#include "baseButton.h"
#include "whaleSong.h"

enum {
    CALL_SCENE_FIRST,
    CALL_SCENE_SECOND,
    CALL_SCENE_THIRD,
    CALL_SCENE_FOURTH,
    CALL_SCENE_TOTAL
};

class callScene : public swBaseScene {
public:
    void setup();
    void update();
    void draw();
    
    void activate(); 
    void deactivate();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);

    baseButton  next;
    baseButton  tryAgain; 
    
    string song; 
    ofVec2f     textStart; 
    
    whaleSong   nameSong; 
    
private:
    
    bool    hasReturned; 
    ofImage callScreen; //lia - replace pictures here. 
    ofImage callWhale; 

};

#endif