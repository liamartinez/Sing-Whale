//
//  swAssetManager.cpp
//  SingWhale01
//
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.
//

#include <iostream>

#include "swAssetManager.h"

//------------------------------------------------------------------
//Singleton Instance/Get Instance
swAssetManager* swAssetManager::pswAssetManager=NULL;

//------------------------------------------------------------------
swAssetManager* swAssetManager::getInstance() {
	if(pswAssetManager==NULL) {
		pswAssetManager=new swAssetManager();
	}
	
	return pswAssetManager;
}


//------------------------------------------------------------------
swAssetManager::swAssetManager() {
}


//------------------------------------------------------------------
void swAssetManager::loadFonts() {
	whitneySemiBold22.loadFont("fonts/Whitney-Semibold.otf",22);
}


//------------------------------------------------------------------
bool swAssetManager::loadData() {
    return true;
}
