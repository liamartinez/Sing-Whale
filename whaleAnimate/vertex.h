//
//  vertex.h
//  whaleAnimate
//
//  Created by Lia Martinez on 3/27/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef whaleAnimate_vertex_h
#define whaleAnimate_vertex_h

#include "ofMain.h"

class vertex {
public:
    vertex(); 

    ofVec2f pos; 
    bool 	bBeingDragged;
    bool 	bOver;
    float 	radius;
    
    //floating
    void    floating(); 
    float   theta;
    float   dx;
    float   period; 
    int     floatValue; 
    float   amplitude; 
    
    //
    ofVec2f newPos; 
};

#endif
