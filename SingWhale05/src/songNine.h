//
//  songNine.h
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale04_songNine_h
#define SingWhale04_songNine_h

#include "speakScene.h"
#include "baseButton.h"

enum {
    SONG_NINE_FIRST,
    SONG_NINE_SECOND,
    SONG_NINE_THIRD,
    SONG_NINE_TOTAL
};

class songNine : public songBaseScene {
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
    
    ofImage songNine[SONG_NINE_TOTAL];
    ofImage songNineMom; 
    baseButton button; 
};


#endif
