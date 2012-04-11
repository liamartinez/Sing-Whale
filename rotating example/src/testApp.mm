#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	
	//If you want a landscape oreintation 
	iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	ofBackground(127,127,127);
    
    carrot.loadImage("carrot.png");

    Tweenzor::init();    
    lerpAmount = 255.f;  
    
    box.set(0, ofGetHeight() - 200, ofGetWidth(), ofGetHeight() - 200); 
}

//--------------------------------------------------------------
void testApp::update(){

    Tweenzor::update(ofGetElapsedTimeMillis());
    
}

//--------------------------------------------------------------
void testApp::draw(){

    
    ofSetColor(lerpAmount, 0, 0);  
    ofRect ( 0 , 0 , 50 , 50 ) ;   
    
    ofVec3f axis;    
    curRot.getRotate(angle, axis);  
    
    newAngle = angle - future; 
    cout << "Angle " << angle << endl; 
    cout << "new Angle " << newAngle << endl; 
    
    ofDrawBitmapString("ANGLE " + ofToString(newAngle), 500,100);
    
    glPushMatrix();  
    ofTranslate(0, ofGetHeight(), 70); 

    ofRotate(newAngle, axis.x, axis.y ,axis.z);  
    
    //squares
    ofFill();
    ofSetColor(200, 100, 100);
    ofRect(-550,  - 550, 550, 550);
    ofSetColor(100, 200, 100);
    ofRect(0,  - 550, 550, 550);
    ofSetColor(100, 100, 200);
    ofRect(-550, 0, 550, 550);
    ofSetColor(200, 200, 200);
    ofRect(0, 0, 550, 550);

    ofPopMatrix(); 
    
    ofPushMatrix(); 
    ofTranslate(0, ofGetHeight() - 200, 70); 
    ofRotate(newAngle, axis.x, axis.y ,axis.z);  
    ofSetColor(0);
    ofRect(100, -300, 100, 40);
    ofRect(100, - 350, 100, 40);
    
    ofEnableAlphaBlending();
    ofPushMatrix();
    ofRotate(newAngle, axis.x, axis.y ,axis.z);  

    for (int i = 0; i < 15; i++) {
        float theta = ofMap(i, 0, 15, 0, 360);
        
        ofPushMatrix(); 
        ofRotate (theta); 
        ofSetColor(i * 15);
        carrot.draw(450, 0, 0, 50, 100);
        //ofRect (0, 100, 15, 15); 
        
        ofDrawBitmapString("THETA " + ofToString(theta), 480, 0);
        
        /*
        if (theta > 70 && theta < 100) {
            ofDrawBitmapString("YEAH!!", 480, 0);
        
        }
         */
        
        ofPopMatrix(); 
        
    }
        
    ofPopMatrix();
    ofDisableAlphaBlending();
    ofPopMatrix(); 
    
    ofNoFill(); 
    ofRect (0, ofGetHeight() - 200, ofGetWidth(), ofGetHeight() - 200);

}

 

void testApp::setLastAngle(float ang) {
    
}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
 
        lastMouse = ofVec2f(touch.x, touch.y);  

}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    ofVec2f mouse(touch.x,touch.y);  
    ofQuaternion yRot(touch.x -lastMouse.x, ofVec3f(0,0,.5));  
    ofQuaternion xRot(touch.y -lastMouse.y, ofVec3f(0,0,.5));  
    curRot *= yRot*xRot;  

    lastMouse = mouse; 


}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){

    Tweenzor::add(&future, 0, 10, 0.f, 1.5f, EASE_OUT_ELASTIC);

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}


//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){

}

