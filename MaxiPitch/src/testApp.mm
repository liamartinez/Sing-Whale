#include "testApp.h"





//-------------------------------------------------------------
testApp::~testApp() {
	delete inputL; // clean up after yourself 
    delete inputR;
}


//--------------------------------------------------------------
void testApp::setup(){
	/* some standard setup stuff*/
    
	ofEnableAlphaBlending();
	ofSetupScreen();
	ofBackground(0, 0, 0);
	ofSetFrameRate(60);
	ofSetVerticalSync(true);
    
	/* This is stuff you always need.*/
	
	sampleRate 			= 44100; /* Sampling Rate */
	initialBufferSize	= 512;	/* Buffer Size. you have to fill this buffer with sound*/
    
    /*
	lAudioOut			= new float[initialBufferSize];//outputs
	rAudioOut			= new float[initialBufferSize];
  
    
	lAudioIn			= new float[initialBufferSize];// inputs 
	rAudioIn			= new float[initialBufferSize];
	*/
    
    inputL = new float[initialBufferSize]; 
    inputR = new float[initialBufferSize];
    
	
	/* This is a nice safe piece of code */
    /*
	memset(lAudioOut, 0, initialBufferSize * sizeof(float));
	memset(rAudioOut, 0, initialBufferSize * sizeof(float));
	*/
     
	memset(inputL, 0, initialBufferSize * sizeof(float));
	memset(inputR, 0, initialBufferSize * sizeof(float));
	
	/* Now you can put anything you would normally put in maximilian's 'setup' method in here. */
	
    fft.setup(16384, 1024, 512);
    soundStream.setup(this, 2, 2, 44100, initialBufferSize, 4);estimatedPitch[0] = estimatedPitch[1] = estimatedPitch[2] = 0.f;
    
	
    /*
	fftSize = 1024;
	mfft.setup(fftSize, 1024, 256);
	ifft.setup(fftSize, 1024, 256);
	
	
	
	nAverages = 12;
	oct.setup(sampleRate, fftSize/2, nAverages);
	
	ofxMaxiSettings::setup(sampleRate, 2, initialBufferSize);
	ofSoundStreamSetup(2,0, this, sampleRate, initialBufferSize, 4);
     */
     
     /* Call this last ! */
	
	
    
}

//--------------------------------------------------------------
void testApp::update(){
}

//--------------------------------------------------------------
void testApp::draw(){
	
    ofSetColor(255, 255, 255, 255); 
    int i;
    for(i = 0; i < fft.bins; i++) {
        ofRect(i * 11, 100 - (fft.magnitudesDB[i] * 4), 11, fft.magnitudesDB[i] * 8); 
        
        cout << fft.magnitudesDB[i] << endl; 
    }

	ofRect(100, 100, 50, 50);
    
    
}
//--------------------------------------------------------------
void testApp::exit(){
    
}
//--------------------------------------------------------------

void testApp::audioRequested 	(float * output, int bufferSize, int nChannels){
    
    
    for (int i = 0; i < bufferSize; i++) {
        wave = sine.sinebuf4(abs(estimatedPitch[0])) + sine1.sinebuf4(abs(estimatedPitch[1])) + sine1.sinebuf4(abs(estimatedPitch[2]));
        mix.stereo(wave/3.f, outputs, 0.5);
        output[i*nChannels ]        = outputs[0];
        output[i*nChannels + 1]     = outputs[1]; }
     
}


//--------------------------------------------------------------
void testApp::audioReceived 	(float * input, int bufferSize, int nChannels){	
    
    
    double lIn, rIn;
    int threshold = 5;
    
    int i;
    for (i = 0; i < bufferSize; i++){
        lIn = input[i*2]; if(fft.process(lIn)) {
            fft.magsToDB(); }
        rIn = input[i*2 + 1]; if(fft.process(rIn)) {
            fft.magsToDB(); }
    }
    
    bin_number = bin_number1 = bin_number2 = 0;
    largests[0] = largests[1] = largests[2] = 0.f; for (i = 0; i < fft.bins; i++) {
        if(abs(fft.magnitudesDB[i]) > largests[0]) {
            largests[2] = largests[1];
            largests[1] = largests[0];
            largests[0] = abs(fft.magnitudesDB[i]);
            bin_number2 = bin_number1; bin_number1 = bin_number; bin_number = i;
        } 
    }
    
    if(largests[0] > threshold)
        estimatedPitch[0] = ( (float) bin_number / fft.bins) * (sampleRate * 0.5); else
            estimatedPitch[0] = 0.f;
    if(largests[1] > threshold)
        estimatedPitch[1] = ( (float) bin_number1 / fft.bins) * (sampleRate * 0.5);
    else
        estimatedPitch[1] = 0.f;
    if(largests[2] > threshold)
        estimatedPitch[2] = ( (float) bin_number2 / fft.bins) * (sampleRate * 0.5);
    else
        estimatedPitch[2] = 0.f;
	
	/* You can just grab this input and stick it in a double, then use it above to create output*/
	
    /*
	for (int i = 0; i < bufferSize; i++){
		
		// you can also grab the data out of the arrays
		
		lAudioIn[i] = input[i*2];
		rAudioIn[i] = input[i*2+1];
	}
    */
    
	
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



