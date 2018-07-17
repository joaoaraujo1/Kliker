import android.view.MotionEvent;
import android.view.KeyEvent;

//Main variables
float sphereX,sphereY,sphereX2,sphereY2; 
public float spheresizeB;
public float spheresizeR;
boolean blueclick = false;
boolean redclick = false;
boolean start = true;
int lastTime;
int scoreblue = 0;
int scorered = 0;
PFont myFont;
float Xangle,Yangle,X2angle,Y2angle;
public float speed_red = 0.2;
public float speed_blue = 0.2;
boolean mainmenu = true, ingame = false, gameover = false;
int initanim;
int Ybackpos,bigsphere, tapos;
int circleseconds, nextdelay;
boolean gotomenu = false, newround = false;
PVector v1, v2; // ball movement vectors
boolean musicisloaded = false;



// Touch events variables
int TouchEvents;
float xTouch[];
float yTouch[];
int currentPointerId = 0;
int playTime = 20000; // 1 minute to play
int second, passedTime;
int time = 0;


//Images & Sounds
Maxim maxim;
AudioPlayer plim_red, plim_blue,wallsound,button_press, kmusic;
PImage redball, blueball, ballclickred, ballclickblue, red_counter, blue_counter, red_tapit, red_tapit2, blue_tapit,blue_tapit2, blue_wins, red_wins, tapit, tapped, count_back, logo;
int redcent, redec, reduni, bluecent, bluedec, bluni, overtime, round, bluetotal, redtotal;

//WHITESLIDER
PImage normal, click, left, right;
boolean leftslide = true, musicon = true, realmusicon = true;
int newtimer;

//Diversion balls and background
float initbluex, initredx,initbluey,initredy,divectorbx,divectorby,divectorrx,divectorry,divred,divblue,divrandmax,divrandmin;
boolean goblue;
float alphak;
PImage musicyes,musicno,realmusicyes,realmusicno;

//Variables coding consecutive ticks without response from the adversary and five bonus time counter
int blue_cons = 0;
int red_cons = 0;
float five_timer = 0.0;

//pause and back to main_menu states
boolean pause = false;
boolean getballpos = false, justexitedpause = false;
float sphereXpause, sphereX2pause, sphereYpause, sphereY2pause;
int timestop, timepaused = 0;
PImage menu_img, restart_img, resume_img;

//Laser variables
public float rot = 0;
Laser laserB[], laserR[];
boolean shootB[], shootR[];

void setup(){
   size(displayWidth,displayHeight);
   orientation(LANDSCAPE);
   ellipseMode(CENTER);
   rectMode(CENTER);
   imageMode(CENTER);
   textAlign(CENTER, CENTER);
   shapeMode(CENTER);
   
   maxim = new Maxim(this);
  
   wallsound = maxim.loadFile("bwall_converted.wav");
   wallsound.volume(2.0);
   wallsound.setLooping(false);
  
   plim_red = maxim.loadFile("plim_red_converted.wav");
   plim_red.volume(2.0);
   plim_red.setLooping(false);
  
   plim_blue = maxim.loadFile("plim_blue_converted.wav");
   plim_blue.volume(2.0);
   plim_blue.setLooping(false);
   
   button_press = maxim.loadFile("pic_converted.wav");
   button_press.volume(2.0);
   button_press.setLooping(false);
   
   kmusic = maxim.loadFile("Kliker_IntroMusic.wav");
   kmusic.volume(1);
   kmusic.setLooping(false);
   kmusic.setAnalysing(true);
   kmusic.speed(1);
  
   
   myFont = createFont("BebasNeue.otf",1,true);
   textFont(myFont);
   xTouch = new float [10];
   yTouch = new float [10];
  
  round = 1;
  bluetotal = redtotal = 0;
  spheresizeB = spheresizeR = width/10;
  
  initanim = millis();
  
  redball = loadImage("Red_0.png");
  blueball = loadImage("Blue_0.png");
  ballclickred = loadImage("Red_1.png");
  ballclickblue = loadImage("Blue_1.png");
  red_counter = loadImage("red-counter.png");
  blue_counter = loadImage("blue-counter.png");
  red_tapit = loadImage("redtap1.png");
  red_tapit2 = loadImage("redtap2.png");
  blue_tapit = loadImage("bluetap1.png");
  blue_tapit2 = loadImage("bluetap2.png");
  blue_wins = loadImage("Blue_wins.png");
  red_wins = loadImage("Red_wins.png");
  tapit = loadImage("whiteslide1.png");
  tapped = loadImage("whiteslide2.png");
  count_back = loadImage("clock-back.png");
  logo = loadImage("kliker-logo.png");
  
  normal = loadImage("white1.png");
  click = loadImage ("white2.png");
  right = loadImage ("white3.png");
  left = loadImage ("white4.png");
  
  musicyes = loadImage("sound_0.png");
  musicno = loadImage("sound_1.png");
  realmusicyes = loadImage("music_0.png");
  realmusicno = loadImage("music_1.png");
  
  menu_img = loadImage("home_0.png");
  restart_img = loadImage("restart_0.png");
  resume_img = loadImage("resume_0.png");

  divrandmax = width/400;
  divrandmin = width/600;
  initbluex = width/2;
  initredx = width/2;
  initbluey = height/2;
  initredy = height/2;
  divectorbx = random(divrandmin,divrandmax);
  divectorby = random(divrandmin,divrandmax);
  divectorrx = random(divrandmin,divrandmax);
  divectorry = random(divrandmin,divrandmax);
  divred = 255;
  divblue = 0;
  goblue = true;
  
  shootB = new boolean [20];
  shootR = new boolean [20];
  laserB = new Laser [20];
  laserR = new Laser [20];
  for(int i = 0; i < 20; i++)   
  {
     laserB[i] = new Laser ();
     laserR[i] = new Laser ();
   }

}

