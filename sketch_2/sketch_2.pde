import oscP5.*;

OscP5 oscP5;
float eegValue = 0;

/* visual by Peter Hofmann for testing */
float resolution = 260; // how many points in the circle
float rad = 150;
float x = 1;
float y = 1;

float t = 0; // time passed
float tChange = .02; // how quick time flies

float nVal; // noise value
float nInt = 1; // noise intensity
float nAmp = 1; // noise amplitude

void setup() {
  size(400,400);
  frameRate(25);
  noiseDetail(8);
   
  /* create a new instance of oscP5. 
   * 5000 is the port number you are listening for incoming osc messages.
   */
  oscP5 = new OscP5(this,5000);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  
  nInt = map(eegValue, 0, width, 0.1, 30); // map mouseX to noise intensity
  nAmp = map(eegValue, 0, height, 0.0, 1.0); // map mouseY to noise amplitude

  beginShape();
  for (float a=0; a<=TWO_PI; a+=TWO_PI/resolution) {

    nVal = map(noise( cos(a)*nInt+1, sin(a)*nInt+1, t ), 0.0, 1.0, nAmp, 1.0); // map noise value to match the amplitude

    x = cos(a)*rad *nVal;
    y = sin(a)*rad *nVal;

    //    x = map(a, 0,TWO_PI, 0,width);
    //    y = sin(a)*rad *nVal +height/2;

//    vertex(prevX, prevY);
    vertex(x, y);

    //    line(x,y,x,height);

//    prevX = x;
//    prevY = y;
    
    }
  endShape(CLOSE);

  t += tChange;
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage msg) {
  System.out.println("### got a message " + msg);
    if (msg.checkAddrPattern("/muse/eeg")==true) {
      for(int i = 0; i < 4; i++) {
        System.out.print("EEG on channel " + i + ": " + msg.get(i).floatValue() + "\n");
        //change global value of eegValue
        eegValue = msg.get(i).floatValue();
      }
    }
}