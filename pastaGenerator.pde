import oscP5.*;
import netP5.*;

OscP5 oscP5;

float v_fader1 = 0.0f;
float v_fader2 = 0.0f;
float v_fader3 = 0.0f;
float v_fader4 = 0.0f;
float v_fader5 = 0.0f;

import controlP5.*;

ControlP5 cp5;

//ControlP5 Dropdownlist ---------------------------------

DropdownList dropdown;

int cnt = 0;

//ControlP5 Sliders      ---------------------------------

float sliderValue;
float stepSizeI;
float stepSizeJ;  
float radiusX;
float radiusY;
float coeff1;
float coeff2;
float coeff3;
float iTop; 
float jTop; 
float zSeparation;
float coeff4;

//Initialize all drawing bools ----------------------------

boolean drawCannelloni = false; 
boolean drawCasarecce = false; 
boolean drawFettucine = false; 
boolean drawFiocchiRigati = false; 
boolean drawFusilli = false; 
boolean drawRavioli = false; 
boolean drawSpaghetti = false; 
boolean drawSpaghettiMesh = false; 

  
//OSCP5 Events Call ----------------------------
  
void oscEvent(OscMessage theOscMessage) {

    String addr = theOscMessage.addrPattern();
    float  val  = theOscMessage.get(0).floatValue();
    
    if(addr.equals("/1/fader1"))        { v_fader1 = val; }
    else if(addr.equals("/1/fader2"))   { v_fader2 = val; }
    else if(addr.equals("/1/fader3"))   { v_fader3 = val; }
    else if(addr.equals("/1/fader3"))   { v_fader4 = val; }
    else if(addr.equals("/1/fader3"))   { v_fader5 = val; }
}

void setup() {
  size(1280,720,OPENGL);
  frameRate(30);
  oscP5 = new OscP5(this,8000);
  cp5 = new ControlP5(this);

  
  //ControlP5 Dropdownlist Setup ---------------------------------
  
  dropdown = cp5.addDropdownList("aDropdownList",70,70,200,200);
  customize(dropdown);
 
  
  //ControlP5 Sliders Setup      ---------------------------------
  
  smooth();
  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
 
  int x = 300;
  int y = 50;
  int w = 175;
  int sliderGap = 30;
  cp5.addSlider("zSeparation")
     .setPosition(x, y)
     .setWidth(w)
     .setRange(5, 60)
     .setValue(10);
     y+=sliderGap;

  cp5.addSlider("stepSizeI")
     .setPosition(x, y)
     .setWidth(w)
     .setRange(0.30, 1.30)
     .setValue(1);
     y+=sliderGap;
          
  cp5.addSlider("stepSizeJ")
     .setPosition(x, y)
     .setWidth(w)
     .setRange(1, 10)
     .setValue(9);
     y+=sliderGap;
   
   cp5.addSlider("radiusX")
      .setPosition(x, y)
      .setWidth(w)
      .setRange(50, 150);   
      y+=sliderGap;
          
   cp5.addSlider("radiusY")
      .setPosition(x, y)
      .setWidth(w)
      .setRange(50, 150);
       y+=sliderGap;     
          
   cp5.addSlider("coeff1")
      .setPosition(x, y)
      .setWidth(w)
      .setRange(0.01, 30)
      .setValue(3);   
      y+=sliderGap;    
          
   cp5.addSlider("coeff2")
      .setPosition(x, y)
      .setWidth(w)
      .setRange(0.01, 0.1);   
      y+=sliderGap;
      
    cp5.addSlider("coeff3")
       .setPosition(x, y)
       .setWidth(w)
       .setRange(0.01, 0.1);  
       y+=sliderGap;
       
    cp5.addSlider("coeff4")
       .setPosition(x, y)
       .setWidth(w)
       .setRange(1, 5);    
       y+=sliderGap;
       
    cp5.addSlider("iTop")
       .setPosition(x, y)
       .setWidth(w)
       .setRange(50, 200)
       .setValue(100);   
       y+=sliderGap;
       
    cp5.addSlider("jTop")
       .setPosition(x, y)
       .setWidth(w)
       .setRange(20, 100)
       .setValue(100); 
       y+=sliderGap; 
}

  //ControlP5 Dropdownlist Functions ---------------------------------

