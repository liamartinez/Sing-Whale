//
//  songWaiting.h
//  SingWhale05
//
//  Created by Lia Martinez on 4/16/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale05_songWaiting_h
#define SingWhale05_songWaiting_h

#pragma once
#include "speakScene.h"
#include "baseButton.h"

enum {
    SONG_WAITING_FIRST,
    SONG_WAITING_TOTAL
};

class songWaiting : public songBaseScene {
public:
    void setup();
    void update();
    void draw();
    
    void activate(); 
    void deactivate();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    void touchDoubleTap(ofTouchEventArgs &touch);
    
private:
    
    ofImage songWaiting; 
    string songSmallTalk [5]; 
    int    songSmallTalkNum; 
    
};

#endif

