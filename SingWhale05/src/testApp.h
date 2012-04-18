#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"


#include "swSceneManager.h"

//create the main scenes
#include "homeScene.h"
#include "callScene.h"
#include "callSceneName.h"
#include "speakScene.h"
#include "ofxTweenzor.h"



class testApp : public ofxiPhoneApp {
	
public:
	void setup();
	void update();
	void draw();
	void exit();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);

    void audioReceived 	(float * input, int bufferSize, int nChannels); /* input method */

	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);

    
    
    swBaseScene* scenes[SW_TOTAL_SCENES];
    
    //Managers
    swSceneManager* swSM;
    swAssetManager* swAssets;
    
    ofSoundPlayer test; 
    //int counterVariable; 
    
};


