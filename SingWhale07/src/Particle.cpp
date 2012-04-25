/*
 *  Particle.cpp
 *  flock
 *
 *  Created by Jeffrey Crouse on 3/29/10.
 *  Copyright 2010 Eyebeam. All rights reserved.
 *
 */

#include "Particle.h"

Particle::Particle() {
	acc = ofPoint(0,0);
    r = 10.0;
    timer = 30.0;
    maxspeed = 20.0;
	mass = 1.0;
}

void Particle::update() {
	vel += acc;
	vel.x = ofClamp(vel.x, -maxspeed, maxspeed);
	vel.y = ofClamp(vel.y, -maxspeed, maxspeed);
	loc += vel;
	acc = 0;
	timer -= 0.5;
}

void Particle::applyForce(ofPoint force) {
	force /= mass;
	acc += force;
}

void Particle::draw() {
	
	ofPushMatrix();
    ofPushStyle();
	ofTranslate(loc.x, loc.y);
	//ofEnableAlphaBlending();
    ofSetLineWidth(3);
	ofFill();
    
	//ofSetColor(93, 203, 184, timer);
    ofSetColor(255, 255, 255, timer);
	ofCircle(0, 0, r);
    
	//ofSetColor(255, 0, 0, timer);
	//ofLine(0, 0, vel.x, vel.y);
	ofPopMatrix();
    ofSetLineWidth(1);
    //ofDisableAlphaBlending();
    ofPopStyle();
    
}

bool Particle::dead() {
	if(timer <= 0.0) {
		return true;
	} else {
		return false;
	}
}