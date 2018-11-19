import oscP5.*;
import netP5.*;

OscP5 oscP5;
/* create a new OscMessage with an address pattern, in this case /muse/acc */
OscMessage myOscMessage = new OscMessage("/muse/acc");
/* a NetAddress contains the ip address and port number of a remote location in the network. */
NetAddress myBroadcastLocation;

void setup() {
  size(400,400);
  frameRate(25);
   
  /* create a new instance of oscP5.  //<>//
   * 5000 is the port number you are listening for incoming osc messages.
   */
  oscP5 = new OscP5(this,5000);
  
  /* create a new NetAddress. a NetAddress is used when sending osc messages
   * with the oscP5.send method.
   */
  
  /* the address of the osc broadcast server */
  myBroadcastLocation = new NetAddress("127.0.0.1",32000);
}

void mousePressed() {
  /* add a value (an integer) to the OscMessage 
  myOscMessage.add(100); */
  /* send the OscMessage to a remote location specified in myNetAddress 
  oscP5.send(myOscMessage, myBroadcastLocation);*/
}


void keyPressed() {
  OscMessage m;
  switch(key) {
    case('c'):
      /* connect to the broadcaster */
      m = new OscMessage("/server/connect",new Object[0]);
      oscP5.flush(m,myBroadcastLocation);  
      break;
    case('d'):
      /* disconnect from the broadcaster */
      m = new OscMessage("/server/disconnect",new Object[0]);
      oscP5.flush(m,myBroadcastLocation);  
      break;
  }  
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage msg) {
  /* get and print the address pattern and the typetag of the received OscMessage */
  //println("### received an osc message with addrpattern "+msg.addrPattern()+" and typetag "+msg.typetag());
  msg.print();
}