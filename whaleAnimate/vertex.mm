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
    period = 500; 
    dx = (TWO_PI / period) ;
    amplitude = 20; 
    floatValue = 0; 
}

void vertex::floating() {
    
        // Increment theta (try different values for 'angular velocity' here
        theta += 0.02;
        
        // For every x value, calculate a y value with sine function
        float x = theta;

    for (int i = 0; i < 20; i ++) {
            floatValue = sin(x)*amplitude;
            x+=dx;
        cout << x << endl; 
    }

}