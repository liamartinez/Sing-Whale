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
    
    //around 4 seconds to match layla
    ofSetFrameRate(16);
	
	ofBackground(150,150,127);
    
    TTF.loadFont("mono.ttf", 7);
    
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
    
	ofSoundStreamSetup(0,1, this, sampleRate, initialBufferSize, 4);/* Call this last ! */
    
    //keyboard
    keyboard = new ofxiPhoneKeyboard(0,52,320,32);
	keyboard->setVisible(true);
	keyboard->setBgColor(255, 255, 255, 255);
	keyboard->setFontColor(0,0,0, 255);
	keyboard->setFontSize(26);

    //interface
    whitneySemiBold22.loadFont("fonts/Whitney-Semibold.otf",22);
    
    //button parade
    begin = false; 
    loadMe = false;
    checkMe = false; 
    reset   = false; 

    setupButtons(); 

    //smoothing
    index = 0; 
    total = 0; 
    average = 0; 
    for (int i = 0; i < 10; i ++) {
        readings[i] = 0; 
    }
    
    numSong = 1; //for saving
    whichSong = 0; 
    
    //dorwings
    ofVec2f startSingingLoc; 
    startSingingLoc.set(0, ofGetHeight()/2);
    
    ofVec2f startGuideLoc; 
    startGuideLoc.set(0, ofGetHeight()/2);
    
    singing.setup(startSingingLoc); 
    guide.setup(startGuideLoc); 

    

}

