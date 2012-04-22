#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
    
    // register touch events
	ofxRegisterMultitouch(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	
	//If you want a landscape oreintation 
	iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	//ofBackground(127,127,127);
    
    
    //Load Assets
    swAssets = swAssetManager::getInstance();
    
    ofSoundStreamSetup(0,1, this, 44100, 512, 4);/* Call this last ! */

    if(swAssets->loadData()) {
        swAssets->loadFonts();
        
        //setup scene manager/Scenes
        swSM = swSceneManager::getInstance();
        
        scenes[SCENE_HOME]      = new homeScene();
        scenes[SCENE_CALL]      = new callScene();
        scenes[SCENE_CALL_NAME] = new callSceneName();
        scenes[SCENE_SPEAK]     = new speakScene();
        
        
        try {
            for(int i=0; i<SW_TOTAL_SCENES; i++) {
                scenes[i]->setup();
            }
        } catch(string error) {
            cout << "View not intitialized! Please make sure every scene is created above!" << endl;
        }
    } else {
        cout << "Could not load the data!" << endl;
    }

    
    
    //test.loadSound ("sounds/1.caf");
    //initialize the listener
    //listener *listen =new listener(this); 
    //counterVariable = 10; 
    
    Tweenzor::init(); 

}

//--------------------------------------------------------------
void testApp::update(){
    
    Tweenzor::update(ofGetElapsedTimeMillis()); 

    if(swSM->getCurSceneChanged()) {
        for(int i=0; i<SW_TOTAL_SCENES; i++) {
            scenes[i]->deactivate();
        }
        
        scenes[swSM->getCurScene()]->activate();
    }
    
    scenes[swSM->getCurScene()]->update();

     

}

//--------------------------------------------------------------
void testApp::draw(){
    
    if(!swSM->getCurSceneChanged(false)) {
        scenes[swSM->getCurScene()]->draw();
    }
         
}

//--------------------------------------------------------------
void testApp::exit(){

}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
    
    scenes[swSM->getCurScene()]->touchDown(touch);

     
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){
    
    scenes[swSM->getCurScene()]->touchMoved(touch);

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){
    
    scenes[swSM->getCurScene()]->touchUp(touch);

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){
    scenes[swSM->getCurScene()]->touchDoubleTap(touch);
    
    
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

//-------------------------------------------------------------

void testApp::audioReceived(float * input, int bufferSize, int nChannels) /* input method */
{ 
    ofAudioEventArgs args;
    args.buffer = input;
    args.bufferSize = bufferSize;
    args.nChannels = nChannels;
    ofNotifyEvent(ofEvents.audioReceived, args);

 // cout << "this happened?\n";
   

}  
