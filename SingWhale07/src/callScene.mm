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
void callScene::activate() {
    //start with the first scene when activated. 
    ofSetFrameRate(10);
    
    if (hasReturned) {
        mgr.setCurScene(CALL_SCENE_FOURTH);
    } else {
        mgr.setCurScene(CALL_SCENE_FIRST);
    }
    
    //load here, not setup
    callScreen.loadImage("images/BG.png");
    callWhale.loadImage("images/call2.png");
    next.setLabel("NEXT", &swAssets->nevis22);
    next.setSize(ofGetWidth(), ofGetHeight());
    tryAgain.setLabel("TRY AGAIN", &swAssets->nevis22);
    song = " -> SONG INTERFACE HERE <- " ; 

    cout << "Activate Call" << endl;
    textStart.set(ofGetWidth()/2, ofGetHeight()/3);
    
    nameSong.setup(); 
    //nameSong.dontCheck = true; 
    wSong.setup();
    wSong.dontCheck = true; 
    
    BG.loadImage("story/7-BG.png");
    turtleBigLeft.loadImage("intro/introbigleft.png");
    turtleBigRight.loadImage("intro/introbigright.png"); 
    turtleSmall.loadImage("intro/introsmall.png");
    turtleMed1.loadImage("intro/intromedleft.png");
    turtleMed2.loadImage("intro/intromedleft2.png");

    laylaBG.loadImage("intro/laylaBG.png");
    laylaPic.loadImage("intro/laylapic.png");
    
    /*
    laylaName.loadMovie("intro/movies/LAYLA1.m4v");
    laylaFace.loadMovie("intro/movies/LAYLA2.m4v");
    laylaHello.loadMovie("intro/movies/LAYLA3.m4v");
    */
    
    turtleButt.setup();
    turtleButt.blightUp = true; 
    turtle.loadImage("images/turtle.png");
    turtleButt.setImage(&turtle);
    
    strobey = 255; 
    Tweenzor::init();
    Tweenzor::add(&strobey, strobey,150.0, 0.f, 0.6f, EASE_IN_OUT_QUAD);
    Tweenzor::getTween( &strobey )->setRepeat( 1000, true ); 
    
        
}

//------------------------------------------------------------------
void callScene::deactivate() {
    cout << "Deactivate Call" << endl;
    
    callScreen.clear();
    
}


//------------------------------------------------------------------
void callScene::update() {
    
    wSong.update();
    
    if (wSong.atEnd) wSong.begin = false;
    Tweenzor::update(ofGetElapsedTimeMillis());
    
    
    /*
     
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
     */
    
    /*
    if (layla1Play) {
        layla1Play = false; 
        laylaName.play();
        //laylaName.idleMovie();
    }
     */
    
}

