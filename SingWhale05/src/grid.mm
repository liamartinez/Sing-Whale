//
//  grid.cpp
//  OctAnalyzeWithGrid
//
//  Created by Lia Martinez on 3/15/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "grid.h"


grid::grid() {
    
    incVertz        = .2;   //spaces between joints
    numVertz        = 3;   //number of circles
    lenVertz        = 30;   //total length
    
    circleSize      = 1; 
    
    numNote         = 1; 
    skeleton        = false; 
    anchorHeight    = 200; 
    
    damping         = .1;
    frequency       = 1; 
    
    
    
}

void grid::setWorld(int num){
    if (num == 1) theWorld = box2d;
    if (num == 2) theWorld = box2dDupe;
}

void grid::setLocation(int locationX, int locationY){
    startLoc.set(locationX, locationY);
    startLocBot.set(startLoc.x, startLoc.y + lenVertz); 
    endLoc.set (startLoc.x + lenHorz, startLoc.y); 
    endLocBot.set(endLoc.x, startLocBot.y);
}

ofVec2f grid::getLocation () {
    return startLoc;
}

void grid::setLength(float lenHorz_){
    lenHorz = lenHorz_;
    //lenHorz     = 820;  //total length
}

void grid::setLengthDensity(int numHorz_, float incHorz_){
    numHorz = numHorz_;
    incHorz = incHorz_;
    /*
     incHorz     = .2;    //spaces between joints
     numHorz     = 100;  //number of circles
     */
}

void grid::setupBox2d(int gravX, int gravY){
    
    theWorld.init();
	theWorld.setGravity(gravX, gravY);
	theWorld.setFPS(30.0);
	//theWorld.registerGrabbing();    
    theWorld.setIterations(1, 1);
}

