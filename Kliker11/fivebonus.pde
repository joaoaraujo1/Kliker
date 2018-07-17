// fivebonus happens when one of the players clicks a ball more than five times without a response from the other
private boolean red_bonus = false;
private boolean blue_bonus = false;
private boolean rand_bonus_b = true;
private boolean rand_bonus_r = true;
public int rand_b = -1;
public int rand_r = -1;

public float fivebonus(int blue_cons, int red_cons, float five_timer, float blueX, float blueY, float redX, float redY)
{ 

  if(blue_cons > red_cons + 5) blue_bonus = true;
  
  if(blue_bonus)
  {
    if(rand_bonus_b) {rand_b = (int) random(100); rand_bonus_b = false; println("randomB = "+rand_b);}
   
    /**SPEED BONUS**/
    if(rand_b <= 49)
    {
      speed_red = 1.0;
      fill(0,0,255,60);
      rect(width/2, height/2, width, height);
      textSize(width*.05);
      fill(0,0,255);
      
      if(millis() - five_timer < 333 || millis() - five_timer > 666 &&  millis() - five_timer < 999 || 
      millis() - five_timer > 1332 &&  millis() - five_timer < 1665 || millis() - five_timer > 1998 &&  millis() - five_timer < 2331)
      text("Blue is speeding it!!", width/2, height/2);
      
      //print("\nfive time is "+(millis()-five_timer));
      
      if(five_timer == 0.0) five_timer = millis();
        
      if(millis() - five_timer < 3000) return five_timer;
      
      else{blue_bonus = false; speed_red = 0.2; rand_b = -1; rand_bonus_b = true; return 0.0;}
    }
    
    /*Laser bonus*/
    if(rand_b > 49)
    {
      fill(0,0,255,60);
      rect(width/2, height/2, width, height);
      textSize(width*.05);
      fill(0,0,255);
      
      if(millis() - five_timer < 333 || millis() - five_timer > 666 &&  millis() - five_timer < 999 || 
      millis() - five_timer > 1332 &&  millis() - five_timer < 1665 || millis() - five_timer > 1998 &&  millis() - five_timer < 2331)
      text("Blue is Killing it!!", width/2, height/2);  

      for (int i = 0; i < 20; i++)
       if(shootB[i]){
         laserB[i].shoot(i, blueX, blueY, 1);
         laserB[i].checkhit(redX, redY, spheresizeR, 1);
         }
      
      //print("\nfive time is "+(millis()-five_timer));
      
      if(five_timer == 0.0) five_timer = millis();
        
      if(millis() - five_timer < 3000) return five_timer;
      
      else{
        blue_bonus = false; 
        rand_b = -1; 
        rand_bonus_b = true; 
        //spheresizeR = width/10;
        for(int i = 0; i < shootB.length; i++) 
        {
          shootB[i] = false;
          laserB[i].reset();
        }
          return 0.0;
      }
      
    }

  }
  
  if(red_cons > blue_cons + 5) red_bonus = true;
  
  if(red_bonus)
  {
   if(rand_bonus_r) {rand_r = (int) random(100); rand_bonus_r = false;}
   
   if(rand_r <=49)
    {
      speed_blue = 1.0;
      fill(255,0,0,60);
      rect(width/2, height/2, width, height);
      textSize(width*.05);
      fill(255,0,0);
      
      if(millis() - five_timer < 333 || millis() - five_timer > 666 &&  millis() - five_timer < 999 || 
      millis() - five_timer > 1332 &&  millis() - five_timer < 1665 || millis() - five_timer > 1998 &&  millis() - five_timer < 2331)
      text("Red is speeding it!!", width/2, height/2);
      
      //print("\nfive time is "+(millis()-five_timer));
      
      if(five_timer == 0.0) five_timer = millis();
        
      if(millis() - five_timer < 3000) return five_timer;
      
      else{red_bonus = false; speed_blue = 0.2; return 0.0;}
    }
    
   if(rand_r > 49)
   {
      fill(255,0,0,60);
      rect(width/2, height/2, width, height);
      textSize(width*.05);
      fill(255,0,0);
      
      if(millis() - five_timer < 333 || millis() - five_timer > 666 &&  millis() - five_timer < 999 || 
      millis() - five_timer > 1332 &&  millis() - five_timer < 1665 || millis() - five_timer > 1998 &&  millis() - five_timer < 2331)
      text("Red is Killing it!!", width/2, height/2);
      
     // print("\nfive time is "+(millis()-five_timer));
      
      for (int i = 0; i < 20; i++)
       if(shootR[i]){
         laserR[i].shoot(i, redX, redY, 2);
         laserR[i].checkhit(blueX, blueY, spheresizeB, 2);
         }
      
      if(five_timer == 0.0) five_timer = millis();
        
      if(millis() - five_timer < 3000) return five_timer;
     
      else{
        red_bonus = false; 
        rand_r = -1; 
        rand_bonus_r = true; 
        //spheresizeB = width/10;
        for(int i = 0; i < shootR.length; i++) 
        {
          shootR[i] = false;
          laserR[i].reset();
        }
          return 0.0;
      }     
   }
  }
  
  else if(!red_bonus && !blue_bonus){speed_blue = 0.2; speed_red = 0.2; return 0.0;}
  
  return five_timer;

}

public class Laser{
  float laserX;
  float laserY;
  boolean setlaser = true;
  Laser()
  {
    laserX = 0;
    laserY = 0;
  }
  
 void shoot (int i, float X, float Y, int n){

   if(setlaser){ laserX = X; laserY = Y; setlaser = false;}
   pushMatrix();
   rot= (i * PI/6) % (2*PI);
   translate(laserX + width/10 *sin(rot),laserY - width/10 *cos(rot));
   rotate(rot);
   if(n == 1) stroke(0,0,255);
   if(n == 2) stroke(255,0,0);
   strokeWeight(width*.007);
   line(0,0,0,width/20);
   stroke(255);
   strokeWeight(width*.0035);
   line(0,0,0,width/20);
   noStroke();
   popMatrix();
   laserX +=width/45*sin(rot);
   laserY -=width/45*cos(rot); 
  }
  
 void reset (){ setlaser = true; laserX = 0; laserY = 0;}


 void checkhit(float X, float Y, float spheresize, int n)
{
 if(/*Middle laser*/(laserX  + width/10 *sin(rot) <= spheresize/2 + X && laserX  + width/10 *sin(rot) >= X - spheresize/2 && laserY - width/10 *cos(rot) <= Y + spheresize/2
  && laserY - width/10 *cos(rot) >= Y - spheresize/2))
  {
    if(n == 1) spheresizeR /= 2;
    if(n == 2) spheresizeB /= 2;   
   
   laserX = 2*width;
   laserY = 2*height;
  }
  
}
}
