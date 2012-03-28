//
//  vertex.cpp
//  whaleAnimate
//
//  Created by Lia Martinez on 3/27/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "vertex.h"

vertex::vertex() {
    theta = 0.0; 
    period = 200; 
    dx = (TWO_PI / period) ;
    amplitude = 3; 
    floatValue = 0; 
    newPos.set(0, 0);
}

void vertex::wriggle(float thetaVar) {
    
        // Increment theta (try different values for 'angular velocity' here
        theta += 0.02 * thetaVar;
        
        // For every x value, calculate a y value with sine function
        float x = theta;


            floatValue = sin(x)*amplitude;
            x+=dx;



}