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
    labels[MENU_ONE]        = "Carrot!";           //put text on the menu
    labels[MENU_TWO]        = "Burp";       //put text on the menu
    labels[MENU_THREE]      = "Sleep";       //put text on the menu
    
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
    
    //rotation
    carrot.loadImage("carrot.png");   
    wheel.loadImage("circle.png");
    Tweenzor::init();  
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
    
    Tweenzor::update();
}


//------------------------------------------------------------------
void swMenu::draw() {
    
    //get the angle based on the quaternion computations
    curRot.getRotate(angle, axis);      
    newAngle = angle - future; //"future" is for the bounce
   
    //rotate the wheel
    ofPushMatrix();  
        ofTranslate(0, ofGetHeight()); 
        ofRotate(newAngle + 5, axis.x, axis.y ,axis.z);  
        ofEnableAlphaBlending();

    for (int i = 0; i < MENU_TOTAL; i++) {
        float theta = ofMap(i, 0, 3, 0, 360);
        ofPushMatrix(); 
        ofRotate (theta); 
        ofTranslate(300, 100);
        
        //get the modelview coordinates for this location
        glGetFloatv(GL_MODELVIEW_MATRIX, modelview2);
        
        //save them with numbers to compensate (dont know why they move)
        translation2.x = modelview2[13] + 384;   
        translation2.y = modelview2[12] + 512;  
        translation2.z = modelview2[14] + 886.81;  
        
        //store them in the class
        buttons[i].rLocBG = translation2; 
        
        ofPopMatrix(); 
    }
        ofDisableAlphaBlending();
        ofPopMatrix(); 

    
   
    //separate matrices to make the rotations a little different
    ofPushMatrix(); 
        ofTranslate(0, ofGetHeight() - 100, 150); 

        ofRotate(newAngle, axis.x, axis.y ,axis.z);  
        ofEnableAlphaBlending();
    
            for (int i = 0; i < MENU_TOTAL; i++) {
                float theta = ofMap(i, 0, 3, 0, 360);
        
                ofPushMatrix(); 
                ofRotate (theta); 
                ofTranslate(300, 100);
                
                //get the modelview coordinates for this location
                glGetFloatv(GL_MODELVIEW_MATRIX, modelview);

                //save them with numbers to compensate (dont know why they move)
                translation.x = modelview[13] + 384;   
                translation.y = modelview[12] + 512;  
                translation.z = modelview[14] + 886.81;  
                
                //store them in the class
                buttons[i].rLoc = translation; 

                ofPopMatrix(); 
    }

        ofDisableAlphaBlending();
    ofPopMatrix(); 

    ofSetColor(100);

    //draw everything according to translated values
    for (int i = 0; i < MENU_TOTAL; i++) {
        
        ofEnableAlphaBlending();
        ofSetColor(255);
        wheel.draw(buttons[i].rLocBG.x - 40, buttons[i].rLocBG.y - 200, 200, 200);
        carrot.draw(buttons[i].rLoc.x, buttons[i].rLoc.y - 55, 100, 130);
        ofDisableAlphaBlending();
        
        buttons[i].draw(buttons[i].rLoc.x, buttons[i].rLoc.y);
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

        for(int i=0; i<MENU_TOTAL; i++) {
            buttons[i].touchDown(touch);
        }

    lastMouse = ofVec2f(touch.x, touch.y);  
    
}


//--------------------------------------------------------------
void swMenu::touchMoved(ofTouchEventArgs &touch){

        
        for(int i=0; i<MENU_TOTAL; i++) {
            buttons[i].touchMoved(touch);
        }

    
    ofVec2f mouse(touch.x,touch.y);  
    ofQuaternion yRot(touch.x -lastMouse.x, ofVec3f(0,0,.5));  
    ofQuaternion xRot(touch.y -lastMouse.y, ofVec3f(0,0,.5));  
    curRot *= yRot*xRot;  
    
    lastMouse = mouse; 
    
    

}


//--------------------------------------------------------------
void swMenu::touchUp(ofTouchEventArgs &touch){
    

    
    if(bShowing) {
        for(int i=0; i<MENU_TOTAL; i++) {
            if(buttons[i].isPressed()) {
                songPressed = i; 

                switch (i) {
                    case  MENU_ONE:
                        //songSM->setCurScene(SONG_ONE);
                        
                        touchMenuRes = true; 
                        break;
                    case  MENU_TWO:
                        //songSM->setCurScene(SONG_TWO);
                        
                        touchMenuRes = true; 
                        //                        cout<<"press Resouce"<<endl;
                        break;
                    case  MENU_THREE:
                        //songSM->setCurScene(SONG_THREE);
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

         
    }
         Tweenzor::add(future, 0, 10, 0.f, 1.5f, EASE_OUT_ELASTIC);
     
}

//-------------------------------------------------------------------
int swMenu::getSongPressed() {
    return songPressed; 
}