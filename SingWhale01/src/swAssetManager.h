//
//  swAssetManager.h
//  SingWhale01
//
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.
//

#ifndef SingWhale01_swAssetManager_h
#define SingWhale01_swAssetManager_h

#pragma once
#include "ofMain.h"
#include "ofxFreeType2.h"

#define MNH_GRID_CELL_SIZE 128 //lia - do we need this? 

class swAssetManager {
public:
    static swAssetManager* getInstance();
    
    bool loadData();
    void loadFonts();
    void loadImages();
        
    //Fonts
    ofxFreeType2 whitneySemiBold22;
    
private:
    swAssetManager();
    ~swAssetManager();
    
    static swAssetManager* pswAssetManager;
};


#endif
