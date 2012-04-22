//
//  callScene.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 2/26/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "callScene.h"

//------------------------------------------------------------------
void callScene::setup() {
    hasReturned = false; 
}



//------------------------------------------------------------------
void callScene::update() {
    switch(mgr.getCurScene()) {
        case CALL_SCENE_FIRST:
            //Do stuff
            break;  
        case CALL_SCENE_SECOND:
            nameSong.update(); 
            break;    
        case CALL_SCENE_THIRD:
            nameSong.update(); 
            //Do stuff
            break;    
        case CALL_SCENE_FOURTH:
            //Do stuff
            break;    
    }
}

//------------------------------------------------------------------
void callScene::activate() {
    //start with the first scene when activated. 
    
    if (hasReturned) {
        mgr.setCurScene(CALL_SCENE_FOURTH);
    } else {
        mgr.setCurScene(CALL_SCENE_FIRST);
    }
    
    //load here, not setup
    callScreen.loadImage("images/BG.png");
    callWhale.loadImage("images/call2.png");
    next.setLabel("NEXT", &swAssets->nevis22);
    tryAgain.setLabel("TRY AGAIN", &swAssets->nevis22);
    song = " -> SONG INTERFACE HERE <- " ; 

    cout << "Activate Call" << endl;
    textStart.set(ofGetWidth()/2, ofGetHeight()/3);
    
    nameSong.setup(); 
    
}

//------------------------------------------------------------------
void callScene::deactivate() {
    cout << "Deactivate Call" << endl;
    
    callScreen.clear();
    
}


//------------------------------------------------------------------
void callScene::draw() {
    cout << "Drawing Call screen" << endl;
    
    ofSetColor(255, 255, 255);
    callScreen.draw(0,0);
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    next.draw(ofGetWidth() - 550, ofGetHeight()-100); 

    switch(mgr.getCurScene()) {
        case CALL_SCENE_FIRST:
            message = "Why helloooo there!"; 

            break;
            
        case CALL_SCENE_SECOND:
            message = "Im keo! \nIm the resident WHALE expert in these parts!  ";    
            break;
            
        case CALL_SCENE_THIRD:
            message = "Do you want to learn how to speak whale? ";    
            break;   
            
        case CALL_SCENE_FOURTH:
            message = "Whoops! I can't hear you. \n Whenever you want to say something, \n press this button:  "; 
            break;
            
        case CALL_SCENE_FIFTH:
            message = "Try it! ";    
            break;
            
        case CALL_SCENE_SIXTH:
            message = "Great! Did you see how the waves changed \nwhen you said something?  ";    
            break;
            
        case CALL_SCENE_SEVENTH:
            message = "Try it again! ";    
            break;
            
        case CALL_SCENE_EIGHTH:
            message = "Okay, now that I know I can hear you, \nlet me introduce you to \nour OTHER whale expert!" ;    
            break;
            
        case CALL_SCENE_NINTH:
            message = " This is my friend Layla.  ";    
            break;
            
        case CALL_SCENE_TENTH:
            message = "So the FIRST THING we need to know about speaking in whale \nis that you have to STRETCH YOUR FACE \nand make your mouth REALLY WIDE and \ntalk REALLY LOUD like this:  ";    
            break;
        case CALL_SCENE_ELEVENTH:
            message = "ok you try!! ";    
            break;
            
        case CALL_SCENE_TWELFTH:
            message = "Nice face stretching! \nNow you’re ready for your first word.   ";    
            break;
            
        case CALL_SCENE_THIRTEENTH:
            message = "This is how you say HELLO! in whale...  ";    
            break;
        case CALL_SCENE_FOURTEENTH:
            message = "ok you try! Try to match up \nyour waves with layla’s!  ";    
            break;
        case CALL_SCENE_FIFTEENTH:
            message = "You’ve got it! Your first word in whale! \nHooray!  ";    
            break;
        case CALL_SCENE_SIXTEENTH:
            message = "you got it, here he comes!  ";    
            break;
        case CALL_SCENE_SEVENTEENTH:
            message = "If you want to tell him something, \nchoose from the pictures on the side. ";    
            break;
        case CALL_SCENE_EIGHTEENTH:
            message = "Then TAP the phrase \nto hear the translation!   ";    
            break;
        case CALL_SCENE_NINETEENTH:
            message = "Dont forget to press this button to speak whale!!  ";    
            break;

            /*
        case CALL_SCENE_SECOND:
            message = "This is how you say her name."; 
            nameSong.draw(); 
            nameSong.loadSong("name.xml");
            nameSong.setSong(0);
            break;
            
        case CALL_SCENE_THIRD:
            message = "Now you try."; 
            tryAgain.draw(ofGetWidth()/2 - 300, ofGetHeight()-100); 
            next.setLabel("CORRECT", &swAssets->nevis22);
            //nameSong.showGrid = true; 
            nameSong.draw(); 
            break;
            
        case CALL_SCENE_FOURTH:
            message = "Wheee! You did it! \nHere comes Plulu!"; 
            ofEnableAlphaBlending();
            callWhale.draw(0,0);
            next.setLabel("NEXT", &swAssets->nevis22);
            ofDisableAlphaBlending();
            break;
             */
    }
    
    
    textW = swAssets->nevis48.getStringWidth(message);
    swAssets->nevis48.drawString(message, textStart.x - textW/2, textStart.y);
    
}



//--------------------------------------------------------------
//Event Listeners

//--------------------------------------------------------------
void callScene::touchDown(ofTouchEventArgs &touch){
    tryAgain.touchDown(touch);
    next.touchDown(touch);
    nameSong.touchDown(touch);
}


//--------------------------------------------------------------
void callScene::touchMoved(ofTouchEventArgs &touch){
    tryAgain.touchMoved(touch);
    next.touchMoved(touch);
    nameSong.touchMoved(touch);
}


//--------------------------------------------------------------
void callScene::touchUp(ofTouchEventArgs &touch){
    //Switch Scenes
    if(next.isPressed()) {
        if(mgr.getCurScene() == CALL_SCENE_TOTAL-1) {
            //go to the next scene when we're done. 
            swSM->setCurScene(SCENE_SPEAK);         } 
        else  {
            //otherwise, go to the next subscene. 
            mgr.setCurScene(mgr.getCurScene() + 1);      
        }
    }
    
    if(tryAgain.isPressed()) {
        swSM->setCurScene(SCENE_CALL_NAME); 
        hasReturned = true;
    }

    tryAgain.touchUp(touch);
    next.touchUp(touch);
    nameSong.touchUp(touch);
}