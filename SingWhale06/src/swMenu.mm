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
    //disableBG();
    //bgImage.loadImage("images/menuBG.png");        //load menu background
    
    //icons
    for (int i = 0; i < 10; i++ ) {
        icons[i].loadImage("images/icons/whaleIcons-" + ofToString(i) + ".png");
        //icons[i].loadImage("carrot.png");
    }
    
    //Set Labels
    labels[MENU_ONE]        = "Carrot!";           //put text on the menu
    labels[MENU_TWO]        = "Burp";       //put text on the menu
    labels[MENU_THREE]      = "Sleep";       //put text on the menu
    
    
    //Set Phrases
    phrases[MENU_ZERO]       = "I have a gift for you!";   
    phrases[MENU_ONE]        = "What is your favorite color?";          
    phrases[MENU_TWO]        = "Do you believe in ghosts?";  
    phrases[MENU_THREE]      = "Are you ready for bed?";  
    phrases[MENU_FOUR]       = "Look! A carrot!";  
    phrases[MENU_FIVE]       = "Can you burp really loud?";
    phrases[MENU_SIX]        = "SHARK! I see a SHARK!";
    phrases[MENU_SEVEN]      = "I like stars.";
    phrases[MENU_EIGHT]      = "Do you like tacos?";
    phrases[MENU_NINE]       = "Where is your mom?";

    //Create Buttons
    
    ofColor bgOffColor, bgOnColor;                      //color of button when touch down
    bgOffColor.r = bgOffColor.g = bgOffColor.b = 0;     
    bgOffColor.a = 0;
    bgOnColor = bgOffColor;
    bgOnColor.a = 50;                                   //draw 50% of black when touching
    
    for(int i=0; i<MENU_TOTAL; i++) {                               //
        //buttons[i].setLabel(ofToString(i), &swAssets->nevis22);
        buttons[i].setImage(&icons[i]);
        //buttons[i].setPhrase(phrases[i], &swAssets->nevis22); 
        //buttons[i].setSize(MENU_BTN_W, rect.height);
        //buttons[i].setColor(bgOffColor, bgOnColor);
        //disableBG();
    }
    
    //rotation
    carrot.loadImage("carrot.png");   
    wheel.loadImage("circle.png");
    Tweenzor::init();  
    
    //sound
    ppput.loadSound("sounds/ppput.caf");
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
    
    Tweenzor::update(ofGetElapsedTimeMillis());

    //-------move this back
    //if you are within the activate area, activate
    for (int i = 0; i < MENU_TOTAL; i++) {
        
        //draw button location
        //ofDrawBitmapString(ofToString(i) + " " + ofToString(buttons[i].rLoc.y) + " x " + ofToString(buttons[i].rLoc.x), 500, ofGetHeight()-300 + (i*20));
        
        
        //activate the background? 
        //if (buttons[i].rLocBG.y > 750 && buttons[i].rLocBG.y < 900 && buttons[i].rLocBG.x > 0) {
        
        //(200, ofGetHeight()-150, 100, 100); 
        
        activateArea.set(200, ofGetHeight()-150, 100, 100); 
        
        if (buttons[i].rLoc.y > activateArea.y - (activateArea.height/2) && buttons[i].rLoc.y < activateArea.y + (activateArea.height/2) && buttons[i].rLoc.x > activateArea.x) {
            
            buttons[i].activated = true; 

            //make that the current song, only if it wasn't the last song.
            songPressed = i; 
            currentSong = i; 
            //cout << "CUR " << currentSong << endl; 
            if (currentSong != lastSong) {            
                activate = true; //do something
                lastSong = currentSong;
            } else {
                activate = false; //dont do anything
            }
        } else {
            buttons[i].activated = false; 
        }
    }
}


