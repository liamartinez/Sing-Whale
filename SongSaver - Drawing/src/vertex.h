//
//  vertex.h
//  emptyExample
//
//  Created by Lia Martinez on 4/6/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef emptyExample_vertex_h
#define emptyExample_vertex_h

#include "ofMain.h"

class vertex {
public:
    vertex(); 
    
    ofVec2f pos; 
    bool 	bBeingDragged;
    bool 	bOver;
    float 	radius;
    
    //floating
    void    wriggle(float thetaVar); 
    float   theta;
    float   dx;
    float   period; 
    int     floatValue; 
    float   amplitude; 
    
    //
    ofVec2f newPos; 
};

#endif
