//
//  songTwo.h
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_songTwo_h
#define SingWhale01_songTwo_h

#include "speakScene.h"
#include "baseButton.h"

enum {
    SONG_TWO_FIRST,
    SONG_TWO_SECOND,
    SONG_TWO_THIRD, 
    SONG_TWO_TOTAL
};

class songTwo : public songBaseScene {
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
    
    ofImage songTwo[SONG_TWO_TOTAL]; 
        baseButton button; 
    
};

#endif
