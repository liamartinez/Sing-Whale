//
//  swMenu.h
//  SingWhale01
//
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.
//

#ifndef SingWhale01_swMenu_h
#define SingWhale01_swMenu_h

#pragma once
#include "ofMain.h"
#include "baseButton.h"
#include "swAssetManager.h"
#include "songSceneManager.h"
#include "ofxTweenzor.h"
#include "Tweenzor.h"

enum buttonTypes { //fill this with the different words he can say. 
    MENU_ONE,
    MENU_TWO,
    MENU_THREE,

    MENU_TOTAL
};


#define MENU_BTN_W 160                          // width of each button in BTM_MENU
#define MENU_BTN_H 60                           // height

class swMenu : public baseButton {
public:
    void setup();
    void update();
    void draw();
    
    int drawSeparatorLine(int x);                   
    
    void show();
    void hide();
    
    void touchDown(ofTouchEventArgs &touch);
    void touchMoved(ofTouchEventArgs &touch);
    void touchUp(ofTouchEventArgs &touch);
    int getSongPressed(); 
    
    string labels[MENU_TOTAL];
    string phrases[MENU_TOTAL]; 
    baseButton buttons[MENU_TOTAL];
    ofImage icons [MENU_TOTAL]; 
    
    swAssetManager* swAssets;
    songSceneManager* songSM;
    
    bool touchMenuRes; 
    
    ofPoint touchPt;
	ofPoint drag;
	bool bDragging;
    
    int songPressed; 
    
    //rotation
    ofQuaternion curRot;  
    ofVec2f lastMouse;  
    ofVec3f axis; 
    float   angle;     
    float future;     
    float futureVal; 
    float newAngle; 
    
    ofImage carrot; 
    
    GLfloat modelview[16];  
    ofVec3f translation;  
    
    GLfloat modelview2[16];  
    ofVec3f translation2;  

    bool activate; 
    int currentSong; 
    int lastSong; 
    


    
private:
    bool bShowing;
    int showingY;
    
    ofImage bgImage;
    ofImage wheel; 
};

#endif