void draw(){
 if(!gameover && mainmenu && !ingame)
  {
   background(240);
   noStroke();
   if(!realmusicon) 
   {
     kmusic.cue(0);
     kmusic.stop();
     alphak = 100;
   }
   if(realmusicon) {
     kmusic.play();
     alphak = kmusic.getAveragePower()*350;
     musicisloaded = true;
   }
   
   fill(divred,0,divblue,alphak);
   if(divred == 255) goblue = true;
   if(divred == 0) goblue = false;

   if(goblue)
   {
    divred--;
    divblue++; 
   }
   else
   {
    divred++;
    divblue--; 
   }
   rect(width/2, height/2.25, width*.69, width*.69*.286);
   image(blueball, initbluex+=divectorbx, initbluey+=divectorby, height*.075,height*.075);
   image(redball, initredx+=divectorrx, initredy+=divectorry, height*.075,height*.075);
   
   if(initbluex + height*.075 > width/2 + width*.7/2 || initbluex - height*.075 < width/2 - width*.7/2) divectorbx *= -1;
   if(initbluey + height*.075 > height/2.25 + width*.7*.286/2 || initbluey - height*.075 < height/2.25 - width*.7*.286/2) divectorby *= -1;
   if(initredx + height*.075 > width/2 + width*.7/2 || initredx - height*.075 < width/2 - width*.7/2) divectorrx *= -1;
   if(initredy + height*.075 > height/2.25 + width*.7*.286/2 || initredy - height*.075 < height/2.25 - width*.7*.286/2) divectorry *= -1;
     
   image(logo, width/2, height/2.25, width*.7, width*.7*.286);
   int initime = millis();
   scoreblue = scorered = 0;
   textSize(width*.018);
   fill(0);
   text("Araújo & Campos  ©2015", width/2, height*.9); 
 
   textSize(width*.03);
   if((initime-initanim) % 1000 < 500)
   {
   text("Tap to Start",width*.5,height*.8);
   image(tapped, width/2, height*.70, (height*.11)*.74, height*.11);
   }
   
   else image(tapit, width/2, height*.70, (height*.11)*.74, height*.11);
   
   if(realmusicon) image(realmusicyes,3*width/4, height*.7, height*.11, height*.11);
   if(!realmusicon) image(realmusicno,3*width/4, height*.7, height*.11, height*.11);
   if(musicon) image(musicyes, width/4, height*.7, height*.11, height*.11);
   if(!musicon) image(musicno, width/4, height*.7, height*.11, height*.11);

   
   fill(240);
   // rect(width/3,height*.15,width/10,width/10);
   image(blueball, width/3,height*.15, height*.075,height*.075);
   textSize(height*.1);    
   text("-", width/3,height*.14);
    //rect(2*width/3,height*.15,width/10,width/10);
   image(redball, 2*width/3,height*.15, height*.075,height*.075);
   text("+", 2*width/3,height*.14);                        
   fill(0);
   image(count_back, width/2, height*.15, width*.22, height*.2);
   textSize(width*.085);
   text(""+playTime/1000,width/2,height*.135);
   textSize(height*.1);
  
  if(mousePressed)
  {
    fill(240);
    if(mouseX<= 2*width/3+height*.075 && mouseX>= 2*width/3 - height*.075 && mouseY<=height*.15 + height*.075 && mouseY>=height*.15 - height*.075)
    {
      image(ballclickred, 2*width/3,height*.15, height*.075,height*.075);
      text("+", 2*width/3,height*.14);
    }
    else if(mouseX<= width/3+height*.075 && mouseX>= width/3 - height*.075 && mouseY<=height*.15 + height*.075 && mouseY>=height*.15 - height*.075)
    {
      image(ballclickblue, width/3,height*.15, height*.075,height*.075);
      text("-", width/3,height*.14);
    }
  }

  }
  
  
  if(ingame && !gameover)
  {
    mainmenu = false;
    background(240);
    
    if(blueclick)
    {
      background(200,200,255);
      if ( millis() - lastTime > 150 ) {
      blueclick = false;
    }
  
  }
  if(redclick)
  {
    background(255,200,200);
    if ( millis() - lastTime > 150 ) {
    redclick = false;
  }
  
}

  textSize(width*.11);
  
  redcent = scorered / 100;
  bluecent = scoreblue / 100;
  redec = (scorered % 100 - scorered % 10) / 10;
  bluedec = (scoreblue % 100 - scoreblue % 10) / 10;
  reduni = scorered % 10;
  bluni = scoreblue % 10;
  
  fill(180);
  text(""+bluetotal, width/4, height*.14);
  text("" +redtotal, 3*width/4, height*.14);
  image(red_counter, width*.75, height*.5, width*.15, (width*.15)*.38); 
  image(blue_counter, width*.25, height*.5, width*.15, (width*.15)*.38);
  
  
  fill(0);
  textSize(width*.03);
  
  text("" + redcent, width*.705, height*.495);
  text("" + redec, width*.75, height*.495);
  text("" + reduni, width*.795, height*.495);
  text("" + bluecent, width*.205, height*.495);
  text("" + bluedec, width*.25, height*.495);
  text("" + bluni, width*.295, height*.495);
  
  if(start) 
  {
    text("Tap your ball more times than your opponent", width*.5, height*.8);
    
    if((millis()-initanim) % 1000 < 500)
    {
      image(red_tapit, width*.75, height*.65, (height*.11)*.74, height*.11);
      image(blue_tapit, width*.25, height*.65, (height*.11)*.74, height*.11);
      image(blueball,width/4,height/2,spheresizeB,spheresizeB);
      image(ballclickred,width*.75,height/2,spheresizeR,spheresizeR);
    }
    
    else
    {
      image(red_tapit2, width*.75, height*.65, (height*.11)*.74, height*.11);    
      image(blue_tapit2, width*.25, height*.65, (height*.11)*.74, height*.11);
      image(ballclickblue,width/4,height/2,spheresizeB,spheresizeB);
      image(redball,width*.75,height/2,spheresizeR,spheresizeR);

    }
    
    textSize(width*.09);
    text("Round "+round, width*.5, height/3);
  }


float minrand = width/1300;
float maxrand = height/190;
if(start)
{
Xangle = random(minrand,maxrand);
Yangle = random(minrand,maxrand);
Y2angle = random(minrand,maxrand);
X2angle = random(minrand,maxrand);
time = millis();
}

v1 = new PVector (Xangle,Yangle);
v2 = new PVector (X2angle, Y2angle); 

  if(!pause)
  { 
   
    if(justexitedpause)
    {
      time += timepaused;
      timepaused = 0;
      justexitedpause = false;
    }
    getballpos = true;
    passedTime = millis() - time;
  }
    
    float alpha1 = 255-((passedTime+5)%1000)/3.921;
    if(!start) fill(0,0,0,alpha1);
    image(count_back, width*.5, height*.15, width*.22, height*.2);
    textSize(width*.085);
    text(""+(playTime-passedTime)/1000,width/2,height*.135);
    
    if((playTime-passedTime)/1000 - 1 >= 0){
    float alpha2 = ((passedTime+5)%1000)/3.921;
    fill(0,0,0,alpha2);
    text(""+((playTime-passedTime)/1000 - 1),width/2,height*.135);
    }

    if (passedTime > playTime && !pause) {
    start = true;
    gameover = true;
    ingame = false;
    circleseconds = millis();
    }
    
if(!start)
{
ellipse(sphereX,sphereY,spheresizeB,spheresizeB);
if(blueclick) image(ballclickblue,sphereX,sphereY,spheresizeB,spheresizeB);
else image(blueball,sphereX,sphereY,spheresizeB,spheresizeB);

ellipse(sphereX2,sphereY2,spheresizeR,spheresizeR);
if(redclick) image(ballclickred,sphereX2,sphereY2,spheresizeR,spheresizeR);
else image(redball,sphereX2,sphereY2,spheresizeR,spheresizeR);
}

if(!start &&(scoreblue >= 5 || scorered>= 5))
{
  
 if(sphereX + spheresizeB/2 <= width && sphereY + spheresizeB/2 <= height && sphereX - spheresizeB/2 >= 0 && sphereY - spheresizeB/2 >= 0)
 {
 sphereX+=scoreblue*speed_blue*v1.x;
 sphereY+=scoreblue*speed_blue*v1.y;
 }
 if(sphereX + spheresizeB/2 > width)
 {
 Xangle = random(-1*maxrand,-1*minrand);
 sphereX+=scoreblue*speed_blue*v1.x;
 if(musicon){
 wallsound.cue(0);
 wallsound.play();
 }
 }
 
 if(sphereY + spheresizeB/2 > height)
 {
 Yangle = random(-1*maxrand,-1*minrand);
 sphereY+=scoreblue*speed_blue*v1.y;
 if(musicon){
 wallsound.cue(0);
 wallsound.play();
 }
 }
 
  if(sphereX - spheresizeB/2 < 0)
  {
 Xangle = random(minrand,maxrand);
 sphereX+=scoreblue*speed_blue*v1.x;
 if(musicon){
 wallsound.cue(0);
 wallsound.play();
 }
  }
 
 if(sphereY - spheresizeB/2 < 0)
 {
 Yangle = random(minrand,maxrand);
 sphereY+=scoreblue*speed_blue*v1.y;
 if(musicon){
 wallsound.cue(0);
 wallsound.play();
 }
 }
 
  if(sphereX2 + spheresizeR/2 < width && sphereY2 + spheresizeR/2 < height && sphereX2 - spheresizeR/2 > 0 && sphereY2 - spheresizeR/2 > 0)
 {
 sphereX2+=scorered*speed_red*v2.x;
 sphereY2+=scorered*speed_red*v2.y;
 }
 if(sphereX2 + spheresizeR/2 > width)
 {
 X2angle = random(-1*maxrand,-1*minrand);
 sphereX2+=scorered*speed_red*v2.x;
 if(musicon){
 wallsound.cue(0);
 wallsound.play();
 }
 }
 
 if(sphereY2 + spheresizeR/2 > height)
 {
 Y2angle = random(-1*maxrand,-1*minrand);
 sphereY2+=scorered*speed_red*v2.y;
 if(musicon){
 wallsound.cue(0);
 wallsound.play();
 }
 }
 
  if(sphereX2 - spheresizeR/2 < 0)
  {
 X2angle = random(minrand,maxrand);
 sphereX2+=scorered*speed_red*v2.x;
 if(musicon){
 wallsound.cue(0);
 wallsound.play();
 }
  }
 
 if(sphereY2 - spheresizeR/2 < 0)
 {
 Y2angle = random(minrand,maxrand);
 sphereY2+=scorered*speed_red*v2.y;
 if(musicon){
   wallsound.cue(0);
  wallsound.play();
 }
 }
}
 
// bonus of five clicks in a row without opponent's response
five_timer = fivebonus(blue_cons, red_cons, five_timer, sphereX, sphereY, sphereX2, sphereY2);

if(five_timer == 0.0 && (blue_cons > red_cons + 5 || red_cons > blue_cons + 5)) // fim do fivebonus
  blue_cons = red_cons = 0;

// define some variables usefull for the gameover
bigsphere = width/5;
Ybackpos = height-bigsphere/2-width/160;


  if(pause) pause_game();
  else if (!pause && realmusicon && !kmusic.isPlaying) kmusic.play();
}
  
if(gameover && !mainmenu && !ingame)
{
  textSize(width*.03);
  overtime = millis();
  background(240);
  image(red_counter, width*.75, height*.5, width*.15, (width*.15)*.38);
  image(blue_counter, width*.25, height*.5, width*.15, (width*.15)*.38);
  
  if(scorered>scoreblue)
  {
   fill(247,161,154);
   if(height*.5 + (millis()-circleseconds)*height/5000*-1 > height*.17)
   {
     text("+1", width*.75, height*.5 + (millis()-circleseconds)*height/5000*-1); 
     fill(180);
     textSize(width*.11);
     text(""+redtotal, 3*width/4, height*.14);
     text(""+bluetotal, width/4, height*.14);
   }

   else 
   {
     fill(180);
     textSize(width*.11);
     text(""+(redtotal+1), 3*width/4, height*.14);
     text(""+bluetotal, width/4, height*.14);
  }  
  }
  
  else if(scorered<scoreblue)
    {
   fill(125,167,216);
   if(height*.5 + (millis()-circleseconds)*height/5000*-1 > height*.17)
   {
     text("+1", width*.25, height*.5 + (millis()-circleseconds)*height/5000*-1); 
     fill(180);
     textSize(width*.11);
     text(""+redtotal, 3*width/4, height*.14);
     text(""+bluetotal, width/4, height*.14);
   }

   else 
   {
     fill(180);
     textSize(width*.11);
     text(""+redtotal, 3*width/4, height*.14);
     text(""+(bluetotal+1), width/4, height*.14);
  } 
} 
 else if(scorered == scoreblue)
{
     fill(180);
     textSize(width*.11);
     text(""+redtotal, 3*width/4, height*.14);
     text(""+bluetotal, width/4, height*.14);
 
} 
  
  textSize(width*.03);
  
  fill(0);
  text("" + redcent, width*.705, height*.495);
  text("" + redec, width*.75, height*.495);
  text("" + reduni, width*.795, height*.495);
  text("" + bluecent, width*.205, height*.495);
  text("" + bluedec, width*.25, height*.495);
  text("" + bluni, width*.295, height*.495);

  if(scoreblue>scorered)
  {
   String bluewins = "Blue Wins!";
   textSize(width*.09);
   fill(0,102,179);
   image(blue_wins, width/2, height*.42, width*.20, (width*.20)*.76);
   if((overtime-initanim) % 500 < 250)
      text(bluewins,width/2,height*.125);
  }
  
    if(scoreblue<scorered)
  {
   String redwins = "Red Wins!";
   fill(237,28,36);
   textSize(width*.09);
   image(red_wins, width/2, height*.42, width*.20, (width*.20)*.76);
   if((overtime-initanim) % 500 < 250)
      text(redwins,width/2,height*.125);
  }
  
  if(scoreblue == scorered)
  {
   String draw = "Draw";
   fill(0);
   textSize(width*.09);
   text(draw,width/2,height*.125); 
  }
  if(overtime - circleseconds <= 3000) newtimer = millis();
  if(overtime - circleseconds > 3000)
  {
    /***********************************
              WHITESLIDER HERE
    ***********************************/
  if(millis() - newtimer <= 500) image(normal, width/2, height*.65, (height*.20), height*.11);
  if(millis() - newtimer > 500 && millis() - newtimer <= 1000) image(click, width/2, height*.65, (height*.20), height*.11);
  
  if(millis() - newtimer > 1000 && millis() - newtimer <= 1500)
  {
   if(leftslide) image(left, width/2, height*.65, (height*.20), height*.11);
   if(!leftslide) image(right, width/2, height*.65, (height*.20), height*.11);  
  }
  
  if(millis() - newtimer > 1500)
  {
   if(leftslide) leftslide = false;
   else leftslide = true;
   newtimer = millis();
  }
  textSize(width*.03);
  fill(0);
  if(leftslide)
   {
     if(scorered<scoreblue) fill(237,28,36);
     if(scorered>scoreblue) fill(0,102,179);
     if(scorered == scoreblue) fill(0);
     text("Slide LEFT for PAYBACK!", width*.5, height*.8);
   }
  else
 {
     if(scorered<scoreblue) fill(0,102,179);
     if(scorered>scoreblue) fill(237,28,36);
     if(scorered == scoreblue) fill(0);
   text("Slide RIGHT for MAIN MENU", width*.5, height*.8);
 }

  if(mousePressed && !newround && !gotomenu)
  {
   if(mouseX>pmouseX && overtime - circleseconds > 3000)
   {  
 if(musicon){   
 button_press.cue(0);
 button_press.play();
 }
 gotomenu = true;    
   }
  
  else if(mouseX<pmouseX && overtime - circleseconds > 3000)
  {   
 if(musicon){
 button_press.cue(0);
 button_press.play();
 }
 newround = true;
  }
nextdelay = millis();
 }

if(newround && millis()-nextdelay > 200)
{
 if(scorered>scoreblue) redtotal++;
 if(scoreblue>scorered) bluetotal++;
 scorered = 0;
 scoreblue = 0;
 speed_blue = speed_red = 0.2;
 round++;
 timepaused = 0;
 gameover = false; ingame = true; newround = false; 
 spheresizeR = spheresizeB = width/10;
}

if(gotomenu && millis()-nextdelay > 200)
{  
 if(scorered>scoreblue) redtotal++;
 if(scoreblue>scorered) bluetotal++;
 round = 1;
 bluetotal = redtotal = 0; 
 speed_red = speed_blue = 0.2;
 gameover = false; mainmenu = true; gotomenu = false;
 scorered = scoreblue = 0;
 spheresizeR = spheresizeB = width/10;
}

  
 //if(Ybackpos - bigsphere/2 <=0 || Ybackpos + bigsphere/2 >=height)
  //Ymenu*=-1;
  noStroke();
  }
}
  }

  
