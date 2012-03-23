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
	ofBackground(193, 217, 197);
	ofSetFrameRate(30);
    ofSetVerticalSync(true);
	
	/* This is stuff you always need.*/
	
	sampleRate 			= 44100; /* Sampling Rate */
	initialBufferSize	= 512;	/* Buffer Size. you have to fill this buffer with sound*/

    buffer				= new float[initialBufferSize];
	memset(buffer, 0, initialBufferSize * sizeof(float));

	/* Now you can put anything you would normally put in maximilian's 'setup' method in here. */
	
    sampleSize      = 70; //number of points in the line
    tightness       = .002;
    threshold       = 5; //make this an adjustable option
    gridLen     = 1000; 
    
    heightHistory.assign(sampleSize, 0.0);
	
	smoothedAve     = 0.0;
	scaledAve		= 0.0;
	
	fftSize = 1024;
	mfft.setup(fftSize, 1024, 256);
	
	nAverages = 2; //how fine do we want our analyzer
	oct.setup(sampleRate, fftSize/2, nAverages);
	
	ofxMaxiSettings::setup(sampleRate, 2, initialBufferSize);
     
	ofSoundStreamSetup(0,1, this, sampleRate, initialBufferSize, 4);/* Call this last ! */
	
    
    //grid stuff
    grid.setLength(gridLen);
    grid.setLengthDensity(sampleSize, tightness);
    grid.setLocation(10, ofGetHeight()/2);
    
    grid.setupBox2d(0, 0);
    grid.setupGrid();
    
    //grid stuff
    guide.setLength(gridLen);
    guide.setLengthDensity(sampleSize, tightness);
    guide.setLocation(10, ofGetHeight() - ofGetHeight()/4);
    
    guide.setupBox2d(0, 0);
    guide.setupGrid();
    
    
    //interface
    whitneySemiBold22.loadFont("fonts/Whitney-Semibold.otf",22);
    
    beginButt.setup(); 
    beginButt.setColor(ofColor(232, 58, 37));
    beginButt.setLabel("start/ stop", &whitneySemiBold22);
    begin = false; 
    
    skeletonButt.setup(); 
    skeletonButt.setColor(ofColor(232, 58, 37));
    skeletonButt.setLabel("show grid", &whitneySemiBold22);
    
    resetButt.setup(); 
    resetButt.setColor(ofColor(232, 58, 37));
    resetButt.setLabel("start again", &whitneySemiBold22);
    
    saveButt.setup(); 
    saveButt.setColor(ofColor(232, 58, 37));
    saveButt.setLabel("save", &whitneySemiBold22);
    
    loadButt.setup(); 
    loadButt.setColor(ofColor(232, 58, 37));
    loadButt.setLabel("load", &whitneySemiBold22);
    
    checkButt.setup(); 
    checkButt.setColor(ofColor(232, 58, 37));
    checkButt.setLabel("check", &whitneySemiBold22);
    
    loadMe = false;
    checkMe = false; 
    reset   = false; 
    message = "FIRST LOAD, THEN START, THEN CHECK!"; 
    
    numSong = 1; 
    
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

    }
    grid.update(); 
    guide.update(); 
}

