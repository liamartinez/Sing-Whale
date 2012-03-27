#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxXmlSettings.h"
#include "baseButton.h"
#include "ofxFreeType2.h"
#include "vertex.h"


class testApp : public ofxiPhoneApp {
	
public:
	void setup();
	void update();
	void draw();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);

    void loadXML(string name); 
    void saveXML(string name); 
    vector<vertex> whaleParts; 
    //vector<draggableVertex> whaleLines; 
    
    ofxXmlSettings XML;
    ofTrueTypeFont TTF;
    
    string xmlStructure;
    string message;
    string insertMode; 
    
    baseButton saveButton;
    baseButton loadButton; 
    baseButton resetButton; 
    baseButton deleteLastButton; 
    baseButton insertButton; 
    baseButton fillButton; 
    bool        insertOn; 
    bool        fillOn; 
    int         nearestOne; 
    int         thisOne; 
    baseButton  showImgButton; 
    bool        showImg; 
    baseButton  floatButton; 
    bool        floatOn; 
    
    ofxFreeType2 font; 
    
    ofImage     whaleGuide; 
};