void mouseReleased(){
   
    if(!gameover && mainmenu && !ingame)
{   
  

   if(mouseX<= width/3+height*.075 && mouseX>= width/3 - height*.075 && mouseY<=height*.15 + height*.075 && mouseY>=height*.15 - height*.075)
   {
     if(playTime>10000) playTime -= 5000;
     if(musicon){
     button_press.cue(0);
     button_press.play(); 
     }
     image(ballclickblue, width/3,height*.15, height*.075,height*.075);
 }
   
else if(mouseX<= 2*width/3+height*.075 && mouseX>= 2*width/3 - height*.075 && mouseY<=height*.15 + height*.075 && mouseY>=height*.15 - height*.075)
   {
   if(playTime<30000) playTime += 5000;
   if(musicon){
     button_press.cue(0);
     button_press.play();
   }
     image(ballclickred, 2*width/3,height*.15, height*.075,height*.075);
   }
   
  
 else if(mouseY> height*.5 && mouseX<= width/2+height*.075 && mouseX>= width/2 - height*.075){ 
 if(musicon){
 button_press.cue(0);
 button_press.play();
 }
  ingame = true; 
  }

 else if(mouseY> height*.5 && mouseX<= width/4+height*.075) musicon = !musicon;
 else if(mouseY> height*.5 && mouseX>= 3*width/4-height*.075) realmusicon = !realmusicon;
  
  }
 
 if(pause)
 {
   if(mouseX < width/2 + width/10 && mouseX > width/2 - width/10 && mouseY < height/2 + width/10 && mouseY > height/2 - width/10) //main menu 
   {
     round = 1;
     bluetotal = redtotal = 0; 
     speed_red = speed_blue = 0.2;
     gameover = false; mainmenu = true; gotomenu = false; ingame = false; start = true;
     scorered = scoreblue = 0;
     pause = false;
     spheresizeB = spheresizeR = width/10;
     
   }
  
   if(mouseX < width/4 + width/10 && mouseX > width/4 - width/10 && mouseY < height/2 + width/10 && mouseY > height/2 - width/10) //resume
      pause = false;
   
   if(mouseX < 3*width/4 + width/10 && mouseX > 3*width/4 - width/10 && mouseY < height/2 + width/10 && mouseY > height/2 - width/10) // restart
   {
     start = true;
     scorered = scoreblue = 0;
     speed_red = speed_blue = 0.2;
     pause = false;
   }
   
    
 }
}

