#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxXmlSettings.h"
#include "baseButton.h"
#include "ofxFreeType2.h"
#include "vertex.h"

#define MOUTH_EDGE 38

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
    void letsFloat(); 
    void smile(int amt); 
    void frown(int amt); 
    void drawMode(); 
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
    baseButton  wriggleButton; 
    bool        wriggleOn; 
    baseButton  TfloatButton; 
    bool        translateFloat; 
    baseButton  loadWhale; 
    baseButton  smileButton; 
    bool        smileOn; 
    baseButton  frownButton;
    bool        frownOn; 
    baseButton  drawModeButton; 
    bool        drawOn; 
    
    
    void        setupAllButtons(); 
    void        drawAllButtons(); 
    void        touchUpAllButtons(ofTouchEventArgs &touch); 
    void        touchDownAllButtons(ofTouchEventArgs &touch); 
    
    ofxFreeType2 font; 
    
    ofImage     whaleGuide; 
    
    //animating
    ofVec2f     whaleLoc; 
    float       floatY; 
    float       amplitude;
    float       period; 
    float       dx;
    float       theta; 
    int         touchThresh; 
    int         mouthPos; 
};


