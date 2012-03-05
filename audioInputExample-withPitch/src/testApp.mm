#include "testApp.h"
#include "math.h"
#include <stdlib.h>

//--------------------------------------------------------------
void testApp::setup(){

	// IMPORTANT!!! if your sound doesn't work in the simulator - read this post - which requires you set the input stream to 24bit!!
	//	http://www.cocos2d-iphone.org/forum/topic/4159

	// register touch events
	ofRegisterTouchEvents(this);
	
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);

	ofBackground(0,0,0);
    
    /*

	//for some reason on the iphone simulator 256 doesn't work - it comes in as 512!
	//so we do 512 - otherwise we crash
	initialBufferSize	= 512;
	sampleRate 			= 44100;
	drawCounter			= 0;
	bufferCounter		= 0;
	
	buffer				= new float[initialBufferSize];
	memset(buffer, 0, initialBufferSize * sizeof(float));

	// 0 output channels,
	// 1 input channels
	// 44100 samples per second
	// 512 samples per buffer
	// 4 num buffers (latency)
	ofSoundStreamSetup(0, 1, this, sampleRate, initialBufferSize, 4);
	ofSetFrameRate(60);
     
     */
    initialBufferSize	= 128;
    ofSoundStreamSetup(0,1,this,44100,128,4);
    //added buffer
    buffer = new float[128];
    memset(buffer, 0, 128 * sizeof(float));

    amplitude = new float[88];
    
    BP = new float[128];
    BPin1 = new float[89];
    BPin2 = new float[89];
    BPout1 = new float[89];
    BPout2 = new float[89];
    bandw = 0.01;
}

//--------------------------------------------------------------
void testApp::update(){

}

//--------------------------------------------------------------
void testApp::draw(){

    
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
     
    
    ofSetColor(255,255,255);
    ofSetLineWidth(3);
    for(int i = 0; i < 89; i++)
        ofCircle(i*10,50+ amplitude[i], 4);
        //ofLine(50+i*10,590,50+i*10,590-amplitude[i]*20);
    /*
    ofSetLineWidth(1);
    ofSetColor(255,255,255);
    ofRect(45,600,880,130);
    ofSetColor(0,0,0);
    for(int i = 0; i < 88; i++){
        ofLine(45+i*10,730,45+i*10,600);
        if((i+6) % 12 == 3 || (i+6) % 12 == 5 || (i+6) % 12 == 7 || (i+6) % 12 == 10 || (i+6) % 12 == 0 )
            ofRect(45+i*10,600,10,90);
    }
     
    
    
    ofSetColor(255,0,0);
	char reportString[255];
	sprintf(reportString, "Bandwidth : %f\n",bandw);
	ofDrawBitmapString(reportString,80,100);
     */

}

//--------------------------------------------------------------
void testApp::audioIn(float * input, int bufferSize, int nChannels){
			
    
	if( initialBufferSize != bufferSize ){
		ofLog(OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize);
		return;
	}	
	
	// samples are "interleaved"
	for (int i = 0; i < bufferSize; i++){
		buffer[i] = input[i];
	}
	bufferCounter++;
     
    
    float notefreq[88] =
    {
        27.50f,    29.14f,    30.87f,
        32.70f,   34.65f,   36.71f,   38.89f,    41.20f,    43.65f,    46.25f,    49.00f,    51.91f,    55.00f,    58.27f,    61.74f,
        65.41f,   69.30f,   73.42f,   77.78f,    82.41f,    87.31f,    92.50f,    98.00f,   103.83f,   110.00f,   116.54f,   123.47f,
        130.81f,  138.59f,  146.83f,  155.56f,   164.81f,   174.61f,   185.00f,   196.00f,   207.65f,   220.00f,   233.08f,   246.94f,
        261.63f,  277.18f,  293.66f,  311.13f,   329.63f,   349.23f,   369.99f,   392.00f,   415.30f,   440.00f,   466.16f,   493.88f,
        523.25f,  554.37f,  587.33f,  622.25f,   659.26f,   698.46f,   739.99f,   783.99f,   830.61f,   880.00f,   932.33f,   987.77f,
        1046.50f, 1108.73f, 1174.66f, 1244.51f,  1318.51f,  1396.91f,  1479.98f,  1567.98f,  1661.22f,  1760.00f,  1864.66f,  1975.53f,
        2093.00f, 2217.46f, 2349.32f, 2489.02f,  2637.02f,  2793.83f,  2959.96f,  3135.96f,  3322.44f,  3520.00f,  3729.31f,  3951.07f,
        4186.01f
    };
    
    for(int i = 0; i < 89;i++){
        amplitude[i] *= 0.95;
        //BandPass(left,BP,bandw,notefreq[i],i);
        BandPass(buffer,BP,bandw,notefreq[i],i);
        for(int j = 0; j < 128; j++){
            if(BP[j] > 0.0)
                amplitude[i] += BP[j];
            if(BP[i] < 0.0)
                amplitude[i] += BP[j]*-1;
            BP[j] = 0.0;
        }
    }
}

//--------------------------------------------------------------
void testApp::BandPass(float *in, float * out,float width, float freq, int note){
    float BW = width;
    float c,a0,a1,a2,a3,b0,b1,b2,w0,f,alpha;
    f = freq;
    w0 = 2*PI*f/44100;
    alpha= sin(w0)*sinh( log(2)/2 * BW * w0/sin(w0) );
    
    b0 =   alpha;
    b1 =   0;
    b2 =  -alpha;
    a0 =   1 + alpha;
    a1 =  -2*cos(w0);
    a2 =   1 - alpha;
    
    for(int i = 0; i < 128; i++){
        
        out[i] =((b0/a0)*in[i] + (b1/a0)*BPin1[note] + (b2/a0)*BPin2[note] - (a1/a0)*BPout1[note] - (a2/a0)*BPout2[note]);
        
        
        BPin2[note] = BPin1[note];
        BPin1[note] = in[i];
        BPout2[note] = BPout1[note];
        BPout1[note] = out[i];
        
    }
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
void testApp::touchCancelled(ofTouchEventArgs& args){

}

