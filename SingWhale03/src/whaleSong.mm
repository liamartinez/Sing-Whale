

#include "whaleSong.h"

//-------------------------------------------------------------
whaleSong::whaleSong() {
//    ofAddListener(ofEvents.audioReceived,this,&whaleSong::audioReceivedIn); 
}

//-------------------------------------------------------------
whaleSong::~whaleSong() {
	
}


//--------------------------------------------------------------
void whaleSong::setup(){
    
    // register touch events
    //ofAddListener(ofEvents.audioReceived,this,&whaleSong::audioReceived);  

	/* some standard setup stuff*/

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
    
    
	/*ofSoundStreamSetup(0,1, this, sampleRate, initialBufferSize, 4); */
     /* Call this last ! */

    ofAddListener(ofEvents.audioReceived,this,&whaleSong::audioReceivedIn);  
    
    //grid stuff
    grid.setLength(gridLen);
    grid.setLengthDensity(sampleSize, tightness);
    //grid.setLocation(10, ofGetHeight()/2);
    grid.setLocation(10, ofGetHeight() - ofGetHeight()/4);
    
    grid.setWorld(1);
    grid.setupBox2d(0, 0);
    grid.setupGrid();
    
    //grid stuff
    guide.setLength(gridLen);
    guide.setLengthDensity(sampleSize, tightness);
    guide.setLocation(10, ofGetHeight() - ofGetHeight()/4);
    
    guide.setWorld(2);
    guide.setupBox2d(0, 0);
    guide.setupGrid();

    

    
    
    //interface
    whitneySemiBold22.loadFont("fonts/Whitney-Semibold.otf",22);
    //setupButtons(); 

        
    checkMe = false; 
    reset   = false; 
    correct = false; 
    checked = false; 
    message = "TEMPORARY DEBUG CONTROLS"; 
    
    whichSong = 0; 
    showGrid = true; 
    
    //ofSoundStreamSetup(0, 1);
    //ofSoundStreamSetup(0,1, this, 44100, 512, 4);/* Call this last ! */

}

//--------------------------------------------------------------
void whaleSong::update(){
    
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
        
        //disable this because I want to count silences
        //if (theBin != 0) {
            theBin = ofMap(theBin, 0, 50, 30, 100);
            if (theBins.size() < sampleSize) theBins.push_back(theBin);
        //}
        
    }
    if (showGrid) grid.update(); 
    guide.update(); 
}

