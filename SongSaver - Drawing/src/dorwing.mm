//
//  dorwing.cpp
//  emptyExample
//
//  Created by Lia Martinez on 4/6/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "dorwing.h"


//--------------------------------------------------------------
dorwing::dorwing() {
    
}

//--------------------------------------------------------------

void dorwing::setup() {
    TTF.loadFont("mono.ttf", 7);
}

//--------------------------------------------------------------

void dorwing::draw() {
    
    
    //draw the main shape
    if (songPoints.size() != 0) {
        
        ofNoFill(); 
        ofSetLineWidth(2);
        
        /*
         if (fillOn) {
         ofFill();
         } else {
         ofNoFill(); 
         }
         */
        
        ofFill();
        
        ofBeginShape();
       ofSetHexColor(0xe0be21); 
        
        for (int i = 0; i < songPoints.size(); i++){
            songPoints[i].wriggle(5);
            
            if (i == 0){
                /*
                ofCurveVertex(songPoints[0].pos.x, songPoints[0].pos.y); // we need to duplicate 0 for the curve to start at point 0
                ofCurveVertex(songPoints[0].pos.x, songPoints[0].pos.y); // we need to duplicate 0 for the curve to start at point 0
                 
                 */
                
                ofCurveVertex(songPoints[0].pos.x, ofGetHeight()/2);
                ofCurveVertex(songPoints[0].pos.x, ofGetHeight()/2);
            } else if (i == songPoints.size()-1){
                //ofCurveVertex(songPoints[i].pos.x, songPoints[i].pos.y);
                /*
                ofCurveVertex(songPoints[0].pos.x, songPoints[0].pos.y);	// to draw a curve from pt 6 to pt 0
                ofCurveVertex(songPoints[0].pos.x, songPoints[0].pos.y);	// we duplicate the first point twice
                 */
                ofCurveVertex(songPoints[0].pos.x, ofGetHeight()/2);
                ofCurveVertex(songPoints[0].pos.x, ofGetHeight()/2);
            } else {
                ofCurveVertex(songPoints[i].pos.x, songPoints[i].pos.y);
            }
        }
        
        ofEndShape(true);
    }
    
    
    /*
    // show a faint the non-curve version of the same polygon:
    ofEnableAlphaBlending();
    ofNoFill();
    ofSetLineWidth(1);
    ofSetColor(0,0,0,40);
    ofBeginShape();
    
    
    for (int i = 0; i < songPoints.size(); i++){
        ofVertex(songPoints[i].pos.x, songPoints[i].pos.y);
        
    }
    
    ofEndShape(false);
    
    
    ofSetColor(0,0,0,80);
    
    
    for (int i = 0; i < songPoints.size(); i++){
        if (songPoints[i].bOver == true) ofFill();
        else ofNoFill();
        ofCircle(songPoints[i].pos.x, songPoints[i].pos.y,4);
        
        
        TTF.drawString(ofToString(i), songPoints[i].pos.x, songPoints[i].pos.y - 10); 
        
        ofSetColor(0,0,0,80);
    }
    */

    
}

//--------------------------------------------------------------

void dorwing::update() {
    if (songPoints.size() !=0) {
        for (int i = 0; i < songPoints.size(); i++) {
           songPoints[i].pos.y = songPoints[i].pos.y + songPoints[i].floatValue;  
        }
    }
}

//--------------------------------------------------------------

void dorwing::letsGo(int num, int height_) {
    
    int height = height_; 
    height = ofGetHeight()/2 - height; 
    
    vertex songPoint; 
    songPoint.pos.x = num * 5;
    songPoint.pos.y = height; 
    
    songPoint.bOver 			= false;
    songPoint.bBeingDragged 	= false;
    
    vertex songPoint2; 
    songPoint2.pos.x = (num * 5) + 15;
    songPoint2.pos.y = height + 15; 
    
    songPoint2.bOver 			= false;
    songPoint2.bBeingDragged 	= false;
    
    if (songPoints.size() > 2 ) {
        songPoints.insert(songPoints.end() - (songPoints.size()/2)-1, songPoint);
        songPoints.insert(songPoints.end() - (songPoints.size()/2), songPoint2);
    } else {
        songPoints.push_back(songPoint); 
    }

    
}

//--------------------------------------------------------------

void dorwing::reset() {
    songPoints.clear(); 
}
//--------------------------------------------------------------
void dorwing::touchDown(ofTouchEventArgs &touch){
    if( touch.id == 0 ){
        
        if (songPoints.size()!=0) {
            
            for (int i = 0; i < songPoints.size(); i++){
                float diffx = touch.x - songPoints[i].pos.x;
                float diffy = touch.y - songPoints[i].pos.y;
                float dist = sqrt(diffx*diffx + diffy*diffy);
                if (dist < 10 ){
                    songPoints[i].bBeingDragged = true;
                    //thisOne = i; 
                } else {
                    songPoints[i].bBeingDragged = false;
                }	
            }
        }
	}
}

//--------------------------------------------------------------
void dorwing::touchMoved(ofTouchEventArgs &touch){
    
    if( touch.id == 0 ){
        for (int i = 0; i < songPoints.size(); i++){
            if (songPoints[i].bBeingDragged == true){
                songPoints[i].pos.x = touch.x;
                songPoints[i].pos.y = touch.y;
            }
        }
	}
    /*
    vertex songPoint; 
    songPoint.pos.x = touch.x; 
    songPoint.pos.y = touch.y; 
    
    songPoint.bOver 			= false;
    songPoint.bBeingDragged 	= false;
    songPoint.radius           = 10;

    songPoints.push_back(songPoint);
     */
}

//--------------------------------------------------------------
void dorwing::touchUp(ofTouchEventArgs &touch){
    
    if( touch.id == 0 ){
        
        if (songPoints.size()!=0) {
            for (int i = 0; i < songPoints.size(); i++){
                songPoints[i].bBeingDragged = false;	
            }
        }
	}
    
}

//--------------------------------------------------------------
void dorwing::touchDoubleTap(ofTouchEventArgs &touch){
    
    
}