//------------------------------------------------------------------
void callScene::draw() {
    cout << "Drawing Call screen" << endl;
    
    next.draw(0, 0);

     ofSetColor(255, 255, 255);
     BG.draw(0,0); 
    //laylaName.draw(300, 300, 300,300); 
    
    
    string message = "";
    int textW = swAssets->nevis48.getStringWidth(message);
    
    //next.draw(ofGetWidth() - 550, ofGetHeight()-100); 

    ofEnableAlphaBlending(); 
    ofSetColor(255);
    switch(mgr.getCurScene()) {
        case CALL_SCENE_FIRST:
           // turtleSmall.draw(0,0); 
            
            message = "Why helloooo there!"; 

            break;
            
        case CALL_SCENE_SECOND:
            turtleMed1.draw(0,0);
            message = "Im keo! \nIm the resident WHALE expert in these parts!  ";    
            break;
            
        case CALL_SCENE_THIRD:
            turtleMed1.draw(0,0);
            message = "Do you want to learn how to speak whale? ";    
            break;   
            
        case CALL_SCENE_FOURTH:
           
            turtleBigRight.draw(0,0); 
            message = "Whoops! I can't hear you. \n Whenever you want to say something, \n press the flashing TURTLE!!  "; 
            cout << "STROBEY " << strobey << endl; 
            turtleButt.lightUp (strobey); 
            turtleButt.draw(100, ofGetHeight() - 200);
            ofPushMatrix();
            ofTranslate(300, -200);
            wSong.draw();
            ofPopMatrix();
            break;
            
        case CALL_SCENE_FIFTH:
            ofSetColor(255);
            turtleBigLeft.draw(0,0); 
            message = "Now say something and watch the waves move! ";   
            turtleButt.lightUp (strobey); 
            turtleButt.draw(100, ofGetHeight() - 200);
            ofPushMatrix();
            ofTranslate(300, -200);
            wSong.draw();
            ofPopMatrix();
            
            if (wSong.atEnd) {
                wSong.reset = true;
                mgr.setCurScene(mgr.getCurScene() + 1);
            }
            break;
            
        case CALL_SCENE_SIXTH:
            turtleMed2.draw(0,0);
            message = "Wasn't that fun?  Try it again!";  
            turtleButt.lightUp (strobey); 
            turtleButt.draw(100, ofGetHeight() - 200);
            ofPushMatrix();
            ofTranslate(300, -200);
            wSong.draw();
            ofPopMatrix();
            break;
            
        case CALL_SCENE_SEVENTH:
            turtleMed2.draw(0,0);
            message = "This is getting good! ";   
            turtleButt.lightUp (strobey); 
            turtleButt.draw(100, ofGetHeight() - 200);
            ofPushMatrix();
            ofTranslate(300, -200);
            wSong.draw();
            ofPopMatrix();
            
            if (wSong.atEnd) {
                wSong.reset = true;
                mgr.setCurScene(mgr.getCurScene() + 1);
            }
            break;
            
        case CALL_SCENE_EIGHTH:
            turtleBigRight.draw(0,0);
            message = "Okay, now that I know I can hear you, \nlet me introduce you to \nour OTHER whale expert!" ;    
            break;
            
        case CALL_SCENE_NINTH:
            
            ofEnableAlphaBlending();
            ofSetColor(255);
            

            //laylaPic.draw(0,0);

            turtleMed2.draw(0,0);
            ofSetColor(255, 255, 255);
            //layla1Play = true; 
            laylaPic.draw(0,0);   
            //laylaName.draw(600, 100);
            laylaBG.draw(0,0);
            ofDisableAlphaBlending();
            message = " This is my friend Layla.  ";    
            break;
            
        case CALL_SCENE_TENTH:
            message = "So the FIRST THING we need to know about speaking in whale \nis that you have to STRETCH YOUR FACE \nand make your mouth REALLY WIDE and \ntalk REALLY LOUD like this:  ";   
            //laylaName.stop();
            ofEnableAlphaBlending();
            ofSetColor(255);
            laylaPic.draw(0,0);
            turtleMed2.draw(0,0);
            ofSetColor(255, 255, 255);
            laylaBG.draw(0,0);
            ofDisableAlphaBlending();
            break;
        case CALL_SCENE_ELEVENTH:
            message = "See how she does it? ";   
            ofEnableAlphaBlending();
            ofSetColor(255);
             turtleMed2.draw(0,0);
            //laylaFace.play();
            laylaPic.draw(0,0);
            //laylaFace.idleMovie();
            //laylaFace.draw(550, 100);
            laylaBG.draw(0,0);
            ofDisableAlphaBlending();
            
            break;
            
        case CALL_SCENE_TWELFTH:
            message = "Nice face stretching! \nNow you’re ready for your first word.   ";    
            //laylaFace.stop();
            ofEnableAlphaBlending();
            ofSetColor(255);
            laylaPic.draw(0,0);
            turtleMed2.draw(0,0);
            ofSetColor(255, 255, 255);
            laylaBG.draw(0,0);
            ofDisableAlphaBlending();
            break;
            
        case CALL_SCENE_THIRTEENTH:
            message = "This is how you say HELLO! in whale...  ";  
            turtleMed2.draw(0,0);
            ofSetColor(255, 255, 255);
            //laylaHello.play();
            //laylaHello.idleMovie();
            laylaPic.draw(0,0);
            //laylaHello.draw(600, 100);
            laylaBG.draw(0,0);
            ofDisableAlphaBlending();

            ofPushMatrix();
            ofTranslate(300, -200);
            wSong.loadSong("intro/hello.xml");
            wSong.setSong(0);
            wSong.draw();
            ofPopMatrix();
            
            guideArea.set (315, ofGetHeight() - 245, 685, 210); 
            //if (layla[songMenu.getSongPressed()].getIsPlaying()) {
            ofFill(); 
            ofSetColor(64, 94, 109);
            songPos = ofMap(laylaHello.getPosition(), 0, 1, 0, guideArea.width);
            ofRect(guideArea.x + songPos, guideArea.y, guideArea.width - songPos, guideArea.height + 300);
            cout << "SONGPOS " << songPos << endl; 
            songPos2 = ofMap(laylaHello.getPosition(), 0, 1, 0, ofGetWidth());
            ofLine(0, 300, songPos, 300);
            ofNoFill(); 
            ofSetColor(255);
    
            break;
            
        case CALL_SCENE_FOURTEENTH:
            message = "ok you try! Try to match up \nyour waves with layla’s!  ";    
            //laylaHello.stop();
            ofPushMatrix();
            ofTranslate(300, -200);
            wSong.loadSong("intro/hello.xml");
            wSong.setSong(0);
            wSong.draw();
            ofPopMatrix();     
            
            turtleButt.lightUp (strobey); 
            turtleButt.draw(100, ofGetHeight() - 200);
            ofPushMatrix();
            ofTranslate(300, -200);
            wSong.draw();
            ofPopMatrix();
            
            break;
        case CALL_SCENE_FIFTEENTH:
            message = "You're getting it!  ";    
            turtleButt.lightUp (strobey); 
            turtleButt.draw(100, ofGetHeight() - 200);
            ofPushMatrix();
            ofTranslate(300, -200);
            wSong.draw();
            ofPopMatrix();
            
            if (wSong.atEnd) {
                wSong.reset = true;
                mgr.setCurScene(mgr.getCurScene() + 1);
            }
            break;
        case CALL_SCENE_SIXTEENTH:
            message = "Your first word in whale! And just in time, here he comes! ";    
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

            
            ofDisableAlphaBlending();
    }
    
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
             
    }
    */
    
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
    turtleButt.touchDown(touch);
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

    if (turtleButt.isPressed()) {
        if (wSong.atEnd) {
            wSong.reset = true;
            wSong.begin = true; 
        } else {
            wSong.begin = !wSong.begin;
        }
    }
    
    tryAgain.touchUp(touch);
    next.touchUp(touch);
    nameSong.touchUp(touch);
    turtleButt.touchDown(touch);
}

/*
void callScene::audioReceived 	(float * input, int bufferSize, int nChannels){
    
    ofAudioEventArgs args;
    args.buffer = input;
    args.bufferSize = bufferSize;
    args.nChannels = nChannels;
    //ofNotifyEvent(ofEvents.audioReceived, args);
    
    wSong.audioReceivedIn(args); 
    //cout << "from speakscene" << input << endl; 
    
}
*/