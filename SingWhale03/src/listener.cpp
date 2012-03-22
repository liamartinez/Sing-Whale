//
//  listener.cpp
//  SingWhale03
//
//  Created by Lia Martinez on 3/22/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>
#include "listener.h"

listener::listener() {
}

listener::listener(testApp app){
   this->myTestApp=app;
}

void listener::method(){
    int theCounter = myTestApp->counterVariable;
}
