//
//  listener.h
//  SingWhale03
//
//  Created by Lia Martinez on 3/22/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SingWhale03_listener_h
#define SingWhale03_listener_h

#include "ofMain.h"

class testApp; 

class listener {
    listener(); 
    listener(testApp app); 
    void method();

    testApp * myTestApp ; 

};

#endif
