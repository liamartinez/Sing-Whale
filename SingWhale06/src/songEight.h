//
//  songEight.h
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale04_songEight_h
#define SingWhale04_songEight_h

#include "speakScene.h"
#include "baseButton.h"

enum {
    SONG_EIGHT_FIRST,
    SONG_EIGHT_SECOND,
    SONG_EIGHT_THIRD,
    SONG_EIGHT_FOURTH,
    SONG_EIGHT_TOTAL
};

class songEight : public songBaseScene {
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
    
    ofImage songEight[SONG_EIGHT_TOTAL]; 
    baseButton  button; 
};


#endif
