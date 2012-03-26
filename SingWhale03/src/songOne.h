//
//  songOne.h
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_songOne_h
#define SingWhale01_songOne_h

#pragma once
#include "speakScene.h"
#include "baseButton.h"

enum {
    SONG_ONE_FIRST,
    SONG_ONE_SECOND, 
    SONG_ONE_TOTAL
};

class songOne : public songBaseScene {
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
    
    ofImage songOne; 
    
};

#endif

