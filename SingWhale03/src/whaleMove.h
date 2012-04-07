//
//  whaleMove.h
//  SingWhale03
//
//  Created by Lia Martinez on 4/2/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale03_whaleMove_h
#define SingWhale03_whaleMove_h

#pragma once

//#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "ofxXmlSettings.h"
#include "baseButton.h"
#include "ofxFreeType2.h"
#include "vertex.h"
#include "Boid.h"
#include "Particle.h"
#include "ParticleSystem.h"

#define MOUTH_EDGE 38
#define BLOWHOLE 44
class whaleMove {
	
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
    baseButton  boidsButton;
    bool        boidsOn; 
    baseButton  blowHoleButton;
    bool        blowHoleOn; 
    
    bool        showGuides;
    
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
    ofVec2f     eyeLoc; 
    
    //boids
    vector<Boid> boids;
    int mouseX, mouseY; 
    
    //particles
    ParticleSystem ps;
    ofPoint gravity;
    
};




#endif