//--------------------------------------------------------------
void testApp::update(){
    
    singing.update(); 
    guide.update();
    
    float xinc = 900.0 / fftSize * 2.0;
    
    //octave analyser
    highest = 0; 
    
	xinc = 500 / oct.nAverages;
    if (begin) {
        for(int i=0; i < oct.nAverages; i ++) {
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
        theBin = ofMap(theBin, 30, 120, 0, 150);

        //average
        total = total - readings[index]; 
        readings[index] = theBin; 
        total = total + readings[index]; 
        index ++; 
        
        if (index >= NUMREADINGS) index = 0; 
        average = total/NUMREADINGS; 
        
        if (theBins.size() < SAMPLESIZE) theBins.push_back(average);
        singing.letsGo(theBins.size(), average); 

        
        if (theBins.size() == SAMPLESIZE -1) begin = false; 

    }
    if (reset) {
        reset = false; 
        begin = false; 
        for (int i = 0; i < SAMPLESIZE-1; i++){
            guide.reset();
            singing.reset();  
            theBins.clear(); 
        }
    }
    
    if (loadMe) {
        loadMe = false; 
        
        for (int i = 0; i < songs[whichSong].savedBins.size()-1; i++){
            guide.letsGo(i, songs[whichSong].savedBins[i]);
            cout << "i " << i << endl; 
            cout << "NUMBER " << songs[whichSong].songNum << endl; 
            cout << "WHALE SAYS " << songs[whichSong].songWords << endl; 
        }
        
    }
    
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
void testApp::draw(){
    drawButtons(); 
    
    
    ofPushMatrix(); 
    //ofTranslate(0, ofGetHeight()/2 - 100);
    ofEnableAlphaBlending(); 

        ofSetColor(0, 120, 190, 100);
        //guide.setWriggleOn(true);
        guide.draw(); 
    
        ofSetColor(0, 90, 170, 100);
        //singing.setWriggleOn(true);
        singing.draw(); 

    ofDisableAlphaBlending(); 
    ofPopMatrix();
    
    
    ofSetColor(232, 58, 37);
    ofDrawBitmapString(message, 300, 50);
    
    //keyboard
    ofSetColor( 255);
	ofDrawBitmapString("tap the textfield to open the keyboard", 500, 100);
    
	ofDrawBitmapString("whale song number = "+  keyboard->getText() , 500, 130);
    
    numSong = ofToInt(keyboard->getText()); 
    
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
   
    singing.touchDown(touch);
    guide.touchDown(touch);
     touchDownButtons(touch);
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    singing.touchMoved(touch);
    guide.touchMoved(touch);
    
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){

    if (beginButt.isPressed()) begin = !begin; 
    if (resetButt.isPressed()) reset = true; 
    
    if (skeletonButt.isPressed()) {
        //show the faint outline thing
    }
        
    if (saveButt.isPressed()) {
        numSong = ofToInt(keyboard->getText());
        saveSong(numSong); 
    }
    
    if (loadButt.isPressed()) {
        loadSong(numSong); 
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

    touchUpButtons(touch);
    singing.touchUp(touch);
    guide.touchUp(touch);
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    singing.touchDoubleTap(touch);
    
    if(!keyboard->isKeyboardShowing()){
        keyboard->openKeyboard();
        keyboard->setVisible(true);
    } else{
        keyboard->setVisible(false);
    }	
 
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
    
    for (int i = 0; i < SAMPLESIZE; i++) {
        if (i < theBins.size()) {
            positions.addValue("pos", theBins[i]);   
            //int tempPos = singing.songPoints[i].pos.y; 
            //positions.addValue("pos", tempPos);
        } else {
            positions.addValue("pos", 20); //fill the rest with 0's. 
        }
        
    }
    
    positions.popTag(); //pop position
    positions.popTag(); 
    positions.saveFile(ofxiPhoneGetDocumentsDirectory() + ofToString(numSong_) + ".xml");
    cout << ofToString(numSong_) + ".xml saved to app documents folder" << endl; 
}

//--------------------------------------------------------------
void testApp::loadSong(int numSong_) {
    ofxXmlSettings gotSongs;
    ofxXmlSettings songList; 
    
    song tempSong; 
    
    if(songList.loadFile(ofxiPhoneGetDocumentsDirectory() + ofToString(numSong_) + ".xml")){
        
        songList.pushTag("songList");
        cout << "PUSH INTO SONGLIST " << endl; 
        numberOfSongs = songList.getNumTags("songs");
        cout << "FOUND NUMBER OF SONGS " << numberOfSongs << endl; 
        
        for(int i = 0; i < numberOfSongs; i++){
            
            cout << "IN SONG LOOP " << i << endl; 
            int songID = songList.getAttribute("songs", "song",0, i);
            
            cout << songID << endl; 
            string songWords = songList.getAttribute("songs", "words", "nothing",i);
            cout << songWords << endl; 
            tempSong.songNum = songID; 
            tempSong.songWords = songWords; 
            
            songList.pushTag("songs",i);
            
            
            int numberOfSavedPoints = songList.getNumTags("pos");
            for(int j = 0; j < numberOfSavedPoints; j++){
                
                int savedBin;
                savedBin = songList.getValue("pos", 0,j);
                cout << "IN POS LOOP " << j << savedBin << endl; 
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
bool testApp::checkSong() {
    
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


//--------------------------------------------------------------
void testApp::setupButtons(){
    beginButt.setup(); 
    beginButt.setColor(ofColor(232, 58, 37));
    beginButt.setLabel("start/ stop", &whitneySemiBold22);
    
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
    
}
//--------------------------------------------------------------
void testApp::drawButtons(){
    beginButt.draw( 10, 10); 
    resetButt.draw(10, 50);
    skeletonButt.draw(10, 90); 
    saveButt.draw(200, 10);
    loadButt.draw(200, 50);
    checkButt.draw(200, 90);
    nextButt.draw(200, 130); 
}
//--------------------------------------------------------------
void testApp::touchUpButtons(ofTouchEventArgs &touch) {
    beginButt.touchUp(touch);
    skeletonButt.touchUp(touch);
    resetButt.touchUp(touch);
    saveButt.touchUp(touch);
    loadButt.touchUp(touch);
    checkButt.touchUp(touch);
    nextButt.touchUp(touch);
    
    singing.touchUp(touch);
    guide.touchUp(touch); 
    
}
//--------------------------------------------------------------
void testApp::touchDownButtons(ofTouchEventArgs &touch){
    beginButt.touchDown(touch);
    skeletonButt.touchDown(touch);
    resetButt.touchDown(touch);
    saveButt.touchDown(touch);
    loadButt.touchDown(touch);
    checkButt.touchDown(touch);
    nextButt.touchDown(touch); 
    
    singing.touchDown(touch);
    guide.touchDown(touch);
    
    
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

