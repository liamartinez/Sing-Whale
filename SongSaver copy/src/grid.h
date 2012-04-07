//
//  grid.h
//  OctAnalyzeWithGrid
//
//  Created by Lia Martinez on 3/15/12.
//  Copyright (c) 2012 liamartinez.com. All rights reserved.
//

#ifndef OctAnalyzeWithGrid_grid_h
#define OctAnalyzeWithGrid_grid_h

#include "ofMain.h"
#include "ofxBox2d.h"

class grid {
    
public:
    grid (); 
    void                    setLocation (int locationX, int locationY); 
    ofVec2f                 getLocation(); 
    void                    setLength (float lenHorz_);  
    void                    setLengthDensity (int numHorz_, float incHorz_); 
    float                   returnIncHorz(); 
    void                    setupBox2d(int gravX, int gravY); 
    void                    setupGrid(); //put location arguments
    void                    setupEmptyGrid();
    void                    update(); 
    void                    drawGrid(); 
    void                    seeGrid(); 
    void                    letsGo(int num, int height); 
    void                    letsReset(int nowLocTop_);
    void                    clearGrid(); 
    void                    attractReset(); 
    
    ofxBox2d						box2d;	
    
    //anchors
    ofxBox2dCircle          startAnchor, startAnchorBot; 
    ofxBox2dCircle          endAnchor, endAnchorBot;
    vector<ofxBox2dCircle>  topAnchors; 
    vector<ofxBox2dJoint>   topAnchorJoints; 
    
    //location & sizes
    ofVec2f             startLoc, endLoc, startLocBot, endLocBot; 
    int                 numHorz, numVertz;
    float               incHorz, incVertz; 
    int                 lenHorz, lenVertz; 
    float               damping, frequency; 
    int                 circleSize; 
    int                 anchorHeight; 
    
    //vectors
    vector<ofxBox2dCircle>  topCircles;
    vector<ofxBox2dCircle>  bottomCircles;
    vector<ofxBox2dCircle>  leftCircles;
    vector<ofxBox2dCircle>  rightCircles;
    
    vector<ofxBox2dJoint>   topJoints;
    vector<ofxBox2dJoint>   bottomJoints;
    vector<ofxBox2dJoint>   heightJoints;
    vector<ofxBox2dJoint>   leftJoints;
    vector<ofxBox2dJoint>   rightJoints;
    
    //vector<ofxBox2dCircle>  waters; 
    
    //controls
    bool                    skeleton;
    int                     numNote; 
    int                     savedNum; 
    int                     counter; 
    bool                    yesMore; 
    
    //new
    ofxBox2dCircle           movingEnd, movingEndBot;

    vector<ofxBox2dCircle>  MtopAnchors; 
    vector<ofxBox2dJoint>   MtopAnchorJoints;
    
    //location & sizes
    ofVec2f             MstartLoc, MendLoc, MstartLocBot, MendLocBot; 
    int                 MnumHorz, MnumVertz;
    float               MincHorz, MincVertz; 
    int                 MlenHorz, MlenVertz; 
    float               Mdamping, Mfrequency; 
    int                 McircleSize; 
    int                 ManchorHeight; 
    
    //vectors
    vector<ofxBox2dCircle>  MtopCircles;
    vector<ofxBox2dCircle>  MbottomCircles;
    vector<ofxBox2dCircle>  MleftCircles;
    vector<ofxBox2dCircle>  MrightCircles;
    
    vector<ofxBox2dJoint>   MtopJoints;
    vector<ofxBox2dJoint>   MbottomJoints;
    vector<ofxBox2dJoint>   MheightJoints;
    vector<ofxBox2dJoint>   MleftJoints;
    vector<ofxBox2dJoint>   MrightJoints;
    
    bool                    Mskeleton;
    int                     MnumNote; 
    
};

#endif