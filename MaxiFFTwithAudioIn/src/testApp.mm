#include "testApp.h"





//-------------------------------------------------------------
testApp::~testApp() {
	
}


//--------------------------------------------------------------
void testApp::setup(){
    
    // register touch events
	ofRegisterTouchEvents(this);
	
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	/* some standard setup stuff*/
    
	ofEnableAlphaBlending();
	ofSetupScreen();
	ofBackground(0, 0, 0);
	ofSetFrameRate(60);
	
	/* This is stuff you always need.*/
	
	sampleRate 			= 44100; /* Sampling Rate */
	initialBufferSize	= 512;	/* Buffer Size. you have to fill this buffer with sound*/
    


    buffer				= new float[initialBufferSize];
	memset(buffer, 0, initialBufferSize * sizeof(float));


	
	/* Now you can put anything you would normally put in maximilian's 'setup' method in here. */
	
    aveHistory.assign(400, 0.0);
	
	smoothedAve     = 0.0;
	scaledAve		= 0.0;
	
    
	fftSize = 1024;
	mfft.setup(fftSize, 1024, 256);
	ifft.setup(fftSize, 1024, 256);
	
	
	nAverages = 20;
	oct.setup(sampleRate, fftSize/2, nAverages);
	
	ofxMaxiSettings::setup(sampleRate, 2, initialBufferSize);
     
     
	ofSoundStreamSetup(0,1, this, sampleRate, initialBufferSize, 4);/* Call this last ! */
	
	ofSetVerticalSync(true);
    
}

//--------------------------------------------------------------
void testApp::update(){
    
    //clamp values from 0 - 50
    smoothedAve = ofClamp(smoothedAve, 0.0, 50.0);
    // scale the vol up to a 0-1 range 
	scaledAve = ofMap(smoothedAve, 0.0, 0.17, 0.0, 1.0, true);
    
	//lets record the volume into an array
	aveHistory.push_back( scaledAve );
	
	//if we are bigger the the size we want to record - lets drop the oldest value
	if( aveHistory.size() >= 400 ){
		aveHistory.erase(aveHistory.begin(), aveHistory.begin()+1);
	}
}

//--------------------------------------------------------------
void testApp::draw(){
	
    
    //lets draw the volume history as a graph
    ofSetColor(245, 58, 135);	
    ofBeginShape();
    for (int i = 0; i < aveHistory.size(); i++){
        if( i == 0 ) ofVertex(i, 200);
       //cout << aveHistory[i] << endl;
        //ofCircle(i, 200, 50*aveHistory[i]);
        ofVertex(i, 200 - aveHistory[i] * 2000);
        
        if( i == aveHistory.size() -1 ) ofVertex(i, 200);
    }
    ofEndShape(false);	
     // here we draw volume 
    //ofTranslate(0, -50, 0);
    
    /*
	// draw the input:
	ofSetHexColor(0x333333);
	//ofRect(70,100,256,200);
	ofSetHexColor(0xFFFFFF);
	for (int i = 0; i < initialBufferSize; i++){
		ofLine(70+i,200,70+i,200+buffer[i]*100.0f);
	}
    
	ofSetHexColor(0x333333);
	drawCounter++;
	char reportString[255];
	sprintf(reportString, "buffers received: %i\ndraw routines called: %i\n", bufferCounter,drawCounter);
	ofDrawBitmapString(reportString, 70,308);
    
    */
    
    //----------
    
    ofTranslate(0, -50, 0);
	ofSetColor(255, 255, 255,255);
    
	//draw fft output
	float xinc = 900.0 / fftSize * 2.0;
    /*
	for(int i=0; i < fftSize / 2; i++) {
		float height = mfft.magnitudesDB[i] / 50.0 * 400;
		ofRect(100 + (i*xinc),450 - height,2, height);
	}
    */
    //octave analyser
    numCounted = 0;	
    
    highest = 0; 
    float curAve = 0.0;
	ofSetColor(255, 0, 0,100);
	xinc = 900.0 / oct.nAverages;
	for(int i=0; i < oct.nAverages; i++) {
		float height = oct.averages[i] / 50.0 * 100;
        curAve = oct.averages[i];
        numCounted+=2;
		ofRect( (i*xinc),200 - height,2, height);
        if (height > highest) highest = height; 
        //cout << highest << endl; 
	}
        
    highest = int(ofMap(highest, 35, 80, 1, 4));
    if (highest == 1) ofSetColor(100, 100, 100);
    if (highest == 2) ofSetColor(255, 100, 100);
    if (highest == 3) ofSetColor(100, 255, 100);
    if (highest == 4) ofSetColor(100, 100, 255);
    
    ofCircle(100, 100, 50);
    
    //this is how we get the mean of rms :) 
    curAve /= (float)numCounted;
    
    // this is how we get the root of rms :) 
    curAve = sqrt( curAve );
    
    smoothedAve *= 0.93;
    smoothedAve += 0.07 * curAve;
    
    
    
    /*
	//draw phases
	ofSetColor(0, 255, 0,100);
	for(int i=0; i < fftSize / 2; i++) {
		float height = mfft.phases[i] / 50.0 * 400;
		ofRect(100 + (i*xinc),500 - height,2, height);
	}
	

     */
	
    //	cout << callTime << endl;
    
    //-------------

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



