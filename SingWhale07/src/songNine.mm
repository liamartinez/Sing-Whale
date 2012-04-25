//
//  songNine.cpp
//  SingWhale04
//
//  Created by Lia Martinez on 4/14/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songNine.h"

//------------------------------------------------------------------
void songNine::setup() {
    
    
}



//------------------------------------------------------------------
void songNine::update() {
    switch(mgr.getCurScene()) {
        case SONG_NINE_FIRST:
          
            break;            
    }
}

//------------------------------------------------------------------
void songNine::activate() {
    mgr.setCurScene(SONG_NINE_FIRST);
    
    for (int i = 0; i < SONG_NINE_TOTAL; i++) {
        songNine[i].loadImage("story/9-" + ofToString(i) + ".png"); 
    }
    
    songNineMom.loadImage("story/9-mom.png");
    
    button.setPos(ofGetWidth() - 150,180);
    button.setImage(&arrow);
    
    //homeScreen.loadImage("images/wires-01.png");
    //button.setImage(&homeScreen,&homeScreen);
    
    cout << "Activate Song Nine" << endl;
    textStart.set(ofGetWidth()-200, ofGetHeight()-600);
    
    momStart.set(0- songNineMom.getWidth()*3, 0);
    
    mom.loadSound("sounds/mom.caf");
 
    if (playWhales)whaleSounds[0].play();
    
    
}

//------------------------------------------------------------------
void songNine::deactivate() {
    cout << "Deactivate songNine" << endl;
    
    for (int i = 0; i < SONG_NINE_TOTAL; i++) {
        songNine[i].clear(); 
    }
    mom.stop();
    //mom.unloadSound(); 
    
}


//------------------------------------------------------------------
void songNine::draw() {
    
    
    //button.draw();
    ofTranslate(0, tweenVal);    

    
    string message = "";
    //int textW = swAssets->nevis48.getStringWidth(message);
    
    switch(mgr.getCurScene()) {
        case SONG_NINE_FIRST:
            
            songNine[SONG_NINE_FIRST].draw(0,0);     
            button.draw();
            break;
            
        case SONG_NINE_SECOND:
            songNine[SONG_NINE_SECOND].draw(0,0);    
            button.draw();
            break;
            
        case SONG_NINE_THIRD:
            
            if (!mom.getIsPlaying()) mom.play(); 
            
            ofPushMatrix(); 
            ofTranslate( momStart.x, -370); 
            ofScale(3, 3);
            momStart.x = momStart.x +10; 
            songNineMom.draw(0,0); 
            ofPopMatrix();
            
            songNine[SONG_NINE_THIRD].draw(0,0);  
            
            
            
            break;
    }

    //ofSetColor(0);
    //textW = swAssets->nevis48.getStringWidth(message);
    //swAssets->nevis48.drawString(message, textStart.x - textW/2, textStart.y);
    

    
}





//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void songNine::touchDown(ofTouchEventArgs &touch){
    button.touchDown(touch);
}


//--------------------------------------------------------------
void songNine::touchMoved(ofTouchEventArgs &touch){
    button.touchMoved(touch);
}


//--------------------------------------------------------------
void songNine::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(button.isPressed()) {
        if(mgr.getCurScene() < SONG_NINE_TOTAL - 1) {
            mgr.setCurScene(mgr.getCurScene() + 1); 
        }
    }
    button.touchUp(touch);
}

//--------------------------------------------------------------

void songNine::touchDoubleTap(ofTouchEventArgs &touch){
    
}