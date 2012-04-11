#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
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

	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
    
    void setLastAngle(float ang); 
    
    //current state of the rotation  
    ofQuaternion curRot;  
    ofQuaternion nextRot; 
    
    //a place to store the mouse position so we can measure incremental change  
    ofVec2f lastMouse;  
    float   nextAngle; 
    float   lastAngle; 
    float   angle; 
    
    ofRectangle box; 
    
    float future; 
    
    float newAngle; 
    
    ofImage carrot; 
    
    //
    
    ofColor red; 
    ofColor blue; 
    float lerpAmount; 
    


};


