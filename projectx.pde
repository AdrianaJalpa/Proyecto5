int pantalla=0;

PImage img, img2, img3, img4, instrucciones;
int mosaicSize = 3;
float x;


//primer pantalla
Hexagon[][][] grid;

int gridSize = 64;
float gridSizeW = sin(radians(60))*gridSize;

int cols = 16;
int rows = 18;
int zAxis = 8;
int target;

import processing.sound.*;
SoundFile soundfile;


void setup(){
  size(600,420);
  background(255);
  noStroke();
  frameRate(10);
  img = loadImage("photo.png"); 
  img2 = loadImage("paisaje1.jpg"); 
  img3 = loadImage("paisaje2.jpg"); 
  img4 = loadImage("paisaje3.jpg"); 
  instrucciones= loadImage("instrucciones.jpg");
  
  randomSeed(zAxis);
  smooth();
  grid = new Hexagon[cols][rows][zAxis];
  setupGrid(180,360);
  
  soundfile= new SoundFile(this, "Sleeping_At_Last.mp3");
  soundfile.play();
}

void draw(){
  
  switch(pantalla){
    /*************** titulo ******************/
    case 0:
      background(0,0,100,100);
      translate(0,-50);
      
      for (int i=0; i < cols; i++) {
        for (int j=0; j < rows; j++) {
          for (int k=0; k < zAxis; k++) {
            pushMatrix();
            translate(gridSizeW*i, gridSize*j*0.5);
            grid[i][j][k].drawHex();
            grid[i][j][k].update();
            popMatrix();
          }
        }
      }
      
      fill(0);
      textSize(50);
      text("Iridiscencia",300,210);
      
      textSize(15);
      text("Presione C para continuar...",305,230);
      
      if(keyPressed){
        if(key== 'c' || key == 'C'){
          pantalla=1;
        }
      }
    break;
    
    /************** inst ********************/
    case 1:
      background(0);
      image(instrucciones,0,0);
      if(keyPressed){
        if(key== 's' || key == 'S'){
          pantalla=2;
        }
      }
    
    break;
    
    /************* pintura1 ****************/
    case 2:
      background(0);
      for(int j = 0; j < height; j+=mosaicSize){
       for(int i = 0; i < width; i+=mosaicSize) {  
          color c = img.get(i,j);
          fill(c, 127);
          x = blue(c)/6;
          if(x>20){x=x-int(random(0,10));}
          if(x<5){x=x+int(random(0,10));}
     
           if( (i>0 && i< 155 || i>197 && i<width)  ||  (j>0 && j< 20 || j>20 && j<height))
           {
             ellipse(i, j, x, x);
           }
        }
       }
       
       if(keyPressed){
         if(key == 'q' || key == 'Q'){
           pantalla=3;
         }
       }
    
    break;
    
    case 3:
      background(0);
      for(int j = 0; j < height; j+=mosaicSize){
       for(int i = 0; i < width; i+=mosaicSize) {  
          color c = img2.get(i,j);
          fill(c, 127);
          x = blue(c)/6;
          if(x>20){x=x-int(random(0,10));}
          if(x<5){x=x+int(random(0,10));}
     
           if( (i>0 && i< 155 || i>197 && i<width)  ||  (j>0 && j< 20 || j>20 && j<height))
           {
             ellipse(i, j, x, x);
           }
        }
       }
       if(keyPressed){
         if(key == 'w' || key == 'W'){
           pantalla=4;
         }
       }
    
      
    break;
    
    case 4:
      background(0);
      for(int j = 0; j < height; j+=mosaicSize){
       for(int i = 0; i < width; i+=mosaicSize) {  
          color c = img3.get(i,j);
          fill(c, 127);
          x = blue(c)/6;
          if(x>20){x=x-int(random(0,10));}
          if(x<5){x=x+int(random(0,10));}
     
           if( (i>0 && i< 155 || i>197 && i<width)  ||  (j>0 && j< 20 || j>20 && j<height))
           {
             ellipse(i, j, x, x);
           }
        }
       }
       if(keyPressed){
         if(key == 'e' || key == 'E'){
           pantalla=5;
         }
       }
    
    break;
    
    case 5: 
      background(0);
      for(int j = 0; j < height; j+=mosaicSize){
       for(int i = 0; i < width; i+=mosaicSize) {  
          color c = img4.get(i,j);
          fill(c, 127);
          x = blue(c)/6;
          if(x>20){x=x-int(random(0,10));}
          if(x<5){x=x+int(random(0,10));}
     
           if( (i>0 && i< 155 || i>197 && i<width)  ||  (j>0 && j< 20 || j>20 && j<height))
           {
             ellipse(i, j, x, x);
           }
        }
       }
    break;
    
  }
}


//Background primer pantalla

void setupGrid(int colorRangeMin, int colorRangeMax) {
 int crMin = colorRangeMin;
 int crMax = colorRangeMax;
 for (int i=0; i < cols; i++) {
    for (int j=0; j < rows; j++) {
      for (int k=0; k < zAxis; k++) {
       grid[i][j][k] = new Hexagon(gridSize, int(random(crMin, crMax)), int(random(0, 5))); 
      }
    }
  } 
}


class Hexagon {

  float a, b, c;
  int form;
  int rColor;
  float sideLength;
  int life;

  int counter = 1;

  int index = 1;

  Hexagon(float _sideLength, int _rColor, int _count) {

    c = _sideLength;
    a = c/2;
    b = sin(radians(60))*c;
    rColor = _rColor;

    form = _count;
    int life = 50+int(random(0, 50));
  }


  void drawHex() {  

    switch(form) {
      
    case 0:
      beginShape();
      fill(rColor, 100, 90, 33);
      vertex(0, 0);
      vertex(b/2, 0.25*c);
      vertex(b/2, 0.75*c);
      vertex(0, 0.5*c);
      endShape();
      break;
      
    case 1:
      beginShape();
      fill(rColor, 100, 90, 33);
      vertex(0, 0.5*c);
      vertex(b/2, 0.25*c);
      vertex(b/2, 0.75*c);
      vertex(0, c);
      endShape();
      break;
      
    case 2:
      beginShape();
      fill(rColor, 100, 90, 33);
      vertex(b, 0);
      vertex(b/2, 0.25*c);
      vertex(b/2, 0.75*c);
      vertex(b, 0.5*c);
      endShape();
      break;
      
    case 3:
      beginShape();
      fill(rColor, 100, 90, 33);
      vertex(b, c*0.5);
      vertex(b/2, 0.25*c);
      vertex(b/2, 0.75*c);
      vertex(b, c);
      endShape();
      break;
      
    case 4:
      beginShape();
      fill(rColor, 66, 90, 50);
      vertex(0, c*0.5);
      vertex(b/2, 0.25*c);
      vertex(b, c*0.5);
      vertex(b/2, 0.75*c);
      endShape();
      break;
    }
  }

  void update() {
    life = int(random(-100, 100))+count(0, 100);
    fill(0, life);

    if (life == 100) {
      form++;
      if (form > 5) {
        form = 0;
      }
    }
  }

  int count(int rangeDown, int rangeUp) {
    counter = counter + index;
    if (counter == rangeUp) {
      index = -1;
    }
    if (counter == rangeDown) {
      index = 1;
    }
    return counter;
  }
}