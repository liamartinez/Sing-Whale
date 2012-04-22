//
//  songThree.h
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_songThree_h
#define SingWhale01_songThree_h

#include "speakScene.h"
#include "baseButton.h"

enum {
    SONG_THREE_FIRST,
    SONG_THREE_SECOND,
    SONG_THREE_THIRD,
    SONG_THREE_TOTAL
};

class songThree : public songBaseScene {
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
    
    //ofImage songThree[SONG_THREE_TOTAL];
    baseButton button; 
};

#endif
