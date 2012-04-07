#include "testApp.h"


//-------------------------------------------------------------
testApp::~testApp() {
	
}

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	
	//If you want a landscape oreintation 
	iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	ofBackground(150,150,127);
    
    TTF.loadFont("mono.ttf", 7);
    
    singing.setup(); 
    
    /* This is stuff you always need.*/
	sampleSize      = 200; //number of points in the line
	sampleRate 			= 44100; /* Sampling Rate */
	initialBufferSize	= 512;	/* Buffer Size. you have to fill this buffer with sound*/
    
    buffer				= new float[initialBufferSize];
	memset(buffer, 0, initialBufferSize * sizeof(float));
    
	/* Now you can put anything you would normally put in maximilian's 'setup' method in here. */
    heightHistory.assign(sampleSize, 0.0);
	
	smoothedAve     = 0.0;
	scaledAve		= 0.0;
	
	fftSize = 1024;
	mfft.setup(fftSize, 1024, 256);
	
	nAverages = 2; //how fine do we want our analyzer
	oct.setup(sampleRate, fftSize/2, nAverages);
	
	ofxMaxiSettings::setup(sampleRate, 2, initialBufferSize);
    
	ofSoundStreamSetup(0,1, this, sampleRate, initialBufferSize, 4);/* Call this last ! */

    //interface
    whitneySemiBold22.loadFont("fonts/Whitney-Semibold.otf",22);
    
    beginButt.setup(); 
    beginButt.setColor(ofColor(232, 58, 37));
    beginButt.setLabel("start/ stop", &whitneySemiBold22);
    begin = false; 
    
    resetButt.setup(); 
    resetButt.setColor(ofColor(232, 58, 37));
    resetButt.setLabel("start again", &whitneySemiBold22);
    reset = false; 
    
    

}

//--------------------------------------------------------------
void testApp::update(){
    singing.update(); 
    
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
                    theBin = i*20;  
                } else {
                    theBin = 0; 
                }
            }
        }
        
        //disable this because I want to count silences
        //if (theBin != 0) { 
        //cout << "THE BIN " << theBin << endl; 
        //theBin = ofMap(theBin, 0, 50, 30, 100);
        if (theBins.size() < sampleSize) theBins.push_back(theBin);
        singing.letsGo(theBins.size(), theBin); 
        //}
                
    }
    if (reset) {
        reset = false; 
        begin = false; 
        for (int i = 0; i < sampleSize-1; i++){
            singing.reset(); 
            //grid.drawWater(i, grid.lenVertz); 
            theBins.clear(); 
            
        }
    }
    
    
    
}

//--------------------------------------------------------------
void testApp::draw(){
    beginButt.draw( 10, 10); 
    resetButt.draw(10, 90);
    singing.draw(); 
    
    if (begin && theBins.size() != 0) {
        
        
        
        /*
        
        
        for (int i = 0; i < theBins.size(); i++){
            singing.letsGo(i, theBins[i], sampleSize);
            
            //ofSetColor(255, 100, 100);
            //ofCircle (grid.startLoc.x + ((grid.lenHorz/grid.numHorz)* (i+1)), grid.getLocation().y + 15, 5, 5); 
            
        } 
        */
        
        
        ofBeginShape();
        for (int i = 0; i < theBins.size(); i++){
            if( i == 0 ) ofVertex(i, 100);
            
            ofVertex(i, 300 - theBins[i]);
            
            if( i == theBins.size() -1 ) ofVertex(i, 100);
        }
        ofEndShape(false);	
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
}
//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){

    beginButt.touchDown(touch);
    singing.touchDown(touch);
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    singing.touchMoved(touch);
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
    beginButt.touchDown(touch);
    resetButt.touchDown(touch);
    if (beginButt.isPressed()) begin = !begin; 
    if (resetButt.isPressed()) reset = true; 

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    singing.touchDoubleTap(touch);
 
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

