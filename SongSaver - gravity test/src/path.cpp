//
//  path.cpp
//  SongSaver
//
//  Created by Lia Martinez on 4/4/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "path.h"


path::path() {
    
}

void path::setupPath() {	
    
    
    // Box2d
	box2d.init();
	box2d.setGravity(0, 20);
	box2d.createGround();
	box2d.setFPS(30.0);
	
	
	// load the lines we saved...
	ifstream f;
	f.open(ofToDataPath("lines.txt").c_str());
	vector <string> strLines;
	while (!f.eof()) {
		string ptStr;
		getline(f, ptStr);
		strLines.push_back(ptStr);
	}
	f.close();
	
	for (int i=0; i<strLines.size(); i++) {
		vector <string> pts = ofSplitString(strLines[i], ",");
		if(pts.size() > 0) {
			ofxBox2dPolygon poly;
			for (int j=0; j<pts.size(); j+=2) {
				if(pts[j].size() > 0) {
					float x = ofToFloat(pts[j]);
					float y = ofToFloat(pts[j+1]);
					poly.addVertex(x, y);
				}				
			}
			poly.create(box2d.getWorld());
			polyLines.push_back(poly);
		}
	}
    
    gravy = 20; 
    
	
}

void path::updatePath() {
    
    // add some circles every so often
	if((int)ofRandom(0, 1000) == 0) {
		ofxBox2dCircle c;
		c.setPhysics(1, 0.5, 0.1);
		c.setup(box2d.getWorld(), ofRandom(20, 50), -20, ofRandom(3, 10));
		circles.push_back(c);		
	}
     
	
	box2d.update();	
}

void path::drawPath() {
    // some circles :)
    
	for (int i=0; i<circles.size(); i++) {
		ofFill();
		ofSetHexColor(0xc0dd3b);
        circles[i].setPosition(ballLoc);
		circles[i].draw();
	}
	
	ofSetHexColor(0x444342);
	ofNoFill();
	for (int i=0; i<lines.size(); i++) {
		lines[i].draw();
	}	
	for (int i=0; i<polyLines.size(); i++) {
		polyLines[i].draw();
	}	
	


}

void path::setGravity(float numGrav_, float numDir) {
    gravy = numGrav_; 
    box2d.setGravity(numDir, gravy);
    cout << "gravity " << gravy << endl; 
}

void path::moveBall (int where, int whereY) {

    ballLoc.x = where; 
    ballLoc.y = whereY + 400; 
    

}


void path::newBall() {
    //one circle
    ofxBox2dCircle c;
    c.setPhysics(1, 0.5, 0.1);
    c.setup(box2d.getWorld(), ofRandom(20, 50), 400, ofRandom(10, 20));
    circles.push_back(c);
}

//--------------------------------------------------------------
void path::exit(){
    
}

//--------------------------------------------------------------
void path::touchDown(ofTouchEventArgs &touch){
    lines.push_back(ofPolyline());
	lines.back().addVertex(touch.x, touch.y);
    
    if (touch.y > ofGetWidth()/2) {
        gravy ++; 
    } else {
        gravy --; 
    }
    
    
    box2d.setGravity(0, gravy);
}

//--------------------------------------------------------------
void path::touchMoved(ofTouchEventArgs &touch){
    lines.back().addVertex(touch.x, touch.y);   
    
    
}

//--------------------------------------------------------------
void path::touchUp(ofTouchEventArgs &touch){
    
    
    ofxBox2dPolygon poly;
	lines.back().simplify();
	
	for (int i=0; i<lines.back().size(); i++) {
		poly.addVertex(lines.back()[i]);
	}
	
	//poly.setPhysics(1, .2, 1);  // uncomment this to see it fall!
	poly.create(box2d.getWorld());
	polyLines.push_back(poly);
	
    
    
}

//--------------------------------------------------------------
void path::touchDoubleTap(ofTouchEventArgs &touch){
	
    /*
     // want to save out some line...
     
     ofstream f;
     f.clear();
     f.open(ofToDataPath("lines.txt").c_str());
     for (int i=0; i<lines.size(); i++) {
     for (int j=0; j<lines[i].size(); j++) {
     float x = lines[i][j].x;
     float y = lines[i][j].y;
     f << x << "," << y << ",";
     }
     f << "\n";
     }
     f.close();lines.clear();
     
     */
    
    
    
    
}

//--------------------------------------------------------------
void path::lostFocus(){
    
}

//--------------------------------------------------------------
void path::gotFocus(){
    
}

//--------------------------------------------------------------
void path::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void path::deviceOrientationChanged(int newOrientation){
    
}


//--------------------------------------------------------------
void path::touchCancelled(ofTouchEventArgs& args){
    
}



