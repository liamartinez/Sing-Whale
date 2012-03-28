#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);

	ofBackground(255,255,255);	
	ofSetFrameRate(60);
    ofEnableSmoothing(); 
    
    font.loadFont("mono.ttf", 22);
    TTF.loadFont("mono.ttf", 7);

    setupAllButtons();
    
    thisOne = 0; 
    whaleGuide.loadImage("whaleguide.png"); 
    //fillOn = true; 
    wriggleOn = false; 
    translateFloat = false; 
    
    amplitude = 20; 
    period = 500; 
    dx = (TWO_PI / period);
    theta += 0.02;
    whaleLoc.set(0, 0);
    
    touchThresh = 5; 
}


//--------------------------------------------------------------
void testApp::update(){

    if (whaleParts.size() !=0) {
        for (int i = 0; i < whaleParts.size(); i++) {
            if (wriggleOn) {
                whaleParts[i].newPos.y = whaleParts[i].pos.y + whaleParts[i].floatValue;
            } else {
                whaleParts[i].newPos.y = whaleParts[i].pos.y + 0;             }
        } 
    }

    if (translateFloat) {
        letsFloat(); 
        whaleLoc.y = floatY; 
    }
    
    if (fillOn) {
        ofFill();
    } else {
        ofNoFill(); 
    }
    
    if (insertOn) {
        insertMode = "ON";
    } else {
        insertMode = "OFF"; 
    }
}