void grid::setupGrid() {
    //anchors
    startAnchor.setup(theWorld.getWorld(), startLoc.x, startLoc.y, circleSize);
    endAnchor.setup(theWorld.getWorld(), endLoc.x, endLoc.y, circleSize);
    startAnchorBot.setup(theWorld.getWorld(), startLocBot.x, startLocBot.y, circleSize);
    endAnchorBot.setup(theWorld.getWorld(), endLocBot.x, endLocBot.y, circleSize);
    
    //create the top/bot circles
    for (int i=0; i<numHorz-1; i++) {
        
		ofxBox2dCircle topCircle;
		topCircle.setPhysics(100, 0, 5);//density, bounce, friction
		topCircle.setup(theWorld.getWorld(), startLoc.x + ((lenHorz/numHorz)* (i+1)), startLoc.y, 2); //move this by one point so it doesn't get knotted up
        topCircle.setFixedRotation(false);
		topCircles.push_back(topCircle);
        
        ofxBox2dCircle bottomCircle;
		bottomCircle.setPhysics(100, 0, 5);//density, bounce, friction
		bottomCircle.setup(theWorld.getWorld(), startLocBot.x+((lenHorz/numHorz)* i), startLocBot.y, 2);
        bottomCircle.setFixedRotation(false);
		bottomCircles.push_back(bottomCircle);
	}
    
    //create the top/bot joints
    for (int i = 0; i < topCircles.size(); i++) {
        ofxBox2dJoint topJoint; 
        ofxBox2dJoint heightJoint;
        ofxBox2dJoint bottomJoint; 
        ofxBox2dJoint connectJointTop; 
        ofxBox2dJoint connectJointBot; 
        
        if (i == 0 ) {
            topJoint.setup (theWorld.getWorld(), startAnchor.body, topCircles[i].body, frequency, damping, false); 
            connectJointTop.setup(theWorld.getWorld(), topCircles[i].body, topCircles[i+1].body,frequency, damping, false);
            
            bottomJoint.setup (theWorld.getWorld(), startAnchorBot.body, bottomCircles[i].body,frequency, damping, false); 
            connectJointBot.setup(theWorld.getWorld(), bottomCircles[i].body, bottomCircles[i+1].body,frequency, damping, false);
        }
        
        else if (i == topCircles.size()-1) {
            topJoint.setup(theWorld.getWorld(), topCircles[i].body, endAnchor.body, frequency, damping, false);
            
            bottomJoint.setup(theWorld.getWorld(), bottomCircles[i].body, endAnchorBot.body,frequency, damping, false);
        }
        
        else {
            topJoint.setup(theWorld.getWorld(), topCircles[i].body, topCircles[i+1].body,frequency, damping, false);
            
            bottomJoint.setup(theWorld.getWorld(), bottomCircles[i].body, bottomCircles[i+1].body,frequency, damping, false);
        }
        
        //the height joints will grow later depending on octave analysis
        heightJoint.setup(theWorld.getWorld(), topCircles[i].body, bottomCircles[i].body, frequency, damping, false);
        heightJoint.setLength(lenVertz);  
        
        connectJointTop.setLength(incHorz);
        topJoint.setLength(incHorz);
        topJoints.push_back(connectJointTop); 
        topJoints.push_back(topJoint); 
        
        connectJointBot.setLength(incHorz);
        bottomJoint.setLength(incHorz);
        bottomJoints.push_back(connectJointBot); 
        bottomJoints.push_back(bottomJoint); 
        
        heightJoints.push_back(heightJoint);
    }
    
    //create the left/ right circles
    for (int i=0; i<numVertz-1; i++) {
		ofxBox2dCircle leftCircle;
		leftCircle.setPhysics(30.0, 0.003, 5);//density, bounce, friction
		leftCircle.setup(theWorld.getWorld(), startLoc.x, startLoc.y + ((lenVertz/numVertz) *i ), 2);
        leftCircle.setFixedRotation(false);
		leftCircles.push_back(leftCircle);
        
        ofxBox2dCircle rightCircle;
		rightCircle.setPhysics(30.0, 0.003, 5);//density, bounce, friction
		rightCircle.setup(theWorld.getWorld(), endLoc.x, endLoc.y + ((lenVertz/numVertz) *i ), 2);
        rightCircle.setFixedRotation(false);
		rightCircles.push_back(rightCircle);
	}
    
    //create the left/ right joints
    for (int i = 0; i < leftCircles.size(); i++) {
        ofxBox2dJoint leftJoint; 
        ofxBox2dJoint rightJoint; 
        ofxBox2dJoint connectJointLeft; 
        ofxBox2dJoint connectJointRight; 
        
        if (i == 0 ) {
            leftJoint.setup (theWorld.getWorld(), startAnchor.body, leftCircles[i].body); 
            connectJointLeft.setup(theWorld.getWorld(), leftCircles[i].body, leftCircles[i+1].body);
            
            rightJoint.setup (theWorld.getWorld(), endAnchor.body, rightCircles[i].body); 
            connectJointRight.setup(theWorld.getWorld(), rightCircles[i].body, rightCircles[i+1].body);
        }
        
        else if (i == leftCircles.size()-1) {
            leftJoint.setup(theWorld.getWorld(), leftCircles[i].body, startAnchorBot.body);
            
            rightJoint.setup(theWorld.getWorld(), rightCircles[i].body, endAnchorBot.body);
        }
        
        else {
            leftJoint.setup(theWorld.getWorld(), leftCircles[i].body, leftCircles[i+1].body);
            
            rightJoint.setup(theWorld.getWorld(), rightCircles[i].body, rightCircles[i+1].body);
        }
        
        connectJointLeft.setLength(incVertz);
        leftJoint.setLength(incVertz);
        leftJoints.push_back(connectJointLeft); 
        leftJoints.push_back(leftJoint); 
        
        connectJointRight.setLength(incVertz);
        rightJoint.setLength(incVertz);
        rightJoints.push_back(connectJointRight); 
        rightJoints.push_back(rightJoint); 
    }
}

void grid::update() {
 	theWorld.update();	
}