/* Multi-touch code */
boolean surfaceTouchEvent(MotionEvent event) {
if(!gameover && !mainmenu && ingame)
{
  TouchEvents = event.getPointerCount();

  for (int i = 0; i < TouchEvents; i++) {
    int pointerId = event.getPointerId(i);
    xTouch[pointerId] = event.getX(i); 
    yTouch[pointerId] = event.getY(i);
  }
      if(start && !pause){
    start = false;
    sphereX = width*.25;
    sphereY = height/2;
    sphereX2 = width*.75;
    sphereY2 = height/2;
  }
       
for (int i = 0; i < xTouch.length; i++) {
      if(xTouch[i]<= spheresizeB/2 + (sphereX + scoreblue*speed_blue*v1.x) && xTouch[i]>= (sphereX + scoreblue*speed_blue*v1.x) - spheresizeB/2 &&
        yTouch[i]<= (sphereY + scoreblue*speed_blue*v1.y)+ spheresizeB/2  && yTouch[i]>= (sphereY + scoreblue*speed_blue*v1.x) - spheresizeB/2 && !blueclick && !pause)
  {       
blueclick = true;
scoreblue++;
blue_cons++;
red_cons = 0;
print("+1 for the blue");
lastTime = millis();
      
if(musicon){
  plim_blue.cue(0);
  plim_blue.play();
}
    if(rand_b > 49)
    for (int j = 0; j < 20; j++) 
       if(!shootB[j]){ shootB[j] = true; break;}
  }
  if(xTouch[i]<= spheresizeR/2 + (sphereX2 + scorered*speed_red*v2.x) && xTouch[i]>= (sphereX2 + scorered*speed_red*v2.x) - spheresizeR/2 && 
     yTouch[i]<= (sphereY2 + scorered*speed_red*v2.y) + spheresizeR/2   && yTouch[i]>= (sphereY2 + scorered*speed_red*v2.y) - spheresizeR/2 && !redclick && !pause)
  {
redclick = true;
scorered++;
red_cons++;
blue_cons = 0;
lastTime = millis(); 
if(musicon){
  plim_red.cue(0);
  plim_red.play();
}
print("+1 for the red");
    if(rand_r > 49)
    for (int j = 0; j < 20; j++) 
     if(!shootR[j]){ shootR[j] = true; break;} 
  }

}
}
  return super.surfaceTouchEvent(event);
}

