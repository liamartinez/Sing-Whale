//
//  speakScene.h
//  SingWhale01
//
//  Created by Lia Martinez on 2/27/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_speakScene_h
#define SingWhale01_speakScene_h

#pragma once

#include "swBaseScene.h"
#include "baseButton.h"

enum {
    SPEAK_SCENE_FIRST,
    SPEAK_SCENE_TOTAL
};

class speakScene : public swBaseScene {
public:
    void setup();
    void update();
    void draw();
    
    void activate(); 
    void deactivate();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    
    baseButton button;
    
private:
    
    ofImage speakScreen; //lia - replace pictures here. 
    /*
     ofImage homeScreen;
     ofImage postit; 
     */
    
    
};

#endif