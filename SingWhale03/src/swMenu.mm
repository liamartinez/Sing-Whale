//
//  swMenu.cpp
//  SingWhale01
//
//  Created by Stephen Varga on 6/15/11.
//  Modified by Lia Martinez on 2/25/12.

//

#include <iostream>
#include "swMenu.h"

//------------------------------------------------------------------
void swMenu::setup() {
    //Get Managers
    swAssets   = swAssetManager::getInstance();
    songSM       = songSceneManager::getInstance();
    
    touchMenuRes = false; 
    
    
    rect.width  = ofGetWidth();                         //width of BTM_MENU  
    rect.height = 70;                                   //height
    
    rect.x = 0;                                         //position x of BTM_MENU
    rect.y = ofGetHeight() - rect.height;                //position y 0f BTM_MENU
    
    bShowing = false;                                   //not showing as normal
    showingY = ofGetHeight() - rect.height;             //showing scene 
    
    //Menu BG
    disableBG();
    bgImage.loadImage("images/menuBG.png");        //load menu background
    
    
    //Set Labels
    labels[MENU_ONE]        = "Do you like \n  bananas?";           //put text on the menu
    labels[MENU_TWO]        = "Whales are \n   stupid";       //put text on the menu
    labels[MENU_THREE]      = "La la la";       //put text on the menu
    
    //Create Buttons
    
    ofColor bgOffColor, bgOnColor;                      //color of button when touch down
    bgOffColor.r = bgOffColor.g = bgOffColor.b = 0;     
    bgOffColor.a = 0;
    bgOnColor = bgOffColor;
    bgOnColor.a = 50;                                   //draw 50% of black when touching
    
    for(int i=0; i<MENU_TOTAL; i++) {                               //
        buttons[i].setLabel(labels[i], &swAssets->nevis22);
        buttons[i].setSize(MENU_BTN_W, rect.height);
        buttons[i].setColor(bgOffColor, bgOnColor);
        disableBG();
    }
}


//------------------------------------------------------------------
void swMenu::show() {
    //Tweenzor::add(rect.y, rect.y, showingY, 0, 30, EASE_OUT_QUAD);      
    bShowing = true;
}


//------------------------------------------------------------------
void swMenu::hide() {
    //Tweenzor::add(rect.y, rect.y, ofGetHeight(), 0, 30, EASE_OUT_QUAD);
    bShowing = false;
}


//------------------------------------------------------------------
void swMenu::update() {
    int dragLimitStart = 100; 
    int dragLimitEnd = -300.0f;
    
    //bounce back at the end
	if( !bDragging ){

		if( drag.x > dragLimitStart ){
			drag.x *= 0.9;
		}

		if( drag.x < dragLimitEnd){
			drag.x *= 0.9;
			drag.x += dragLimitEnd * 0.1;
		}
	
	}

}


//------------------------------------------------------------------
void swMenu::draw() {
       
    int startX = rect.width/2 - (MENU_BTN_W * MENU_TOTAL)/2;    // find the starting point for the botton
    int curX = startX;                                                          // 
    for(int i=0; i<MENU_TOTAL; i++) {
        //curX = drawSeparatorLine(curX);
        
        //buttons[i].setPos(curX, 0);
        buttons[i].draw(curX+drag.x,rect.y);
        
        curX += buttons[i].rect.width;
    }
    
    
}


//------------------------------------------------------------------
int swMenu::drawSeparatorLine(int x) {
    //Draw First Line
    ofSetColor(195, 195, 195);
    ofLine(x, rect.y, x, rect.y+rect.height);
    
    ofSetColor(145, 145, 145);
    ofLine(x+1, rect.y, x+1, rect.y+rect.height);
    
    return x+2;
}


//--------------------------------------------------------------
void swMenu::touchDown(ofTouchEventArgs &touch){
    if(bShowing) {
        
        for(int i=0; i<MENU_TOTAL; i++) {
            buttons[i].touchDown(touch);
        }
        
        if( touch.id == 0 ){
            touchPt.x = touch.x;
            bDragging = true;
        }
    }
}


//--------------------------------------------------------------
void swMenu::touchMoved(ofTouchEventArgs &touch){
    if(bShowing) {
        
        for(int i=0; i<MENU_TOTAL; i++) {
            buttons[i].touchMoved(touch);
        }
        
        if( touch.id == 0 ){
            ofPoint pt( touch.x, touch.y );
            drag += pt - touchPt;
            
            touchPt = pt;
        }
    }
}


//--------------------------------------------------------------
void swMenu::touchUp(ofTouchEventArgs &touch){
    
    //lia - replace these with real menu options
    
    if(bShowing) {
        for(int i=0; i<MENU_TOTAL; i++) {
            if(buttons[i].isPressed()) {
                switch (i) {
                    case  MENU_ONE:
                        songSM->setCurScene(SONG_ONE);
                        touchMenuRes = true; 
                        break;
                    case  MENU_TWO:
                        songSM->setCurScene(SONG_TWO);
                        touchMenuRes = true; 
                        //                        cout<<"press Resouce"<<endl;
                        break;
                    case  MENU_THREE:
                        songSM->setCurScene(SONG_THREE);
                        touchMenuRes = true; 
                        break;
                    default:
                        break;
                }
                
                break;
            }
        }
        
        
        for(int i=0; i<MENU_TOTAL; i++) {
            buttons[i].touchUp(touch);
        }
        
        if( touch.id == 0 ){
            bDragging = false;
        }
    }
     
     
}