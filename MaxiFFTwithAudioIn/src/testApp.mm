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
	
	
    
	fftSize = 1024;
	mfft.setup(fftSize, 1024, 256);
	ifft.setup(fftSize, 1024, 256);
	
	
	
	nAverages = 12;
	oct.setup(sampleRate, fftSize/2, nAverages);
	
	ofxMaxiSettings::setup(sampleRate, 2, initialBufferSize);
     
     
	ofSoundStreamSetup(0,1, this, sampleRate, initialBufferSize, 4);/* Call this last ! */
	
	ofSetVerticalSync(true);
    
}

//--------------------------------------------------------------
void testApp::update(){
}

//--------------------------------------------------------------
void testApp::draw(){
	
     // here we draw volume 
    ofTranslate(0, -50, 0);
    
	// draw the input:
	ofSetHexColor(0x333333);
	ofRect(70,100,256,200);
	ofSetHexColor(0xFFFFFF);
	for (int i = 0; i < initialBufferSize; i++){
		ofLine(70+i,200,70+i,200+buffer[i]*100.0f);
	}
    
	ofSetHexColor(0x333333);
	drawCounter++;
	char reportString[255];
	sprintf(reportString, "buffers received: %i\ndraw routines called: %i\n", bufferCounter,drawCounter);
	ofDrawBitmapString(reportString, 70,308);
    
    
    //----------
    
    ofTranslate(0, -50, 0);
	ofSetColor(255, 255, 255,255);
    
	//draw fft output
	float xinc = 900.0 / fftSize * 2.0;
	for(int i=0; i < fftSize / 2; i++) {
		float height = mfft.magnitudesDB[i] / 50.0 * 400;
		ofRect(100 + (i*xinc),450 - height,2, height);
	}
    
    //octave analyser
	ofSetColor(255, 0, 0,100);
	xinc = 900.0 / oct.nAverages;
	for(int i=0; i < oct.nAverages; i++) {
		float height = oct.averages[i] / 50.0 * 100;
		ofRect( (i*xinc),200 - height,2, height);
	}
    /*
	//draw phases
	ofSetColor(0, 255, 0,100);
	for(int i=0; i < fftSize / 2; i++) {
		float height = mfft.phases[i] / 50.0 * 400;
		ofRect(100 + (i*xinc),500 - height,2, height);
	}
	

     */
	
    //	cout << callTime << endl;
     
	
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