//------------------------------------------------------------------
void swMenu::draw() {
    
    //get the angle based on the quaternion computations
    curRot.getRotate(angle, axis);      
    newAngle = angle - future; //"future" is for the bounce
   
    //rotate the wheel
    ofPushMatrix();  
        ofTranslate(0, ofGetHeight()); 
        ofRotate(newAngle+5, axis.x, axis.y ,axis.z);  //+5 to make it slightly different
        ofEnableAlphaBlending();

    for (int i = 0; i < MENU_TOTAL; i++) {
        float theta = ofMap(i, 0, MENU_TOTAL, 0, 360);
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

    //-------------separate matrices to make the rotations a little different
    
    transRing.set(200, ofGetHeight() - 250);
    transObj.set(120, 100);

    ofPushMatrix(); 
        ofTranslate(transRing.x, transRing.y); 

        ofRotate(newAngle, axis.x, axis.y ,axis.z);  
        ofEnableAlphaBlending();

            for (int i = 0; i < MENU_TOTAL; i++) {
                float theta = ofMap(i, 0, MENU_TOTAL, 0, 360);
                //saving in the class so we can access it later
                buttons[i].theta = theta; 
                
                ofPushMatrix(); 
                ofRotate (buttons[i].theta); 
                ofTranslate(transObj.x, transObj.y);

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
                
        /*
        //the wheel is for the 2nd rotation, in case you want that effect
        ofEnableAlphaBlending();
        wheel.draw(buttons[i].rLocBG.x - 40, buttons[i].rLocBG.y - 180, 200, 200);
        ofDisableAlphaBlending();
         */
        
        buttons[i].draw(buttons[i].rLoc.x, buttons[i].rLoc.y);
    }
    

    drawActiveBox(); 
        
}


//--------------------------------------------------------------
void swMenu::drawActiveBox(){
    
    ofNoFill();
    ofRect(activateArea); 
}

//--------------------------------------------------------------
// this function is called on when the tween is complete //
void swMenu::onComplete(float* arg) {
	cout << "----------------------------------------------onComplete : arg = " << *arg << endl;

    tweenDone = true; 
    //poked = false; 
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
    
    lastMouse = ofVec2f(touch.x, touch.y);  
}


//--------------------------------------------------------------
void swMenu::touchMoved(ofTouchEventArgs &touch){
    
    //set the outside/inside bounds
    ringBounds.set(0, (transRing.y - 100), transRing.x + transObj.x + 100,  (transRing.y));
    smallRingBounds.set(50, transRing.y + 100, (transRing.x + transObj.x) -150, transRing.y + 100); 
    
    //restrict where the active area is for the ring
    if ((!smallRingBounds.inside (touch.x, touch.y)) && ringBounds.inside(touch.x, touch.y)){
        
        poked = true; //reset the guide
        
        ofVec2f mouse(touch.x,touch.y);  
        ofQuaternion yRot(touch.x -lastMouse.x, ofVec3f(0,0,.5));  
        ofQuaternion xRot(touch.y -lastMouse.y, ofVec3f(0,0,.5));  
        curRot *= yRot*xRot;  
        
        lastMouse = mouse; 
    }
    
     bounce(); 
    
    ppput.play(); 
}


//--------------------------------------------------------------
void swMenu::touchUp(ofTouchEventArgs &touch){

    finger.x = touch.x;
    finger.y = touch.y; 
   
    
    
    
    
    //snaps to the nearest value divisible by 40. change depending on size. 
    
    }



//--------------------------------------------------------
void swMenu::bounce() {
    
    tweenDone = false; 
    
    /*
    
    float distToGoal; 
    
    cout << "ANGLE " << angle << endl; 
    distToGoal = angle/DIVISOR;
    
    //distToGoal = ceil(distToGoal-0.5);
    distToGoal = floor(distToGoal+0.5);
    
    distToGoal = distToGoal * DIVISOR; 
    cout << "GO HERE  " << distToGoal << endl; 
    
    futureVal = angle - distToGoal; 
    cout << "NEW ANG " << angle << " - distance " << distToGoal << endl; 
    futureVal = futureVal*-1; 
    
    
    */
    
    future = 20; 
    Tweenzor::add(&future, 0, future, 0.f, 1.5f, EASE_OUT_ELASTIC);
    Tweenzor::addCompleteListener( Tweenzor::getTween(&future), this, &swMenu::onComplete);

    
    
    
}
                       

//-------------------------------------------------------------------
int swMenu::getSongPressed() {
    return songPressed; 
}

//--------------------------------------------------------------------
void swMenu::debugText() {
    
    //lets see the individual rotation values
    
     ofSetColor(0);
     
     ofDrawBitmapString("NEWANGLE " + ofToString(newAngle), 700, ofGetHeight() - 480);
     for (int i = 0; i < MENU_TOTAL; i++) {
     float thetaPlusAngle = newAngle + buttons[i].theta; 
     thetaPlusAngle = ofWrapDegrees(thetaPlusAngle, 0, 360);
     //if (thetaPlusAngle > 360) thetaPlusAngle = thetaPlusAngle - 360; 
     //float thetaPlusAngle = ofAngleDifferenceDegrees(buttons[i].theta, 50);
     ofDrawBitmapString("ITEM " + ofToString(i) + " THETA " + ofToString(buttons[i].theta) + " ANGLE PLUS THETA " + ofToString(thetaPlusAngle) , 700, ofGetHeight() - 450 + (i*20));
     }
     
    
    /*
     if i is activated, this is my current theta
     current theta has to be ideal theta
     so future is ideal theta - current theta.
     
     
     
     newAngle = newAngle + 
     */
    
    
    
     ofDrawBitmapString("ANGLE " + ofToString(angle), 700, ofGetHeight() - 450);
     ofDrawBitmapString("NEW ANGLE " + ofToString(newAngle), 700, ofGetHeight() - 480);
     
    
    //for debugging the active touch areas for the ring
     ofNoFill(); 
     ofRect(0, (transRing.y - 100), transRing.x + transObj.x + 100,  (transRing.y)); 
     ofRect(50, transRing.y + 100, (transRing.x + transObj.x) -150, transRing.y + 100);
     
    
    
    //ofDrawBitmapString("ACTIVATE " + ofToString(i) + " " + buttons[i].getLabel() + " " + ofToString(activate), 700, ofGetHeight() - 400 + (i*20));
}