//
//  dorwing.h
//  emptyExample
//
//  Created by Lia Martinez on 4/6/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef emptyExample_dorwing_h
#define emptyExample_dorwing_h

#include "vertex.h"

class dorwing {
    
public: 
    dorwing(); 
    void setup(ofVec2f startLoc_); 
    void draw(); 
    void update(); 
    void letsGo (int num, int height_); 
    void setWriggleOn(bool on); 
    void reset(); 
    void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);

    ofVec2f     startLoc; 
    vector<vertex> songPoints; 
    ofTrueTypeFont TTF;
    
    bool wriggleOn; 
    
};

#endif
