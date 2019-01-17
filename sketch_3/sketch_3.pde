import oscP5.*;
  
// OSC PARAMETERS & PORTS
int recvPort = 5000;
OscP5 oscP5;

float prevY, eegValue;

void setup() {
  size(600, 200);

  /* start oscP5, listening for incoming messages at recvPort */
  oscP5 = new OscP5(this, recvPort);
  background(0);

  //frameRate(1); To plot the graph at 1 point per second 
  frameRate(30);
  drawStuff();
}

void draw() {
  //background(0);
  System.out.print(eegValue + "\n");
  stroke(255, 0, 0);
  line(frameCount-1, prevY, frameCount, eegValue);
  prevY = eegValue;
}
  
void drawStuff() {
  background(0);
  for (int i = 0; i <= width; i += 50) {
    fill(0, 255, 0);
    text(i/2, i-10, height-15);
    stroke(255);
    line(i, height, i, 0);
  }
  for (int j = 0; j < height; j += 33) {
    fill(0, 255, 0);
    text(6-j/(height/6), 0, j);
    stroke(255);
    line(0, j, width, j);
  }
}

void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/muse/eeg")==true) {
    eegValue = ( (msg.get(0).floatValue()-0)/(1600-0))*(200-0); //msg.get(0).floatValue();
    //System.out.print( ((eegValue-0)/(1600-0))*(600-0) + "\n");
  }
}