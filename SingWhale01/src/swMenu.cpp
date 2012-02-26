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
    swSM       = swSceneManager::getInstance();
    
    touchMenuRes = false; 
    
    
    rect.width  = ofGetWidth();                         //width of BTM_MENU  
    rect.height = 50;                                   //height
    
    rect.x = 0;                                         //position x of BTM_MENU
    rect.y = ofGetHeight();                             //position y 0f BTM_MENU
    
    bShowing = false;                                   //not showing as normal
    showingY = ofGetHeight() - rect.height;             //showing scene 
    
    //Menu BG
    disableBG();
    bgImage.loadImage("images/menu/menuBG.png");        //load menu background
    
    
    //Set Labels
    labels[MENU_ONE]        = "One";           //put text on the menu
    labels[MENU_TWO]        = "Two";       //put text on the menu
    labels[MENU_THREE]      = "Three";       //put text on the menu
    
    //Create Buttons
    
    ofColor bgOffColor, bgOnColor;                      //color of button when touch down
    bgOffColor.r = bgOffColor.g = bgOffColor.b = 0;     
    bgOffColor.a = 0;
    bgOnColor = bgOffColor;
    bgOnColor.a = 50;                                   //draw 50% of black when touching
    
    for(int i=0; i<MENU_TOTAL; i++) {                               //
        buttons[i].setLabel(labels[i], &swAssets->whitneySemiBold22);
        buttons[i].setSize(MENU_BTN_W, rect.height);
        buttons[i].setColor(bgOffColor, bgOnColor);
        disableBG();
    }
}


//------------------------------------------------------------------
void swMenu::show() {
    Tweenzor::add(rect.y, rect.y, showingY, 0, 30, EASE_OUT_QUAD);      
    bShowing = true;
}


//------------------------------------------------------------------
void swMenu::hide() {
    Tweenzor::add(rect.y, rect.y, ofGetHeight(), 0, 30, EASE_OUT_QUAD);
    bShowing = false;
}


//------------------------------------------------------------------
void swMenu::update() {
}



//------------------------------------------------------------------
void swMenu::draw() {
    baseButton::draw();
    
    //Draw BG Image (Flip Vertical to use same BG as top menu)
    glPushMatrix();
    glTranslatef(0, rect.y + rect.height, 0);
    glRotatef(180, 1, 0, 0);
    ofEnableAlphaBlending();
    ofSetColor(255, 255, 255);
    bgImage.draw(0,0,ofGetWidth(), bgImage.height);
    ofDisableAlphaBlending();   
    glPopMatrix();
    
    //Draw buttons relative to overall menu, with line before each
    int startX = rect.width/2 - (MENU_BTN_W * MENU_TOTAL)/2;    // find the starting point for the botton
    int curX = startX;                                                          // 
    for(int i=0; i<MENU_TOTAL; i++) {
        curX = drawSeparatorLine(curX);
        
        buttons[i].setPos(curX, rect.y);
        buttons[i].draw();
        
        curX += buttons[i].rect.width;
    }
    
    //Draw final line
    drawSeparatorLine(curX);
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
        baseButton::touchDown(touch);
        for(int i=0; i<MENU_TOTAL; i++) {
            buttons[i].touchDown(touch);
        }
    }
}


//--------------------------------------------------------------
void swMenu::touchMoved(ofTouchEventArgs &touch){
    if(bShowing) {
        baseButton::touchMoved(touch);
        for(int i=0; i<MENU_TOTAL; i++) {
            buttons[i].touchMoved(touch);
        }
    }
}


//--------------------------------------------------------------
void swMenu::touchUp(ofTouchEventArgs &touch){
    
    //lia - replace these with real menu options
    /*
    if(bShowing) {
        for(int i=0; i<MENU_TOTAL; i++) {
            if(buttons[i].isPressed()) {
                switch (i) {
                    case MNH_BTM_MENU_HOME:
                        mnhSM->setCurScene(MNH_SCENE_HOME);
                        touchMenuRes = true; 
                        break;
                    case MNH_BTM_MENU_RESEARCH:
                        mnhSM->setCurScene(MNH_SCENE_RESEARCH);
                        touchMenuRes = true; 
                        //                        cout<<"press Resouce"<<endl;
                        break;
                    case MNH_BTM_MENU_ACTIVITY:
                        mnhSM->setCurScene(MNH_SCENE_ACTIVITY);
                        touchMenuRes = true; 
                        break;
                    default:
                        break;
                }
                
                break;
            }
        }
        
        baseButton::touchUp(touch);
        
        for(int i=0; i<MENU_TOTAL; i++) {
            buttons[i].touchUp(touch);
        }
    }
     */
     
}