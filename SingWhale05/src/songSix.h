//
//  songSix.h
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale04_songSix_h
#define SingWhale04_songSix_h
#include "speakScene.h"
#include "baseButton.h"

enum {
    SONG_SIX_FIRST,
    SONG_SIX_TOTAL
};

class songSix : public songBaseScene {
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
    
    ofImage songSix; 
};



#endif
