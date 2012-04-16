//
//  songZero.h
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale04_songZero_h
#define SingWhale04_songZero_h

#include "speakScene.h"
#include "baseButton.h"

enum {
    SONG_ZERO_FIRST,
    SONG_ZERO_TOTAL
};

class songZero : public songBaseScene {
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
    
    ofImage songZero; 
};


#endif