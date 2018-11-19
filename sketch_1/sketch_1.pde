import oscP5.*;
import netP5.*;

OscP5 oscP5;
float eegValue = 0;

void setup() {
  size(400,400);
  frameRate(25);
   
  /* create a new instance of oscP5. 
   * 5000 is the port number you are listening for incoming osc messages.
   */
  oscP5 = new OscP5(this,5000);
  
  /* create a new NetAddress. a NetAddress is used when sending osc messages
   * with the oscP5.send method.
   */
  
  /* the address of the osc broadcast server */
  //myBroadcastLocation = new NetAddress("127.0.0.1",32000);
}

void draw() {
  background(0);
  fill(255);
  ellipse(200, 200, eegValue/5, eegValue/5);
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
    //if (msg.checkAddrPattern("/muse/blink"))
}