//
//  songFour.h
//  SingWhale03
//
//  Created by Lia Martinez on 3/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale03_songFour_h
#define SingWhale03_songFour_h

#include "speakScene.h"
#include "baseButton.h"

enum {
    SONG_FOUR_FIRST,
    SONG_FOUR_TOTAL
};

class songFour : public songBaseScene {
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
    
    ofImage songFour; 
    string dontSpeak [5]; 
    int    dontSpeakNum; 
};


#endif
