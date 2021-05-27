import processing.video.*;
int scl=8;
Capture cam;
String letterOrder =
  " .`-_':,;^=+/\"|)\\<>)iv%xclrs{*}I?!][JCDQO1taeo7zjLu" +
  "nT#wfy325Fp6mqSghVd4EgXPGZbYk0A&8U$KHBWNMR@";

//"$@B%8&WM#*"+"oahkbdpqwmZOQ0LCJUYXzcvunxrjft"+"/\\|()1{}[]?-_+~<>i!lI;:,^`'. ";
int  len=letterOrder.length();
float pB[]; 
//PFont font;
void setup()
{
  //font=createFont("/Rockout.ttf",scl*1.5);
  
  println("Result will have "+len+" levels of brightness.");
  size(1280,720);
  cam=new Capture(this,width/scl,height/scl);
  cam.start();
  cam.read();
  pB=new float[cam.width*cam.height];
}
void draw()
{
  //textFont(font);
  background(25);
  colorMode(HSB,255,255,255,255);
  cam.loadPixels();
  if(frameCount==1)
  {
    for(int i=0;i<pB.length;i++)
    {
      pB[i]=cam.pixels[i];
    }
  }
  for(int i=0;i<cam.width;i++)
  {
    for(int j=0;j<cam.height;j++)
    { 
      color c=cam.pixels[(j*cam.width)+i];
      //textSize(map(brightness(c),0,255,2,scl)*1.2);
      textSize(scl*1.8);
      float b=brightness(c);
      float x=abs(b-pB[(j*cam.width)+i]);
      if(x<20)
      {
        b=pB[(j*cam.width)+i];
      }
      else{
      pB[(j*cam.width)+i]=b;}
      char ch=letterOrder.charAt(floor(map(b,0,256,0,len)));
      textAlign(RIGHT,TOP);
      //noStroke();
      stroke(hue(c),saturation(c),255,b);
      fill(hue(c),saturation(c),255,b);
      text(ch,map(i*scl,0,width,width,0),j*scl);
    }
  }
  //image(cam,0,0,width/4,height/4);
}
void captureEvent(Capture c)
{
  c.read();
}
void keyPressed()
{
  if(key=='s'||key=='S')
  {
    String na="Pic_"+day()+"-"+month()+"-"+year()+"_"+hour()+""+minute()+""+second()+""+".jpg";
    println("Saved:"+na);
    saveFrame(na);
  }
}
void exit()
{
  cam.stop();
  println("END");
}
