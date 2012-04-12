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
     
     

    Tweenzor::update();
}


//------------------------------------------------------------------
void swMenu::draw() {
       
    
    int startX = rect.width/2 - (MENU_BTN_W * MENU_TOTAL)/2;    // find the starting point for the botton
    int curX = startX;                                                          // 
     
    
    for(int i=0; i<MENU_TOTAL; i++) {
        //curX = drawSeparatorLine(curX);
        
        //buttons[i].setPos(curX, 0);
        //buttons[i].draw(curX+drag.x,rect.y);
         
        
        curX += buttons[i].rect.width;
    }
     
    
    
    curRot.getRotate(angle, axis);      
    newAngle = angle - future; 
    
    glPushMatrix();  
        glTranslatef(0, ofGetHeight() - 100 , 150); 
        glRotatef(newAngle, axis.x, axis.y ,axis.z);  
        ofEnableAlphaBlending();
        ofSetColor(255, 255, 255); 
        wheel.draw(-350,-350, 700, 700);  
        ofDisableAlphaBlending();
    glPopMatrix(); 
    
    /*
    
    for (int i = 0; i < MENU_TOTAL; i++) {
        float theta = ofMap(i, 0, 3, 0, 360);
    
        
        ofVec3f axis (0,0,0); 
    ofVec2f rotateVal (0,i * 20); 
    //rotateVal.rotate(theta);
        rotateVal.rotate(theta);
        
        cout << "theta " << theta << ", rotateval x " << rotateVal.y << endl;
        
        buttons[i].draw(rotateVal.x  ,rotateVal.y); 
        
    }
    
    
    ofVec2f test; 
    test.rotate(34);
    ofRect(test.x, test.y, 100, 100);
    
     */
    
    
    
    ofPushMatrix(); 
        ofTranslate(0, ofGetHeight() - 100, 150); 

        
        ofRotate(newAngle, axis.x, axis.y ,axis.z);  
        ofEnableAlphaBlending();
            for (int i = 0; i < MENU_TOTAL; i++) {
                float theta = ofMap(i, 0, 3, 0, 360);
        
                ofPushMatrix(); 
                
                ofRotate (theta); 

                ofTranslate(300, 100);
                glGetFloatv(GL_MODELVIEW_MATRIX, modelview);

                ofSetColor(100);
                translation.x = modelview[13] + 384;   
                translation.y = modelview[12] + 512;  
                translation.z = modelview[14];  
                buttons[i].rLoc = translation; 
                ofDrawBitmapString(ofToString(i) + " translation x " + ofToString(translation.x), 500, 10);
                ofDrawBitmapString(ofToString(i) + " translation y " + ofToString(translation.y), 500, 40);
                ofDrawBitmapString(ofToString(i) + " translation z " + ofToString(translation.z), 500, 70);

                //make an array to store these values to apply outside.
                
                ofSetColor(255);                
                carrot.draw(250, 0, 0, 50, 100);

                ofPopMatrix(); 
    }

        ofDisableAlphaBlending();
    ofPopMatrix(); 



    
    cout << "TRANSLATION Y " << translation.y << endl; 
    ofSetColor(100);

    

    buttons[MENU_ONE].draw(buttons[MENU_ONE].rLoc.x , buttons[MENU_ONE].rLoc.y ); 
    buttons[MENU_TWO].draw(buttons[MENU_TWO].rLoc.x , buttons[MENU_TWO].rLoc.y ); 
    buttons[MENU_THREE].draw(buttons[MENU_THREE].rLoc.x , buttons[MENU_THREE].rLoc.y ); 
    
    //DEAR LIA, YOU CANNOT TRANSLATE OUTSIDE OF THE MATRIX. 
    //DRAW, and THEN TRANSLATE?

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
    //if(bShowing) {
        
    
        for(int i=0; i<MENU_TOTAL; i++) {
            buttons[i].touchDown(touch);
        }
      
    
    
  /*
     ofPushMatrix(); 
     ofTranslate(0, ofGetHeight() - 100, 150); 
     ofRotate(newAngle, axis.x, axis.y ,axis.z);  
     
     for (int i = 0; i < MENU_TOTAL; i++) {
     float theta = ofMap(i, 0, 3, 0, 360);
     
     ofPushMatrix(); 
     
     ofRotate (theta); 
     ofTranslate(350, 0);
     buttons[i].touchDown(touch);
     
     ofPopMatrix(); 
     }
     
     ofPopMatrix(); 
     
     */

    /*
        
        if( touch.id == 0 ){
            touchPt.x = touch.x;
            bDragging = true;
        }
        */ 
         
    //}
    lastMouse = ofVec2f(touch.x, touch.y);  
    
}


//--------------------------------------------------------------
void swMenu::touchMoved(ofTouchEventArgs &touch){

        
        for(int i=0; i<MENU_TOTAL; i++) {
            buttons[i].touchMoved(touch);
        }
       
        if( touch.id == 0 ){
            ofPoint pt( touch.x, touch.y );
            drag += pt - touchPt;
            
            touchPt = pt;
        }
         
    
    /*
    ofPushMatrix(); 
    ofTranslate(0, ofGetHeight() - 100, 150); 
    ofRotate(newAngle, axis.x, axis.y ,axis.z);  
    
    for (int i = 0; i < MENU_TOTAL; i++) {
        float theta = ofMap(i, 0, 3, 0, 360);
        
        ofPushMatrix(); 
        
        ofRotate (theta); 
        ofTranslate(350, 0);
        buttons[i].touchMoved(touch);
        
        ofPopMatrix(); 
    }
    
    ofPopMatrix(); 
         
         */
    
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
        
        
        /*
        ofPushMatrix(); 
        ofTranslate(0, ofGetHeight() - 100, 150); 
        ofRotate(newAngle, axis.x, axis.y ,axis.z);  
        
        for (int i = 0; i < MENU_TOTAL; i++) {
            float theta = ofMap(i, 0, 3, 0, 360);
            
            ofPushMatrix(); 
            
            ofRotate (theta); 
            ofTranslate(350, 0);
            buttons[i].touchUp(touch);
            
            ofPopMatrix(); 
        }
        
        ofPopMatrix(); 
         */
        
        
        for(int i=0; i<MENU_TOTAL; i++) {
            buttons[i].touchUp(touch);
        }
        
        
        if( touch.id == 0 ){
            bDragging = false;
        }
         
         
    }
         Tweenzor::add(future, 0, 10, 0.f, 1.5f, EASE_OUT_ELASTIC);
     
}

//-------------------------------------------------------------------
int swMenu::getSongPressed() {
    return songPressed; 
}