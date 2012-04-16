//
//  songSceneManager.h
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale01_songSceneManager_h
#define SingWhale01_songSceneManager_h

#include "ofxSceneManager2.h"

enum song {
    SONG_WAITING, 
    SONG_ZERO, 
    SONG_ONE,
    SONG_TWO,
    SONG_THREE,
    SONG_FOUR,
    SONG_FIVE, 
    SONG_SIX,
    SONG_SEVEN,
    SONG_EIGHT, 
    SONG_NINE,
    SONG_WRONG, 
    SONG_TOTAL_SCENES //Always keep this one in here and keep it last!
};

class songSceneManager : public ofxSceneManager2 {
public:
    static songSceneManager* getInstance();
private:
    songSceneManager();
    ~songSceneManager();
    
    static songSceneManager* psongSceneManager;
};

#endif
