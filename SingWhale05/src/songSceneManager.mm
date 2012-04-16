//
//  songSceneManager.cpp
//  SingWhale01
//
//  Created by Lia Martinez on 3/19/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#include <iostream>

#include "songSceneManager.h"

//------------------------------------------------------------------
//Singleton Instance/Get Instance
songSceneManager* songSceneManager::psongSceneManager=NULL;

//------------------------------------------------------------------
songSceneManager* songSceneManager::getInstance() {
	if(psongSceneManager==NULL) {
		psongSceneManager=new songSceneManager();
	}
	
	return psongSceneManager;
}

songSceneManager::songSceneManager() {
}