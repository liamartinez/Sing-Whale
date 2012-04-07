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
	ofSetupScreen();
	ofBackground(34, 45, 73);
	ofSetFrameRate(60);
	
	/* This is stuff you always need.*/
	
	sampleRate 			= 44100; /* Sampling Rate */
	initialBufferSize	= 512;	/* Buffer Size. you have to fill this buffer with sound*/

    buffer				= new float[initialBufferSize];
	memset(buffer, 0, initialBufferSize * sizeof(float));

	/* Now you can put anything you would normally put in maximilian's 'setup' method in here. */
	
    heightHistory.assign(400, 0.0);
	
	smoothedAve     = 0.0;
	scaledAve		= 0.0;
	
	fftSize = 1024;
	mfft.setup(fftSize, 1024, 256);
	
	nAverages = 2; //how fine do we want our analyzer
	oct.setup(sampleRate, fftSize/2, nAverages);
	
	ofxMaxiSettings::setup(sampleRate, 2, initialBufferSize);
     
	ofSoundStreamSetup(0,1, this, sampleRate, initialBufferSize, 4);/* Call this last ! */
	
	ofSetVerticalSync(true);
    
}

//--------------------------------------------------------------
void testApp::update(){
    
    float xinc = 900.0 / fftSize * 2.0;
    
    //octave analyser

    highest = 0; 

	xinc = 500 / oct.nAverages;
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
    cout << "THE BIN " << theBin << endl; 
    theBins.push_back(theBin);
    if( theBins.size() >= 400 ){
		theBins.erase(theBins.begin(), theBins.begin()+1);
	}

}

//--------------------------------------------------------------
void testApp::draw(){


    ofSetColor(78, 96, 146);
      
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
    
    ofSetColor(225);
	string reportString = "nAverages: "+ofToString(nAverages);
	ofDrawBitmapString(reportString, 50, 85);

    	
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
    
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
    
    if (touch.x > ofGetHeight()/2) {
        nAverages ++; 
    } else if (touch.x < ofGetHeight()/2) {
        nAverages --; 
    }
    
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



