//
//  path.h
//  SongSaver
//
//  Created by Lia Martinez on 4/4/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef SongSaver_path_h
#define SongSaver_path_h

//#include "ofMain.h"
//#include "ofxiPhone.h"
//#include "ofxiPhoneExtras.h"
#include "ofxBox2d.h"

class path {
public:
    
    path(); 
    
    void                        setupPath(); 
    void                        updatePath(); 
    void                        drawPath(); 
    void                        exit();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);
    
	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
    
    void                        setGravity(float numGrav, float numDir); 
    void                        moveBall (int where, int whereY);
    void                         newBall(); 
    
    vector <ofPolyline>			lines;
	ofxBox2d					box2d;
	vector <ofxBox2dCircle>		circles;
	vector <ofxBox2dPolygon>	polyLines;
    
    int                         gravy; 
    ofVec2f                     ballLoc; 
    
    
};

#endif
