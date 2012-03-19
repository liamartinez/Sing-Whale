//
//  swSceneManager.h
//  Thesis01interface
//
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.
//

#ifndef SingWhale01_swSceneManager_h
#define SingWhale01_swSceneManager_h


#include "ofxSceneManager2.h"

enum scene {
    SCENE_HOME,
    SCENE_CALL,
    SCENE_SPEAK,
    SW_TOTAL_SCENES //Always keep this one in here and keep it last!
};

class swSceneManager : public ofxSceneManager2 {
public:
    static swSceneManager* getInstance();
private:
    swSceneManager();
    ~swSceneManager();
    
    static swSceneManager* pswSceneManager;
};

#endif
