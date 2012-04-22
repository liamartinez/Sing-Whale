//
//  songFive.h
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale04_songFive_h
#define SingWhale04_songFive_h


#include "speakScene.h"
#include "baseButton.h"
#include "Boid.h"
#include "Particle.h"
#include "ParticleSystem.h"

enum {
    SONG_FIVE_FIRST,
    SONG_FIVE_SECOND,
    SONG_FIVE_TOTAL
};

class songFive : public songBaseScene {
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
    
     //particles
     bool        blowHoleOn; 
    ParticleSystem ps;
    ofPoint gravity;
    
private:
    
    //ofImage songFive[SONG_FIVE_TOTAL]; 
    baseButton button; 
};

#endif