void grid::drawGrid() {
    startAnchor.draw();
    startAnchorBot.draw();
    endAnchor.draw();
    endAnchorBot.draw(); 
    
    if (skeleton) {
        ofSetLineWidth(2);
        
        for(int i=0; i<topCircles.size(); i++) {
            ofFill();
            ofSetHexColor(0x01b1f2);
            topCircles[i].draw();
            topCircles[i].setRadius(circleSize);
            bottomCircles[i].draw();
            bottomCircles[i].setRadius(circleSize);
            heightJoints[i].draw(); 
        }
        
        ofSetColor(0); 
        for (int i = 0; i < topJoints.size(); i++) {
            topJoints[i].draw(); 
            bottomJoints[i].draw(); 
           
            
        }
            
        
        for(int i=0; i<leftCircles.size(); i++) {
            ofFill();
            ofSetHexColor(0x01b1f2);
            leftCircles[i].draw();
            leftCircles[i].setRadius(circleSize);
            rightCircles[i].draw();
            rightCircles[i].setRadius(circleSize);
        }
        
        ofSetColor(0); 
        for (int i = 0; i < leftJoints.size(); i++) {
            leftJoints[i].draw(); 
            rightJoints[i].draw(); 
        }
    }
    
    if (!skeleton) {
        if (fillSong) {
            ofFill();
        } else {
            ofNoFill(); 
        }
        ofSetLineWidth(2);
        ofSetColor(79, 178, 245);
        ofBeginShape();
        
        for (int i = 0; i < topCircles.size(); i++) {
            ofVec2f pos; 
            ofVec2f firstPos; 
            
            if (i == 0) {
                firstPos = topCircles[i].getPosition(); 
                ofCurveVertex(firstPos.x, firstPos.y);
            }
            else if (i == topCircles.size()-1) {
                firstPos = topCircles[i].getPosition(); 
                pos = topCircles[i].getPosition();
                ofCurveVertex(pos.x, pos.y);
                ofCurveVertex(firstPos.x, firstPos.y);
            }
            else {   
                pos = topCircles[i].getPosition();
                ofCurveVertex(pos.x, pos.y);
            }
        }
        
        for (int i = bottomCircles.size()-1; i >= 0; i--) {
            ofVec2f pos; 
            pos = bottomCircles[i].getPosition();
            ofCurveVertex(pos.x, pos.y);
        }
        
        ofEndShape(true); 
        
        
    }
    
    for(int i=0; i<waters.size(); i++) {
		ofFill();
		ofSetHexColor(0xf6c738);
		waters[i].draw();
	}
}

void grid::seeGrid() {
    skeleton = !skeleton;
}

void grid::letsGo(int num, int height){
    numNote = num; 
    heightJoints[numNote].setLength(height);
}

void grid::letsReset(int nowLocTop_){
    /*
     int nowLoc = nowLocTop_;
     bool isDone = false; 
     ofVec2f nowLocTop; 
     nowLocTop.y = topCircles[nowLoc].getPosition().y; 
     
     ofVec2f origTop;
     ofVec2f origBot;
     
     origTop.set(startLoc.x + ((lenHorz/numHorz)* (numNote+1)), startLoc.y);
     origBot.set(startLocBot.x+((lenHorz/numHorz)* numNote), startLocBot.y);
     
     for (int i = nowLocTop.y; i < origTop.y; i++) {
     //topCircles[i].setPosition(origTop.x, i);
     if (i == origTop.y-1) isDone = true; 
     cout << i << endl; 
     cout << isDone << endl;
     }
     
     if (isDone) {
     isDone = false; 
     
     */
    topCircles[numNote].setPosition(startLoc.x + ((lenHorz/numHorz)* (numNote+1)), startLoc.y);
    bottomCircles[numNote].setPosition(startLocBot.x+((lenHorz/numHorz)* numNote), startLocBot.y);
    //}
    
}

void grid::clearGrid(){
    topCircles.clear();
    bottomCircles.clear(); 
    leftCircles.clear();
    rightCircles.clear(); 
    
    topJoints.clear();
    bottomJoints.clear(); 
    heightJoints.clear(); 
    rightJoints.clear();
    leftJoints.clear(); 
    //what about anchors?
}


void grid::attractReset() {
    
    
	for(int i=0; i<topCircles.size(); i++) {
        
        ofVec2f pointsAbove; 
        pointsAbove.x =  topCircles[i].getPosition().x;
        pointsAbove.y = startLoc.y - 100;
        
        ofVec2f pointsBelow; 
        pointsBelow.x =  topCircles[i].getPosition().x;
        pointsBelow.y = startLoc.y +100;
        
        topCircles[i].addAttractionPoint(pointsAbove, .3);
        bottomCircles[i].addAttractionPoint(pointsBelow, .3);
		
		
	}
    
}
























