#include "testApp.h"





//-------------------------------------------------------------
testApp::~testApp() {
	
}


//--------------------------------------------------------------
void testApp::setup(){
    
    // register touch events
	ofRegisterTouchEvents(this);
	
	/* some standard setup stuff*/
    ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	ofEnableAlphaBlending();
    ofEnableSmoothing();
	ofSetupScreen();
	ofBackground(34, 45, 73);
	ofSetFrameRate(60);
	
	/* This is stuff you always need.*/
	
	sampleRate 			= 44100; /* Sampling Rate */
	initialBufferSize	= 512;	/* Buffer Size. you have to fill this buffer with sound*/

    buffer				= new float[initialBufferSize];
	memset(buffer, 0, initialBufferSize * sizeof(float));

	/* Now you can put anything you would normally put in maximilian's 'setup' method in here. */
	
    sampleSize      = 200; 
    
    heightHistory.assign(sampleSize, 0.0);
	
	smoothedAve     = 0.0;
	scaledAve		= 0.0;
	
	fftSize = 1024;
	mfft.setup(fftSize, 1024, 256);
	
	nAverages = 2; //how fine do we want our analyzer
	oct.setup(sampleRate, fftSize/2, nAverages);
	
	ofxMaxiSettings::setup(sampleRate, 2, initialBufferSize);
     
	ofSoundStreamSetup(0,1, this, sampleRate, initialBufferSize, 4);/* Call this last ! */
	
	ofSetVerticalSync(true);
    
    //grid stuff
    grid.setLength(1000);
    grid.setLengthDensity(sampleSize, .02);
    grid.setLocation(10);
    
    grid.setupBox2d(0, 0);
    grid.setupGrid();
    
    //interface
    whitneySemiBold22.loadFont("fonts/Whitney-Semibold.otf",22);
    
    beginButt.setup(); 
    beginButt.setLabel("start/ stop", &whitneySemiBold22);
    begin = false; 
    
    skeletonButt.setup(); 
    skeletonButt.setLabel("show grid", &whitneySemiBold22);
    
    resetButt.setup(); 
    resetButt.setLabel("start again", &whitneySemiBold22);

}

//--------------------------------------------------------------
void testApp::update(){
    
    float xinc = 900.0 / fftSize * 2.0;
    
    //octave analyser

    highest = 0; 

	xinc = 500 / oct.nAverages;
    if (begin) {
        for(int i=0; i < oct.nAverages; i++) {
            float height = oct.averages[i] / 50.0 * 100;
            
            if (height > highest) {
                highest = height; 
                if (highest > 20) {
                    theBin = i*10; 
                } else {
                    theBin = 0; 
                }
            }
        }
        
        
        if (theBin != 0) {
            theBin = ofMap(theBin, 30, 50, 30, 100);
            if (theBins.size() < sampleSize) theBins.push_back(theBin);
        }
        /*
        for (int i = 0; i < sampleSize-1; i++) {
            theBins.push_back(theBin);
        }
        
        if( theBins.size() >= sampleSize ){
            theBins.erase(theBins.begin(), theBins.begin()+1);
        }
         */
    }
    grid.update(); 
}

//--------------------------------------------------------------
void testApp::draw(){

    //buttons
    beginButt.draw( 10, 10); 
    skeletonButt.draw(10, 50); 
    resetButt.draw(10, 90);
    ofSetColor(78, 96, 146);
    
    /*
    ofBeginShape();
    for (int i = 0; i < theBins.size(); i++){
        if( i == 0 ) ofVertex(i, 100);
        
        ofVertex(i, 300 - theBins[i]);
        
        if( i == theBins.size() -1 ) ofVertex(i, 100);
    }
    ofEndShape(false);	
   
     
    highest = int(ofMap(highest, 35, 80, 1, 4));
    if (highest == 1) ofSetColor(100, 100, 100);
    if (highest == 2) ofSetColor(255, 100, 100);
    if (highest == 3) ofSetColor(100, 255, 100);
    if (highest == 4) ofSetColor(100, 100, 255);
    
    ofCircle(50, 50, 25);
    */ 
    
    ofSetColor(225);
    /*
	string reportString = "nAverages: "+ofToString(nAverages);
	ofDrawBitmapString(reportString, 50, 85);
    */
    
    grid.drawGrid();
    if (begin && theBins.size() != 0) {
        for (int i = 0; i < theBins.size()-1; i++){
            grid.letsGo(i, theBins[i]);
        }
    }
    
    if (reset) {
        reset = false; 
        for (int i = 0; i < sampleSize-1; i++){
            grid.letsGo(i, grid.lenVertz);
            //set location to reset also
            theBins.clear(); 
        }
    }
    
}
//--------------------------------------------------------------
void testApp::exit(){
    
}
//--------------------------------------------------------------

void testApp::audioRequested 	(float * output, int bufferSize, int nChannels){

}


//--------------------------------------------------------------
void testApp::audioReceived 	(float * input, int bufferSize, int nChannels){	

	if( initialBufferSize != bufferSize ){
		ofLog(OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize);
		return;
	}	
	
	// samples are "interleaved"
	for (int i = 0; i < bufferSize; i++){
		buffer[i] = input[i];
        
        if (mfft.process(input[i])) {  
            mfft.magsToDB(); // calculate all the DBs  
            oct.calculate(mfft.magnitudesDB); // this will store the DBs of each octave range  
        }  
    }
	bufferCounter++; //lia:what is bufferCounter for?
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
    beginButt.touchDown(touch);
    skeletonButt.touchDown(touch);
    resetButt.touchDown(touch);
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
    
    /*
    if (touch.x > ofGetHeight()/2) {
        nAverages ++; 
    } else if (touch.x < ofGetHeight()/2) {
        nAverages --; 
    }
    */
    
    if (beginButt.isPressed()) {
        begin = !begin; 
    }
    
    if (skeletonButt.isPressed()) {
        grid.seeGrid(); 
    }
    
    if (resetButt.isPressed()) {
        reset = true; 
        //grid.setupGrid(); //need to destroy old grid? 
    }
    
    beginButt.touchUp(touch);
    skeletonButt.touchUp(touch);
    resetButt.touchUp(touch);
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
    
}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){
	
}