/*Code for key clicking*/

boolean surfaceKeyDown(int code, KeyEvent event) {
  //System.out.println("got onKeyDown for " + code + " " + event);
  if (event.getKeyCode() == 4) {
    if(ingame){ pause = !pause; System.out.println("Pause is "+pause);}
    else if(mainmenu) exit();
    else if(!newround && !gotomenu && gameover && !mainmenu && !ingame)
    {
     round = 1;
     bluetotal = redtotal = 0; 
     speed_red = speed_blue = 0.2;
     gameover = false; mainmenu = true; gotomenu = false; ingame = false; start = true;
     scorered = scoreblue = 0;
     pause = false;
     spheresizeR = spheresizeB = width/10;
    }
  
  }

return false;
}

boolean surfaceKeyUp(int code, KeyEvent event) {
  return true; 
}

//pause setting
void pause_game(){
  if(getballpos)
  {
    sphereXpause = sphereX;
    sphereX2pause = sphereX2;
    sphereYpause = sphereY;
    sphereY2pause = sphereY2;
    timestop = millis();
    getballpos = false;   
    justexitedpause = true; 
  }
  
  sphereX = sphereXpause;
  sphereX2 = sphereX2pause;
  sphereY = sphereYpause;
  sphereY2 = sphereY2pause;
  timepaused = millis()-timestop;
  
  fill(0,0,0,200); 
  rect(width/2,height/2,width,height);
  textSize(width*.14);
  fill(255);
  text ("PAUSE", width/2, height/10);
  image(menu_img, width/2, height/2, width/10,width/10);
  image(resume_img, width/4, height/2, width/10,width/10);
  image(restart_img, 3*width/4, height/2, width/10,width/10);
  textSize(width*.04);
  fill(255);
  text ("Main Menu", width/2, (height/2 + width*.08)); // folga o dobro do texto 
  text ("Resume", width/4, (height/2 + width*.08)); 
  text ("Restart", 3*width/4, (height/2 + width*.08));  
  System.out.println("Pause is through");
 
 kmusic.stop(); 
}

// pausar a musica quando a app  esta no background
@Override
public void onPause() {
  println("In pause");
  if(musicisloaded && realmusicon) kmusic.stop();
    super.onPause();
    }
    