void customize(DropdownList ddl) {
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(30);
  ddl.setBarHeight(15);
  ddl.captionLabel().set("Pasta Generator Templates");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  
  ddl.addItem("Cannelloni",0);
  ddl.addItem("Casarecce",1);
  ddl.addItem("Fettucine",2);
  ddl.addItem("Fiocchi Rigati",3);
  ddl.addItem("Fusilli",4);
  ddl.addItem("Ravioli",5);
  ddl.addItem("Spaghetti",6);
  ddl.addItem("Spaghetti Mesh",7);
  
  cp5.setColorActive(0xa0090909);
  cp5.setColorBackground(0x20ffffff);
  cp5.setColorForeground(0xb0aaaaaa);
  cp5.setColorLabel(0xffffffff);
  cp5.setColorValue(0xffffffff);

}



void controlEvent(ControlEvent theEvent) {
  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println(theEvent.group().value()+" from "+theEvent.group());
    if(theEvent.group().name().equals("aDropdownList")){
      ListBoxItem selectedItem = dropdown.getItem((int)theEvent.value());
      
      if(selectedItem.getName().equals("Cannelloni")){
        println("item 0 clicked... do something here!");
        
         drawCasarecce = false; 
         drawFettucine = false; 
         drawFiocchiRigati = false; 
         drawFusilli = false; 
         drawRavioli = false; 
         drawSpaghetti = false;
         drawSpaghettiMesh = false; 
         drawCannelloni = true; 
        
          }
          
      else if(selectedItem.getName().equals("Casarecce")){
        println("item 1 clicked... do something here!");
        
         drawCannelloni = false;  
         drawFettucine = false; 
         drawFiocchiRigati = false; 
         drawFusilli = false; 
         drawRavioli = false; 
         drawSpaghetti = false;
         drawSpaghettiMesh = false; 
         drawCasarecce = true;
        
          }
          
      else if(selectedItem.getName().equals("Fettucine")){
        println("item 2 clicked... do something here!");
        
         drawCannelloni = false; 
         drawCasarecce = false; 
         drawFiocchiRigati = false; 
         drawFusilli = false; 
         drawRavioli = false; 
         drawSpaghetti = false;
         drawSpaghettiMesh = false; 
         drawFettucine = true; 
        
          }
          
      else if(selectedItem.getName().equals("Fiocchi Rigati")){
        println("item 3 clicked... do something here!");
        
         drawCasarecce = false;
         drawCannelloni = false;  
         drawFettucine = false; 
         drawFusilli = false; 
         drawRavioli = false; 
         drawSpaghetti = false;
         drawSpaghettiMesh = false; 
         drawFiocchiRigati = true;
         
          }
          
      else if(selectedItem.getName().equals("Fusilli")){
        println("item 4 clicked... do something here!");
        
         drawCasarecce = false;
         drawCannelloni = false;  
         drawFettucine = false; 
         drawFiocchiRigati = false;
         drawRavioli = false; 
         drawSpaghetti = false;
         drawSpaghettiMesh = false; 
         drawFusilli = true; 
        
          }
          
      else if(selectedItem.getName().equals("Ravioli")){
        println("item 5 clicked... do something here!");
        
         drawCasarecce = false;
         drawCannelloni = false;  
         drawFettucine = false; 
         drawFiocchiRigati = false;
         drawFusilli = false; 
         drawSpaghetti = false;
         drawSpaghettiMesh = false; 
         drawRavioli = true;
        
          }
       
 
      else if(selectedItem.getName().equals("Spaghetti")){
        println("Fusilli clicked... do something here!");
        
         drawCasarecce = false;
         drawCannelloni = false;  
         drawFettucine = false; 
         drawFiocchiRigati = false;
         drawFusilli = false; 
         drawRavioli = false;
         drawSpaghettiMesh = false; 
         drawSpaghetti = true;
           
      }
      
      else if(selectedItem.getName().equals("Spaghetti Mesh")){
        println("Fusilli clicked... do something here!");
        
         drawCasarecce = false;
         drawCannelloni = false;  
         drawFettucine = false; 
         drawFiocchiRigati = false;
         drawFusilli = false; 
         drawRavioli = false;
         drawSpaghetti = false;
         drawSpaghettiMesh = true; 
        
           
      }
    }
  } else if(theEvent.isController()) {
    println(theEvent.controller().value()+" from "+theEvent.controller()); 
  }
}  

