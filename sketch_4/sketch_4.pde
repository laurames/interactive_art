import oscP5.*;
  
// OSC PARAMETERS & PORTS
int recvPort = 5000;
OscP5 oscP5;

float prevY, eegValue, mappedValue;

void setup(){
  size(1000,500);
  background(255);
  
  // start oscP5, listening for incoming messages at recvPort
  oscP5 = new OscP5(this, recvPort);
  background(0);

  //frameRate(1); To plot the graph at 1 point per second 
  frameRate(30);
}

void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/muse/eeg")==true) {
    //eegValue = msg.get(0).floatValue();
    mappedValue = msg.get(0).floatValue();
    //eegValue = ( (msg.get(0).floatValue()-0)/(1600-0))*(200-0);
    //System.out.print( ((eegValue-0)/(1600-0))*(600-0) + "\n");
  }
}

int ofs =0;
int ofs_v =1;

void draw(){
  translate(0,-200);
  ofs+=ofs_v;
 if((ofs==offset) || (ofs==0))
  {
   ofs_v=0-ofs_v;
  }
  
  strokeWeight(6);
  drawLine(212+ofs,#DB028C,#FFAE34);
  drawLine(215+ofs,#FF6A7E,#FFFA6A);//color
  strokeWeight(1);
  drawLine(210+ofs,100,100);
  
  System.out.println(eegValue);
}

int step = 80;
float noiseScale = 0.02;
int offset = 300;


void drawLine(int y0, color to, color from){
 
fill(255,4);
  beginShape();
  curveVertex(-50,y0);
  //curveVertex(eegValue,y0);
  for (int i =0 ; i<width/step+3;i+=1){
     float noiseVal = noise(i*noiseScale*(y0*0.06), frameCount*noiseScale); 
     stroke(lerpColor(from,to,eegValue));
     curveVertex(i*step-10,y0+noiseVal*offset);
    
  }
 curveVertex(width+10, height+200);
 curveVertex(0, height+210);
 curveVertex(0, height+210);
 endShape();
  
}