//--------------------------------------------------------------
void testApp::draw(){

    ofNoFill();
    ofSetColor(255);
    if (showImg) whaleGuide.draw(0,0);
    
    drawAllButtons(); 

	ofSetHexColor(0xe0be21);

    ofPushMatrix(); 
    ofTranslate(whaleLoc);

    
	ofBeginShape();
	
    if (whaleParts.size() != 0) {
         
    for (int i = 0; i < whaleParts.size(); i++){
        whaleParts[i].wriggle(i);

        if (i == 0){
            ofCurveVertex(whaleParts[0].pos.x, whaleParts[0].newPos.y); // we need to duplicate 0 for the curve to start at point 0
            ofCurveVertex(whaleParts[0].pos.x, whaleParts[0].newPos.y); // we need to duplicate 0 for the curve to start at point 0
        } else if (i == whaleParts.size()-1){
            ofCurveVertex(whaleParts[i].pos.x, whaleParts[i].newPos.y);
            ofCurveVertex(whaleParts[0].pos.x, whaleParts[0].newPos.y);	// to draw a curve from pt 6 to pt 0
            ofCurveVertex(whaleParts[0].pos.x, whaleParts[0].newPos.y);	// we duplicate the first point twice
        } else {
            ofCurveVertex(whaleParts[i].pos.x, whaleParts[i].newPos.y);
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
            ofVertex(whaleParts[i].pos.x, whaleParts[i].newPos.y);
        }
    }
    ofEndShape(false);
    
    
    ofSetColor(0,0,0,80);
    
    if (whaleParts.size() != 0) {
        for (int i = 0; i < whaleParts.size(); i++){
            if (whaleParts[i].bOver == true) ofFill();
            else ofNoFill();
            ofCircle(whaleParts[i].pos.x, whaleParts[i].newPos.y,4);

            TTF.drawString(ofToString(i), whaleParts[i].pos.x, whaleParts[i].newPos.y - 10); 
            
            if (i == thisOne) {
                ofFill(); 
                ofSetColor(255, 100, 100);
                ofCircle(whaleParts[i].pos.x, whaleParts[i].newPos.y,4);
            }
            ofSetColor(0,0,0,80);
        }
    }
    ofDisableAlphaBlending();
    ofPopMatrix(); 
    
	


    TTF.drawString("Status: "+message, 10, ofGetHeight() - 9);
    TTF.drawString("Insert: "+ insertMode, 10, ofGetHeight() - 29);
}
//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
	if( touch.id == 0 ){
        
        if (whaleParts.size()!=0) {
            
            for (int i = 0; i < whaleParts.size(); i++){
                float diffx = touch.x - whaleParts[i].pos.x;
                float diffy = touch.y - whaleParts[i].pos.y;
                float dist = sqrt(diffx*diffx + diffy*diffy);
                if (dist < touchThresh ){
                    whaleParts[i].bBeingDragged = true;
                    thisOne = i; 
                } else {
                    whaleParts[i].bBeingDragged = false;
                }	
            }
        }
        
	}
    
    touchDownAllButtons(touch);
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
	if( touch.id == 0 ){

            for (int i = 0; i < whaleParts.size(); i++){
                if (whaleParts[i].bBeingDragged == true){
                    whaleParts[i].pos.x = touch.x;
                    whaleParts[i].pos.y = touch.y;
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
    
    if (saveButton.isPressed()) saveXML("new.xml");
    if (loadWhale.isPressed()) loadXML("whaleParts.xml");
    if (loadButton.isPressed()) loadXML("new.xml");
    if (resetButton.isPressed()) whaleParts.clear(); 
    if (deleteLastButton.isPressed()) {
        whaleParts.erase(whaleParts.begin()+thisOne);
        /*
        if (!insertOn) {
            whaleParts.erase(whaleParts.end()) ;
        } else {
            whaleParts.erase(whaleParts.begin() + nearestOne); 
        }
         */
    }
    if (insertButton.isPressed()) insertOn = !insertOn; 
    if (fillButton.isPressed()) fillOn = !fillOn; 
    if (showImgButton.isPressed()) showImg = !showImg; 
    if (wriggleButton.isPressed()) wriggleOn = !wriggleOn;
    if (TfloatButton.isPressed()) translateFloat = !translateFloat; 
        
    touchUpAllButtons(touch);
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    
    vertex whalePoint; 
    whalePoint.pos.x = touch.x; 
    whalePoint.pos.y = touch.y; 
    
    whalePoint.bOver 			= false;
    whalePoint.bBeingDragged 	= false;
    whalePoint.radius           = 10;
    
    if (!insertOn) {
        
    whaleParts.push_back(whalePoint);
    } else {
        int nearest = ofGetWidth();
        nearestOne = 0; 
         
        for (int i = 0; i < whaleParts.size(); i++) {
            int distance = 0;
            distance = ofDist(whalePoint.pos.x, whalePoint.pos.y, whaleParts[i].pos.x, whaleParts[i].pos.y); 
            cout << distance << " " << i << endl; 
            if (distance < nearest) {
                nearest = distance; 
                nearestOne = i; 
            }
            
        }    
        cout << "nearest " << nearestOne << endl; 
        whaleParts.insert(whaleParts.begin() + nearestOne, whalePoint);
    }
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
        
        vertex p;
        p.pos.x = positions.getValue("X", 0);
        p.pos.y = positions.getValue("Y", 0);
        
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
        positions.addValue("X", whaleParts[i].pos.x);
        positions.addValue("Y", whaleParts[i].pos.y);
        positions.popTag();//pop position
    }
    positions.popTag(); //pop position
    positions.popTag(); //pop strokes
    positions.saveFile( ofxiPhoneGetDocumentsDirectory() + name);
    
    message = "saved XML" ; 
    
}

void testApp::letsFloat() {
    

    
    // For every x value, calculate a y value with sine function
    //float x = theta;

        floatY = sin(theta)*amplitude;
        theta+=dx;
    
    cout << "x " << theta << endl; 
    

}

void testApp::setupAllButtons() {
    saveButton.setup(); 
    saveButton.setLabel("SAVE", &font);
    loadButton.setup(); 
    loadButton.setLabel("LOAD", &font);
    loadWhale.setup(); 
    loadWhale.setLabel("LOAD WHALE", &font);
    resetButton.setup(); 
    resetButton.setLabel("RESET", &font);
    deleteLastButton.setup(); 
    deleteLastButton.setLabel("DELETE SELECTED", &font);
    insertButton.setup(); 
    insertButton.setLabel("INSERT", &font);
    fillButton.setup(); 
    fillButton.setLabel("FILL ON", &font);
    showImgButton.setup(); 
    showImgButton.setLabel("SHOW IMG", &font);
    wriggleButton.setup(); 
    wriggleButton.setLabel("WRIGGLE!", &font);
    TfloatButton.setup(); 
    TfloatButton.setLabel("FLOAT!", &font);
}

void testApp::drawAllButtons() {
    saveButton.draw(100, 10);
    loadButton.draw(100, 60); 
    loadWhale.draw(100, 110); 
    showImgButton.draw(100, 160);
    resetButton.draw(300, 10); 
    deleteLastButton.draw(300, 60); 
    insertButton.draw(300, 110); 
    fillButton.draw(300, 160);     
    wriggleButton.draw(600, 10); 
    TfloatButton.draw(600, 60); 
}

void testApp::touchDownAllButtons(ofTouchEventArgs &touch) {
    saveButton.touchDown(touch);
    loadButton.touchDown(touch);
    loadWhale.touchDown(touch);
    resetButton.touchDown(touch);
    deleteLastButton.touchDown(touch);
    insertButton.touchDown(touch);
    fillButton.touchDown(touch);
    showImgButton.touchDown(touch);
    wriggleButton.touchDown(touch);
    TfloatButton.touchDown(touch);
}

void testApp::touchUpAllButtons(ofTouchEventArgs &touch) {
    saveButton.touchUp(touch);
    loadButton.touchDown(touch);
    loadWhale.touchDown(touch);
    resetButton.touchDown(touch);
    insertButton.touchDown(touch);
    deleteLastButton.touchDown(touch);
    fillButton.touchDown(touch);
    showImgButton.touchDown(touch);
    wriggleButton.touchDown(touch);
    TfloatButton.touchDown(touch);
}