void draw() {
  //background(255,200,200);
  background(160,195,188);  
 
  if(drawCannelloni){
    cannelloni();
  }
  
  if(drawCasarecce){
    casarecce();
  }
  
  if(drawFettucine){
    fettucine();
  }
  
  if(drawFiocchiRigati){
    fiocchiRigati();
  }
  
  if(drawFusilli){
    fusilli();
  }
  
  if(drawRavioli){
    ravioli();
  }
  
  if(drawSpaghetti){
    spaghetti();
  }
  
  if(drawSpaghettiMesh){
    spaghettiMesh();
  }
  
}


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void cannelloni(){
  
  int countVertex = 0;
  float x,y,z;
  
  pushMatrix();
  translate(width/2, height/2, -20);
  rotateX(v_fader1*6); 
  rotateY(v_fader2*6);
  rotateZ(v_fader3*6);
  beginShape();
  stroke(0);
  noFill();
    
//----------------------------------------------  
  
        
  for (float i=0; i<iTop; i+= stepSizeI) {
    for (float j=0; j<jTop; j+= stepSizeJ) {
      
      x = 10 * (coeff1*cos(PI/70*i)+coeff2*cos(PI*.285*i)+coeff3*cos(PI/100*j));
      y = 10 * (coeff1*sin(PI/70*i)+coeff2*sin(PI*.285*i)+coeff3*sin(PI/100*j));
      z = zSeparation * j;
      
//----------------------------------------------  

      vertex(x,y,z);
      countVertex++;
          }
        }
  
  println(countVertex);      
  
  endShape();
  popMatrix();
}


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void casarecce(){

  int countVertex = 0;
  float x,y,z;
  
  pushMatrix();
  translate(width/2, height/2, -20);
  rotateX(v_fader1*6); 
  rotateY(v_fader2*6);
  rotateZ(v_fader3*6); 
  beginShape();
  stroke(0);
  noFill();
    
//----------------------------------------------  
        
  for (float i=0; i<iTop; i+= stepSizeI) {
    for (float j=0; j<jTop; j+= stepSizeJ) {
      
      float firstInternal  = (PI*j/30);
      float secondInternal = PI*((2*i+j+16)/40);
      float thirdInternal = PI*j/40;
      float fourthInternal = PI*(2*i-j)/40;
      
      if(i<=30){
        x = radiusX * coeff4* cos(firstInternal) + radiusX * coeff4 * cos(secondInternal);
        y = radiusY * sin(firstInternal) + radiusY * coeff4 * sin(secondInternal);
        z = zSeparation * j/4;
      } else {
        x = radiusX * cos(thirdInternal) + radiusX * coeff4 * cos(firstInternal) + radiusX * coeff4 * sin(fourthInternal);
        y = radiusY * sin(thirdInternal) + radiusY * coeff4 * sin(firstInternal) + radiusY * coeff4 * cos(fourthInternal);
        z = zSeparation * j/4;
      }
      
//----------------------------------------------  

      vertex(x,y,z);
      countVertex++;
          }
        }
  
  println(countVertex);      
  
  endShape();
  popMatrix();
}


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void fettucine(){

  int countVertex = 0;
  float x,y,z;
  
  pushMatrix();
  translate(width/2, height/2, -20);
  rotateX(v_fader1*6); 
  rotateY(v_fader2*6);
  rotateZ(v_fader3*6); 
  beginShape();
  stroke(0);
  noFill();
    
//----------------------------------------------  
        
  for (float i=0; i<iTop; i+= stepSizeI) {
    for (float j=0; j<jTop; j+= stepSizeJ) {
      
      x = 100*sin(coeff1*PI*i);
      y = 100*cos(coeff2*PI*i)*sin(coeff3*PI*i);
      z = zSeparation*(i+j);
      
//----------------------------------------------  

      vertex(x,y,z);
      countVertex++;
          }
        }
  
  println(countVertex);      
  
  endShape();
  popMatrix();
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void fiocchiRigati(){

  int countVertex = 0;
  float x,y,z;
  
  pushMatrix();
  translate(width/2, height/2, -20);
  rotateX(v_fader1*6); 
  rotateY(v_fader2*6);
  rotateZ(v_fader3*6);
  beginShape();
  stroke(0);
  noFill();
    
//----------------------------------------------  
        
  for (float i=0; i<iTop; i+= stepSizeI) {
    for (float j=0; j<jTop; j+= stepSizeJ) {
      
      //set a variable for x and y 
      
      if ((i>=20) && (i<=60)){
        
        x = radiusX*((30/80)*i+(7*pow(sin(PI*(i+40)/40),3) * pow(sin(PI*(j+110)/100),9))); 
        y = radiusX*((35/80)*j+ 4*sin(PI*i/80) * sin(PI*(j-10)/120) - (4*sin(PI*i/80) * sin(PI*(70-j)/120)));
        z = zSeparation*(3*sin(PI*(i+10)/20)*pow(sin(PI*j/80),1.5) - (0.7*pow((sin(PI*3/8*j)+1)/2,4)));
        
      } else {
        
        x = radiusX*((30/80)*i+ (10*cos(PI*(i+80)/80) * pow(sin(PI*(j+110)/100),9))); 
        y = radiusX*((35/80)*j+ 4*sin(PI*i/80) * sin(PI*(j-10)/120) - (4*sin(PI*i/80) * sin(PI*(70-j)/120)));
        z = zSeparation*(3*sin(PI*(i+10)/20)*pow(sin(PI*j/80),1.5) - (0.7*pow((sin(PI*3/8*j)+1)/2,4)));
        
      }
      
//----------------------------------------------  

      vertex(x,y,z);
      countVertex++;
          }
        }
  
  println(countVertex);      
  
  endShape();
  popMatrix();
}


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void fusilli(){
  
  int countVertex = 0;
  float x,y,z;
  
  pushMatrix();
  translate(width/2, height/2, -20);
  rotateX(v_fader1*6); 
  rotateY(v_fader2*6);
  rotateZ(v_fader3*6);
  beginShape();
  stroke(0);
  noFill();
  
//----------------------------------------------  

float secondCosTerm;
  float internalsOfFirstTerm;
  
  for (float i=0; i<iTop; i+= stepSizeI) {
    for (float j=0; j<jTop; j+= stepSizeJ) {
      
      secondCosTerm = cos(PI * j/25.0);
      internalsOfFirstTerm = PI*(3*i+10)/100.0;
      
      x = radiusX * cos(internalsOfFirstTerm) * secondCosTerm;
      y = radiusY * sin(internalsOfFirstTerm) * secondCosTerm;
      z = i*zSeparation + coeff1*cos(PI * (j+12.5)/25.0);
      
//---------------------------------------------- 

      vertex(x,y,z);
      countVertex++;
          }
        }
  
  println(countVertex);      
  
  endShape();
  popMatrix();
}  


//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void ravioli(){

  int countVertex = 0;
  float x,y,z;
  
  pushMatrix();
  translate(width/2, height/2, -20);
  rotateX(v_fader1*6); 
  rotateY(v_fader2*6);
  rotateZ(v_fader3*6);
  beginShape();
  stroke(0);
  noFill();
    
//----------------------------------------------  
        
  for (float i=0; i<iTop; i+= stepSizeI) {
    for (float j=0; j<jTop; j+= stepSizeJ) {
      
      float funx = coeff1*(i + sin(PI*(j+2.5)/5)*(pow(sin(PI*i/200),0.2) - pow(cos(PI*i/200),0.2)));
      float funy = coeff1*(j + sin(PI*(11*i+25)/50)*(pow(sin(PI*j/200),0.2) - pow(cos(PI*j/200),0.2)));
      
      if ((i>=10) && (i<=90) && (j>=10) && (j<=90) ){
        
        x = funx;
        y = funy;
        z = zSeparation*(10*pow(sin(PI*(i-10)/80),0.6) * pow(sin(PI*(j-10)/80),0.6));
        
      } else {
        
        x = funx;
        y = funy;
        z = 0;
        
      }
      
//----------------------------------------------  

      vertex(x,y,z);
      countVertex++;
          }
        }
  
  println(countVertex);      
  
  endShape();
  popMatrix();
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void spaghetti(){

  int countVertex = 0;
  float x,y,z;
  
  pushMatrix();
  translate(width/2, height/2, -20);
  rotateX(v_fader1*6); 
  rotateY(v_fader2*6);
  rotateZ(v_fader3*6);
  beginShape();
  stroke(0);
  noFill();
    
//----------------------------------------------  
        
  for (float i=0; i<iTop; i+= stepSizeI) {
    for (float j=0; j<jTop; j+= stepSizeJ) {
      
      x = radiusX*cos(radiusX*PI*i);
      y = radiusY*sin(radiusX*PI*i);
      z = zSeparation*j;
      
//----------------------------------------------  

      vertex(x,y,z);
      countVertex++;
          }
        }
  
  println(countVertex);      
  
  endShape();
  popMatrix();
}

//-----------------------------------------------------------------------------

void spaghettiMesh(){
  
  int countVertex = 0;

  pushMatrix(); 
  translate(width/2, height/2);
  rotateX(v_fader1*6); 
  rotateY(v_fader2*6);

  for (int i=0; i<iTop; i++) { 
    beginShape(QUAD_STRIP);
    for (int j=0; j<jTop; j++) {
      float frac = (float) j/ (float) (jTop-1); // 0..1
      float angle = frac * TWO_PI; 

      float px = cos(angle); 
      float py = sin(angle);
      float pza = (i); 
      float pzb = (i); 
      vertex(radiusX*px, radiusY*py, zSeparation*pza); 
      vertex(radiusX*px, radiusY*py, zSeparation*pzb);
    }
    endShape();
  }

  popMatrix();
}




