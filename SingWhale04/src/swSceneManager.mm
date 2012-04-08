//
//  swSceneManager.cpp
//  Thesis01interface
//
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.
//

#include <iostream>

#include "swSceneManager.h"


//------------------------------------------------------------------
//Singleton Instance/Get Instance
swSceneManager* swSceneManager::pswSceneManager=NULL;

//------------------------------------------------------------------
swSceneManager* swSceneManager::getInstance() {
	if(pswSceneManager==NULL) {
		pswSceneManager=new swSceneManager();
	}
	
	return pswSceneManager;
}

swSceneManager::swSceneManager() {
}