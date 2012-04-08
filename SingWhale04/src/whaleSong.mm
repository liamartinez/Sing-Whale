

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
	
	fftSize = 1024;
	mfft.setup(fftSize, 1024, 256);
	
	nAverages = 2; //how fine do we want our analyzer
	oct.setup(sampleRate, fftSize/2, nAverages);
	
	ofxMaxiSettings::setup(sampleRate, 2, initialBufferSize);
    
	/*ofSoundStreamSetup(0,1, this, sampleRate, initialBufferSize, 4); */
     /* Call this last ! */

    ofAddListener(ofEvents.audioReceived,this,&whaleSong::audioReceivedIn);  
    
    //smoothing
    index = 0; 
    total = 0; 
    average = 0; 
    for (int i = 0; i < 10; i ++) {
        readings[i] = 0; 
    }
    
    //interface
    whitneySemiBold22.loadFont("fonts/Whitney-Semibold.otf",22);
    
    setupButtons(); 

    //button parade    
    checkMe = false; 
    reset   = false; 
    correct = false; 
    checked = false; 
    message = "TEMPORARY DEBUG CONTROLS"; 
    
    whichSong = 0; 
    
    //dorwings
    ofVec2f startSingingLoc; 
    startSingingLoc.set(0, 0);
    
    ofVec2f startGuideLoc; 
    startGuideLoc.set(0, 0);
    
    songLoc.set(0, ofGetHeight());
    songHeight = 100; 
    
    singing.setup(startSingingLoc); 
    guide.setup(startGuideLoc); 

}

//--------------------------------------------------------------
void whaleSong::update(){
    
    singing.update(); 
    guide.update();
    
    //octave analyser
    float xinc = 900.0 / fftSize * 2.0;
    highest = 0; 
    
	xinc = 500 / oct.nAverages;
    if (begin) {
        for(int i=0; i < oct.nAverages; i++) {
            float height = oct.averages[i] / 50.0 * 100;
            
            if (i%5 == 0) {  
                if (height > highest) {
                    highest = height; 
                    if (highest > 20) {
                        theBin = i*20;  
                    } else {
                        theBin = 0; 
                    }
                }
            }
        }
        
        //clamp and map
        theBin = ofClamp(theBin, 30, 120);
        theBin = ofMap(theBin, 30, 120, 0, 200);
        
        //average
        total = total - readings[index]; 
        readings[index] = theBin; 
        total = total + readings[index]; 
        index ++; 
        
        if (index >= NUMREADINGS) index = 0; 
        average = total/NUMREADINGS; 
        
        if (theBins.size() < SAMPLESIZE) theBins.push_back(average);
        singing.letsGo(theBins.size(), average); 
        
    }
    if (reset) {
        reset = false; 
        begin = false; 
        for (int i = 0; i < SAMPLESIZE-1; i++){
            singing.reset();  
            theBins.clear(); 
        }
    }
    
    /*
    if (loadMe) {
        loadMe = false; 
        
        for (int i = 0; i < songs[whichSong].savedBins.size()-1; i++){
            guide.letsGo(i, songs[whichSong].savedBins[i]);
            cout << "i " << i << endl; 
            cout << "NUMBER " << songs[whichSong].songNum << endl; 
            cout << "WHALE SAYS " << songs[whichSong].songWords << endl; 
        }
        
    }
     */
    
    if (checkMe) {
        checkMe = false; 
        if (checkSong()) {
            message = "YOU GOT IT";
        } else {
            message = "TRY AGAIN";
        }
    }

}

//--------------------------------------------------------------
void whaleSong::draw(){
    
    
    //buttons
    drawButtons(); 
        
    ofSetColor(225);
    
    ofPushMatrix(); 
        ofTranslate(0, songLoc.y); //start with being hidden
        ofEnableAlphaBlending(); 
    
        ofSetColor(0, 120, 190, 100);
        guide.setWriggleOn(true);
        guide.draw(); 
    
        ofSetColor(0, 90, 170, 100);
        singing.setWriggleOn(true);
        singing.draw(); 
    
        ofDisableAlphaBlending(); 
    ofPopMatrix();

    
    ofSetColor(232, 58, 37);
    ofDrawBitmapString(message, 300, 50);
}
//--------------------------------------------------------------
void whaleSong::exit(){
    
}
//--------------------------------------------------------------

void whaleSong::audioRequested 	(float * output, int bufferSize, int nChannels){
    
}

//--------------------------------------------------------------

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
    singing.touchDown(touch);
    guide.touchDown(touch);
    touchDownButtons(touch);
}

//--------------------------------------------------------------
void whaleSong::touchMoved(ofTouchEventArgs &touch){
    singing.touchMoved(touch);
    guide.touchMoved(touch);
}

//--------------------------------------------------------------
void whaleSong::touchUp(ofTouchEventArgs &touch){
    
    if (beginButt.isPressed()) begin = !begin; 
    if (resetButt.isPressed()) reset = true; 
    
    if (skeletonButt.isPressed()) {
        //show the faint outline thing
    }
    
    if (checkButt.isPressed()) checkMe = true; 
    
    if (correctButt.isPressed()) correct = true; 
    if (tryAgainButt.isPressed()) correct = false; 
    if (checkDebugButt.isPressed()) {
        checked = true;    
    }
    
    touchUpButtons (touch); 

}

//--------------------------------------------------------------
void whaleSong::touchDoubleTap(ofTouchEventArgs &touch){

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
        
        if (songs[whichSong].savedBins[i] < (theBins[i] + THRESHOLD) && songs[whichSong].savedBins[i] > (theBins[i] - THRESHOLD)) {
            points ++; 
        }        
    }
    if (points > songs[whichSong].savedBins.size() - songs[whichSong].savedBins.size()/3) return true; 
}


//-------------------------------------------------------------
void whaleSong::setSong(int whichSong_){
    
    guide.reset();
    songLoc.y = ofGetHeight() + 50; 
    
    whichSong = whichSong_; 
    
    Tweenzor::add (songLoc.y, songLoc.y, songLoc.y - songHeight,   0, 30, EASE_OUT_QUAD); 
    
    for (int i = 0; i < songs[whichSong].savedBins.size()-1; i++){
        guide.letsGo(i, songs[whichSong].savedBins[i]);

    }
}

//-------------------------------------------------------------
void whaleSong::letsReset() {
    for (int i = 0; i < SAMPLESIZE-1; i++){
    guide.reset();
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
    beginButt.draw( 10, 10); 
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