//--------------------------------------------------------------
void testApp::draw(){

    //buttons
    beginButt.draw( 10, 10); 
    skeletonButt.draw(10, 50); 
    resetButt.draw(10, 90);
    saveButt.draw(200, 10);
    loadButt.draw(200, 50);
    checkButt.draw(200, 90);
    
    ofSetColor(78, 96, 146);
        
    ofSetColor(225);

    grid.drawGrid();
    guide.drawGrid(); 
    
    if (begin && theBins.size() != 0) {
        for (int i = 0; i < theBins.size()-1; i++){
            grid.letsGo(i, theBins[i]);
        }
    }
    
    if (reset) {
        reset = false; 
        begin = false; 
        for (int i = 0; i < sampleSize-1; i++){
            grid.letsGo(i, grid.lenVertz);

            grid.letsReset(i); 
            theBins.clear(); 

        }
    }
    
    if (loadMe) {
        loadMe = false; 
        int whichSong = 0; 

        for (int i = 0; i < songCount[whichSong].size()-1; i++){
            guide.letsGo(i, songCount[whichSong][i]);
        }
        //savedBins.clear(); //then clear it 
         
    }
    
    /*
    if (checkMe) {
        checkMe = false; 
        if (checkSong()) {
            message = "YOU GOT IT";
        } else {
            message = "TRY AGAIN";
        }
    }
     */
    ofSetColor(232, 58, 37);
    ofDrawBitmapString(message, 300, 50);
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
    saveButt.touchDown(touch);
    loadButt.touchDown(touch);
    checkButt.touchDown(touch);
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
        
    if (beginButt.isPressed()) {
        begin = !begin; 
    }
    
    if (skeletonButt.isPressed()) {
        grid.seeGrid(); 
        guide.seeGrid(); 
    }
    
    if (resetButt.isPressed()) {
        reset = true; 

    }
    
    if (saveButt.isPressed()) {
        numSong ++; 
        saveSong(numSong); 
    }
    
    if (loadButt.isPressed()) {
        loadSong(); 
    }
    
    if (checkButt.isPressed()) {
        checkMe = true; 
    }
    
    beginButt.touchUp(touch);
    skeletonButt.touchUp(touch);
    resetButt.touchUp(touch);
    saveButt.touchUp(touch);
    loadButt.touchUp(touch);
    checkButt.touchUp(touch);
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

//--------------------------------------------------------------
void testApp::saveSong(int numSong_) {
    
    //ofxXmlSettings songs;
    ofxXmlSettings positions;
    
    positions.addTag("songList");
    positions.pushTag("songList");
    positions.addTag("songs");
    positions.addAttribute("songs", "song", numSong_,0);
    positions.pushTag("songs");
 
    for(int i = 0; i < theBins.size(); i++){
        positions.addValue("pos", theBins[i]);
    }
    
    positions.popTag(); //pop position
    positions.popTag(); 
    positions.saveFile(ofxiPhoneGetDocumentsDirectory() + "positions.xml");
    cout << "positions.xml saved to app documents folder" << endl; 
}

//--------------------------------------------------------------
void testApp::loadSong() {
    ofxXmlSettings gotSongs;
    ofxXmlSettings songList; 
    
    if(songList.loadFile(ofxiPhoneGetDocumentsDirectory() + "positions.xml")){
        
        songList.pushTag("songList");
        numberOfSongs = songList.getNumTags("songs");
        cout << "total" << numberOfSongs << endl; 
        //songCount.resize(numberOfSongs);
        
        for(int i = 0; i < numberOfSongs; i++){
        
            int gotSong = songList.getAttribute("songs", "song",0);
            cout << "got song" << gotSong << endl; 
            
            songList.pushTag("songs",i);
            int numberOfSavedPoints = songList.getNumTags("pos");
            
            vector <int> savedBins; 
            
            for(int i = 0; i < numberOfSavedPoints; i++){
                
                int savedBin;
                savedBin = songList.getValue("pos", 0, i);
                savedBins.push_back(savedBin);
           
            }
            
            songCount.push_back(savedBins);
            //cout << i << " " << songCount[i].size() << endl; 
            cout << "songcount size" << songCount.size() << endl; 

        }
        songList.popTag(); //pop position
        songList.popTag(); 
        
        loadMe = true; 
    }
    else{
        ofLogError("Position file did not load!");
    }
    
}

/*
//--------------------------------------------------------------
bool testApp::checkSong() {
    
    int points = 0; 
    
    //lets do something that sees which one is shorter
    int longer = 0; 
    
    if (savedBins.size() > theBins.size()) {
        longer = savedBins.size();
    } else {
        longer = theBins.size(); 
    }
    
    for (int i = 0; i < longer-1; i++) {
        
        if (savedBins[i] < (theBins[i] + threshold) && savedBins[i] > (theBins[i] - threshold)) {
            points ++; 
        }        
    }
    if (points > savedBins.size() - savedBins.size()/3) return true; 
}


*/








