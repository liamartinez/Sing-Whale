//
//  songWrong.h
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale03_songWrong_h
#define SingWhale03_songWrong_h

#include "speakScene.h"
#include "baseButton.h"

enum {
    SONG_WRONG_FIRST,
    SONG_WRONG_TOTAL
};

class songWrong : public songBaseScene {
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
    
    ofImage songWrong; 
    string dontSpeak [5]; 
    int    dontSpeakNum; 
};


#endif
