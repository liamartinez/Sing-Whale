

#include "whaleSong.h"

//-------------------------------------------------------------
whaleSong::whaleSong() {

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

    //ofAddListener(ofEvents.audioReceived,this,&whaleSong::audioReceived);  
    
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
    
    loadButt.setup(); 
    loadButt.setColor(ofColor(232, 58, 37));
    loadButt.setLabel("load", &whitneySemiBold22);
    
    checkButt.setup(); 
    checkButt.setColor(ofColor(232, 58, 37));
    checkButt.setLabel("check", &whitneySemiBold22);
    
    nextButt.setup(); 
    nextButt.setColor(ofColor(232, 58, 37));
    nextButt.setLabel("next", &whitneySemiBold22);
    
    loadMe = false;
    checkMe = false; 
    reset   = false; 
    message = "FIRST LOAD, THEN START, THEN CHECK!"; 
    
    whichSong = 0; 
    
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
        
        
        if (theBin != 0) {
            theBin = ofMap(theBin, 30, 50, 30, 100);
            if (theBins.size() < sampleSize) theBins.push_back(theBin);
        }
        
    }
    grid.update(); 
    guide.update(); 
}

//--------------------------------------------------------------
void whaleSong::draw(){
    
    
    //buttons
    beginButt.draw( 10, 10); 
    skeletonButt.draw(10, 50); 
    resetButt.draw(10, 90);
    saveButt.draw(200, 10);
    loadButt.draw(200, 50);
    checkButt.draw(200, 90);
    nextButt.draw(200, 130); 
    
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
            //attractors
            //grid.attractReset(); 
            //set location to reset also
            grid.letsReset(i); 
            theBins.clear(); 
            //grid.clearGrid(); 
            //grid.setupGrid(); //need to destroy old grid? 
        }
    }
    /* //removing because it should only happen when set
    if (loadMe) {
        loadMe = false; 
        
        for (int i = 0; i < songs[whichSong].savedBins.size()-1; i++){
            guide.letsGo(i, songs[whichSong].savedBins[i]);
            cout << "NUMBER " << songs[whichSong].songNum << endl; 
            cout << "WHALE SAYS " << songs[whichSong].songWords << endl; 
        }
        
    }
    */
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
void whaleSong::exit(){
    
}
//--------------------------------------------------------------

void whaleSong::audioRequested 	(float * output, int bufferSize, int nChannels){
    
}


//--------------------------------------------------------------
void whaleSong::audioReceived 	(float * input, int bufferSize, int nChannels){	
    
    cout << "AUDIOOO" << endl; 
    
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

/*//old method
void whaleSong::audioReceived(ofAudioEventArgs &audio){  
    
    if( initialBufferSize != audio.bufferSize ){
		ofLog(OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, audio.bufferSize);
		return;
	}	
	
	// samples are "interleaved"
	for (int i = 0; i < audio.bufferSize; i++){
		buffer[i] = audio.buffer[i];
        
        
        
        if (mfft.process(audio.buffer[i])) {  
            mfft.magsToDB(); // calculate all the DBs  
            oct.calculate(mfft.magnitudesDB); // this will store the DBs of each octave range  
        }  
    }
	bufferCounter++; //lia:what is bufferCounter for?
    

}
*/
//--------------------------------------------------------------
void whaleSong::touchDown(ofTouchEventArgs &touch){
    beginButt.touchDown(touch);
    skeletonButt.touchDown(touch);
    resetButt.touchDown(touch);
    loadButt.touchDown(touch);
    checkButt.touchDown(touch);
    nextButt.touchDown(touch);
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

    if (loadButt.isPressed()) {
        loadSong(); 
    }
    
    if (checkButt.isPressed()) {
        checkMe = true; 
    }
    
    if (nextButt.isPressed()) {
        
        if (whichSong <3) {
            whichSong ++ ;            
        } else {
            whichSong = 0; 
        }
    }
    
    
    beginButt.touchUp(touch);
    skeletonButt.touchUp(touch);
    resetButt.touchUp(touch);
    loadButt.touchUp(touch);
    checkButt.touchUp(touch);
    nextButt.touchUp(touch);
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
void whaleSong::loadSong() {
    ofxXmlSettings gotSongs;
    ofxXmlSettings songList; 
    
    songPhrase tempSong; 
    
    if(songList.loadFile(ofxiPhoneGetDocumentsDirectory() + "positions.xml")){
        songList.pushTag("songList");
        numberOfSongs = songList.getNumTags("songs");
        
        for(int i = 0; i < numberOfSongs; i++){

            int songID = songList.getAttribute("songs", "song",0, i);
            
            cout << "SONG ID" <<songID << endl; 
            string songWords = songList.getAttribute("songs", "words", "nothing",i);
            cout << songWords << endl; 
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
        loadMe = true; 
    }
    else{
        ofLogError("Position file did not load!");
    }
    
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
        cout << "NUMBER " << songs[whichSong].songNum << endl; 
        cout << "WHALE SAYS " << songs[whichSong].songWords << endl; 
    }
}

void whaleSong::letsReset() {
    for (int i = 0; i < sampleSize-1; i++){
    guide.letsReset(i);
    }
}




