#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);

	ofBackground(255,255,255);	
	ofSetFrameRate(60);
    
    font.loadFont("mono.ttf", 22);
    TTF.loadFont("mono.ttf", 7);
    saveButton.setup(); 
    saveButton.setLabel("SAVE", &font);
    loadButton.setup(); 
    loadButton.setLabel("LOAD", &font);
    

}


//--------------------------------------------------------------
void testApp::update(){

}

//--------------------------------------------------------------
void testApp::draw(){

    saveButton.draw(100, 100);
    loadButton.draw(100, 150); 

    ofFill();
	ofSetHexColor(0xe0be21);
    //ofSetHexColor(0x2bdbe6);
	ofBeginShape();
	
    if (whaleParts.size() != 0) {
    for (int i = 0; i < whaleParts.size(); i++){
        

        
        if (i == 0){
            ofCurveVertex(whaleParts[0].x, whaleParts[0].y); // we need to duplicate 0 for the curve to start at point 0
            ofCurveVertex(whaleParts[0].x, whaleParts[0].y); // we need to duplicate 0 for the curve to start at point 0
        } else if (i == whaleParts.size()-1){
            ofCurveVertex(whaleParts[i].x, whaleParts[i].y);
            ofCurveVertex(whaleParts[0].x, whaleParts[0].y);	// to draw a curve from pt 6 to pt 0
            ofCurveVertex(whaleParts[0].x, whaleParts[0].y);	// we duplicate the first point twice
        } else {
            ofCurveVertex(whaleParts[i].x, whaleParts[i].y);
        }
    }
    }
    
	ofEndShape(false);
	
	
	// show a faint the non-curve version of the same polygon:
	ofEnableAlphaBlending();
    ofNoFill();
    ofSetColor(0,0,0,40);
    ofBeginShape();
	
    if (whaleParts.size() != 0) {
        for (int i = 0; i < whaleParts.size(); i++){
            ofVertex(whaleParts[i].x, whaleParts[i].y);
        }
    }
    ofEndShape(false);
    
    
    ofSetColor(0,0,0,80);
    
    if (whaleParts.size() != 0) {
        for (int i = 0; i < whaleParts.size(); i++){
            if (whaleParts[i].bOver == true) ofFill();
            else ofNoFill();
            ofCircle(whaleParts[i].x, whaleParts[i].y,4);

            TTF.drawString(ofToString(i), whaleParts[i].x, whaleParts[i].y - 10); 
        }
    }
	ofDisableAlphaBlending();
	//-------------------------------------

    TTF.drawString("Status: "+message, 10, ofGetHeight() - 9);
}
//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
	if( touch.id == 0 ){
        
        if (whaleParts.size()!=0) {
            
            for (int i = 0; i < whaleParts.size(); i++){
                float diffx = touch.x - whaleParts[i].x;
                float diffy = touch.y - whaleParts[i].y;
                float dist = sqrt(diffx*diffx + diffy*diffy);
                if (dist < 45 ){
                    whaleParts[i].bBeingDragged = true;
                } else {
                    whaleParts[i].bBeingDragged = false;
                }	
            }
        }
        
	}
    
    saveButton.touchDown(touch);
    loadButton.touchDown(touch);
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
	if( touch.id == 0 ){

            for (int i = 0; i < whaleParts.size(); i++){
                if (whaleParts[i].bBeingDragged == true){
                    whaleParts[i].x = touch.x;
                    whaleParts[i].y = touch.y;
                }
            }
        
	}
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
	if( touch.id == 0 ){
        
        if (whaleParts.size()!=0) {
            for (int i = 0; i < whaleParts.size(); i++){
                whaleParts[i].bBeingDragged = false;	
            }
        }
	}
    
    if (saveButton.isPressed()) saveXML("whaleParts.xml");
    if (loadButton.isPressed()) loadXML("whaleParts.xml");
    
    
    
    saveButton.touchUp(touch);
    loadButton.touchDown(touch);
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    
    draggableVertex whalePoint; 
    whalePoint.x = touch.x; 
    whalePoint.y = touch.y; 
    
    whalePoint.bOver 			= false;
    whalePoint.bBeingDragged 	= false;
    whalePoint.radius           = 10;
    
    whaleParts.push_back(whalePoint);
    
    cout << whaleParts.size() << endl; 
    

    
    
}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs &touch){

}


void testApp::loadXML(string name) {
    
    message = "loading XML";
	
    ofxXmlSettings positions;
	if( positions.loadFile(ofxiPhoneGetDocumentsDirectory() + name) ){
		message = "XML loaded from documents folder!" ; 
	}else if( positions.loadFile(name) ){
		message =  "XML loaded from data folder!" ; 
	}else{
		message =  "unable to load XML check data/ folder" ; 
	}
    
    cout << "HELLO" << endl; 

    
    positions.pushTag("strokes");
    int numberOfSavedPoints = positions.getNumTags("PT");
    for(int i = 0; i < numberOfSavedPoints; i++){
        positions.pushTag("PT", i);
        
        draggableVertex p;
        p.x = positions.getValue("X", 0);
        p.y = positions.getValue("Y", 0);
        
        whaleParts.push_back(p);
        positions.popTag();
    }
    
    positions.popTag(); //pop position
}




void testApp::saveXML(string name) {
    
    ofxXmlSettings positions;
    positions.addTag("strokes");
    positions.pushTag("strokes");
    //points is a vector<ofPoint> that we want to save to a file
    for(int i = 0; i < whaleParts.size(); i++){
        //each position tag represents one point
        positions.addTag("PT");
        positions.pushTag("PT",i);
        //so set the three values in the file
        positions.addValue("X", whaleParts[i].x);
        positions.addValue("Y", whaleParts[i].y);
        positions.popTag();//pop position
    }
    positions.popTag(); //pop position
    positions.popTag(); //pop strokes
    positions.saveFile( ofxiPhoneGetDocumentsDirectory() + name);
    
    message = "saved XML" ; 
    
}