//--------------------------------------------------------------
void whaleSong::draw(){
    
    
    //buttons
    //drawButtons(); 
        
    //ofSetColor(78, 96, 146);
    
    ofSetColor(225);
    
    if (showGrid) {
        grid.drawGrid();
        grid.fillSong = false; 
    }
    guide.drawGrid(); 
    guide.fillSong = true; 
    
    if (showGrid) {
        if (begin && theBins.size() != 0) {
            for (int i = 0; i < theBins.size(); i++){
                grid.letsGo(i, theBins[i]);
                
                ofSetColor(255, 100, 100);
                ofCircle (grid.startLoc.x + ((grid.lenHorz/grid.numHorz)* (i+1)), grid.getLocation().y - 10, 3, 3); 
                
                if (i == theBins.size()-1) {
                   //checkMe = true; 
                   //checked = true;   
                }
            }
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

    
    if (checkMe) {
        checkMe = false; 
        if (checkSong()) {
            message = "YOU GOT IT";
            //correct = true; 
        } else {
            message = "TRY AGAIN";
            //correct = false; 
        }
    }
     
    
    ofSetColor(232, 58, 37);
    ofDrawBitmapString(message, 300, 50);
}
//--------------------------------------------------------------
void whaleSong::exit(){
    
}
//--------------------------------------------------------------

void whaleSong::audioRequested 	(float * output, int bufferSize, int nChannels){
    
}


//old method
void whaleSong::audioReceivedIn(ofAudioEventArgs &args){  
 
    if( initialBufferSize != args.bufferSize ){
		ofLog(OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, args.bufferSize);
		return;
	}		
	// samples are "interleaved"
	for (int i = 0; i < args.bufferSize; i++){
		buffer[i] = args.buffer[i];

        if (mfft.process(args.buffer[i])) {  
            mfft.magsToDB(); // calculate all the DBs  
            oct.calculate(mfft.magnitudesDB); // this will store the DBs of each octave range  
        }  
    }
}

//--------------------------------------------------------------
void whaleSong::touchDown(ofTouchEventArgs &touch){
    //touchDownButtons(touch);
}

//--------------------------------------------------------------
void whaleSong::touchMoved(ofTouchEventArgs &touch){
    
}

//--------------------------------------------------------------
void whaleSong::touchUp(ofTouchEventArgs &touch){
    
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
    
    if (checkButt.isPressed()) {
        checkMe = true; 
    }
    
    if (correctButt.isPressed()) correct = true; 
    if (tryAgainButt.isPressed()) correct = false; 
    if (checkDebugButt.isPressed()) {
        checked = true;    
    }
    
    //touchUpButtons (touch); 

}

//--------------------------------------------------------------
void whaleSong::touchDoubleTap(ofTouchEventArgs &touch){
    

    
    checked = true; 
    
    if (touch.x < ofGetWidth()/2) {
        
        correct = true; 
        
        cout << "DOUBLE TAP LEFT" << endl;
        
    }  else {
        correct = false; 
        cout << "DOUBLE TAP RIGHT" << endl; 
    }
}

//--------------------------------------------------------------
void whaleSong::lostFocus(){
    
}

//--------------------------------------------------------------
void whaleSong::gotFocus(){
    
}

//--------------------------------------------------------------
void whaleSong::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void whaleSong::deviceOrientationChanged(int newOrientation){
    
}

//--------------------------------------------------------------
void whaleSong::touchCancelled(ofTouchEventArgs& args){
	
}

//--------------------------------------------------------------
void whaleSong::loadSong(string XMLname) {
    ofxXmlSettings gotSongs;
    ofxXmlSettings songList; 
    
    songPhrase tempSong; 
    
    if(songList.loadFile(ofxiPhoneGetDocumentsDirectory() + XMLname)){
        //cout <<  XMLname <<  " loaded from documents folder!" << endl; 
    } else if (songList.loadFile(XMLname)){
        //cout << XMLname << " loaded from data folder!" << endl; 
    } else {
        //cout << "unable to load " << XMLname << endl; 
    }
    
    
        songList.pushTag("songList");
        numberOfSongs = songList.getNumTags("songs");
        
        for(int i = 0; i < numberOfSongs; i++){

            int songID = songList.getAttribute("songs", "song",0, i);

            string songWords = songList.getAttribute("songs", "words", "nothing",i);
            tempSong.songNum = songID; 
            tempSong.songWords = songWords; 
            
            songList.pushTag("songs",i);
            
            
            int numberOfSavedPoints = songList.getNumTags("pos");
            for(int j = 0; j < numberOfSavedPoints; j++){
                
                int savedBin;
                savedBin = songList.getValue("pos", 0,j);

                tempSong.savedBins.push_back(savedBin);
                
            }
            
            songs.push_back(tempSong);
            songList.popTag(); 
            tempSong.savedBins.clear(); 
            
            
        }
        songList.popTag(); //pop songlist    
    

    
}


//--------------------------------------------------------------
bool whaleSong::checkSong() {
    
    int points = 0; 
    
    //lets do something that sees which one is shorter
    int longer = 0; 
    
    if (songs[whichSong].savedBins.size() > theBins.size()) {
        longer = songs[whichSong].savedBins.size();
    } else {
        longer = theBins.size(); 
    }
    
    //compare against the longer one 
    for (int i = 0; i < longer-1; i++) {
        
        if (songs[whichSong].savedBins[i] < (theBins[i] + threshold) && songs[whichSong].savedBins[i] > (theBins[i] - threshold)) {
            points ++; 
        }        
    }
    if (points > songs[whichSong].savedBins.size() - songs[whichSong].savedBins.size()/3) return true; 
}


//-------------------------------------------------------------
void whaleSong::setSong(int whichSong_){
    
    whichSong = whichSong_; 
    
    for (int i = 0; i < songs[whichSong].savedBins.size()-1; i++){
        guide.letsGo(i, songs[whichSong].savedBins[i]);

    }
}

//-------------------------------------------------------------
void whaleSong::letsReset() {
    for (int i = 0; i < sampleSize-1; i++){
    guide.letsReset(i);
    }
}

//--------------------------------------------------------------
void whaleSong::setupButtons() {
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
    
    checkButt.setup(); 
    checkButt.setColor(ofColor(232, 58, 37));
    checkButt.setLabel("check Song", &whitneySemiBold22);
    
    correctButt.setup(); 
    correctButt.setColor(ofColor(232, 58, 37));
    correctButt.setLabel("correct", &whitneySemiBold22);
    
    tryAgainButt.setup(); 
    tryAgainButt.setColor(ofColor(232, 58, 37));
    tryAgainButt.setLabel("try again", &whitneySemiBold22);
    
    checkDebugButt.setup(); 
    checkDebugButt.setColor(ofColor(232, 58, 37));
    checkDebugButt.setLabel("check debug", &whitneySemiBold22);
}


//-----------------------------------------------------------------

void whaleSong::drawButtons() {
    if (showGrid) beginButt.draw( 10, 10); 
    skeletonButt.draw(10, 50); 
    resetButt.draw(10, 90);
    checkButt.draw(200, 90);
    correctButt.draw(200, 10); 
    tryAgainButt.draw(200,50); 
    checkDebugButt.draw(200,90); 
}

//-----------------------------------------------------------------

void whaleSong::touchDownButtons(ofTouchEventArgs &touch){
    beginButt.touchDown(touch);
    skeletonButt.touchDown(touch);
    resetButt.touchDown(touch);
    checkButt.touchDown(touch);
    tryAgainButt.touchDown(touch);
    correctButt.touchDown(touch);
    checkDebugButt.touchDown(touch);
}
//-----------------------------------------------------------------

void whaleSong::touchUpButtons(ofTouchEventArgs &touch){
    beginButt.touchUp(touch);
    skeletonButt.touchUp(touch);
    resetButt.touchUp(touch);
    checkButt.touchUp(touch);
    correctButt.touchUp(touch);
    tryAgainButt.touchUp(touch);
    checkDebugButt.touchUp(touch);
}
