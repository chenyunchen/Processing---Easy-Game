import ddf.minim.*;
import gifAnimation.*;

Minim m;
AudioPlayer bosssound;
AudioPlayer littlesound;
AudioPlayer fistsound;
AudioPlayer swordsound;
AudioPlayer gunsound;

PImage back;
PImage once;
boolean startGame = false;
int score=0;
int groundH = 100;

Gif mancondition;
Gif gay;
Gif gungay;
Gif swordgay;

//**gay
int hurtNum=0;
int HP=200;
int step = 10;
int gayWidth=125;
int gayX=20;
int gayY=600-groundH-gayWidth+20;
boolean gayLife=true;

boolean jump = true;
boolean forJump = false;
boolean moveRight = false;
boolean moveLeft = false;

int B=0;
int bulletNum = 50;
Bullet []bullet = new Bullet[bulletNum];

PImage stone;
PImage fistAttack;
boolean showfatk=false;
boolean fist = false;

PImage sword;
PImage swAttack;
boolean showsatk=false;
boolean swordatk = false;

PImage gun;
boolean shot = false;
//**gay

//enemy**
PImage enemy;
int enemyNum = 5;
int enemywidth=100;
int[] enemyX = new int[enemyNum];
int[] enemyY = new int[enemyNum];
boolean[] enemyLife = new boolean[enemyNum];
//**enemy

//boss**
PImage boss;
int bossX=600;
int bossY=300;
int bossWidth=200;
int bossHP=500;
int bossHurtNum=0;
boolean bossLife=true;

PImage Bbullet;
int BbulletNum = 3;
int BbulletWidth=100;
int[] BbulletX = new int[BbulletNum];
int[] BbulletY = new int[BbulletNum];
boolean[] BbulletLife = new boolean[BbulletNum];

//**boss

void setup(){
  size(800,600);
  m = new Minim(this);
  bosssound = m.loadFile("boss.mp3");
  littlesound = m.loadFile("little.mp3");
  back = loadImage("background.jpg");
  once = loadImage("atonce.jpg");
  gay = new Gif(this,"gay.gif");
  gay.loop();
  gungay = new Gif(this,"gungay.gif");
  gungay.loop();  
  swordgay = new Gif(this,"swgay.gif");
  swordgay.loop(); 
  mancondition = gay;
  
  stone = loadImage("fist.gif");
  fistAttack = loadImage("fistatk.gif");
   
  sword = loadImage("sword.gif");
  swAttack = loadImage("swattack.gif");
  
  gun = loadImage("gun.gif");
   
  enemy = loadImage("man.png");
  boss = loadImage("BOSS.gif");
  Bbullet = loadImage("ha.gif");
  
  //game start random enemy**
  for(int i=0;i<enemyNum;i++){
    enemyX[i]=(int)random(800,1600);
    enemyY[i]=600-groundH-enemywidth;
    enemyLife[i] = true;
  }
  //**game start random enemy
  
  //game start random Bbullet**
  for(int i=0;i<BbulletNum;i++){
    BbulletX[i]=(int)random(800,1600);
    BbulletY[i]=600-groundH-BbulletWidth;
    BbulletLife[i] = true;
  }
  //**Bbullet start random enemy
}

void keyPressed(){
  if(key == 'A'||key == 'a'){
    if(gayX<=0)
      gayX=0;
    else
      gayX-=20;
    moveLeft = true;
  }
  if(key == 'D'||key == 'd'){
    if(gayX>=800-gayWidth)
      gayX=800-gayWidth;
    else
      gayX+=20;
    moveRight = true;
  }
  if(jump){
    if (key == 'W'||key == 'w'){
      forJump = true;
    }
  }
}

void mousePressed(){
  if(startGame==true){
    if(mouseX<750 || mouseY>150){
      if(shot){
        gunsound = m.loadFile("gun.mp3");
        gunsound.play();
        bullet[B]=new Bullet();
        B++;
        if(B==50){
          for(int i=0;i<bulletNum-1;i++)
            bullet[i] = bullet[i+1];
          B=49;
        }
      }
    
      if(fist){
        fistsound = m.loadFile("fist.mp3");
        fistsound.play();
        showfatk = true;
        image(fistAttack,gayX,gayY,gayWidth+30,gayWidth);
      }
      
      if(swordatk){
        swordsound = m.loadFile("sword.mp3");
        swordsound.play();
        showsatk = true;
        image(swAttack,gayX+20,gayY,gayWidth+30,gayWidth);
      }
    }
  
    if(mouseX >= 750 && mouseX <= 800 && mouseY >= 0 && mouseY <= 50){
        mancondition = gay;
        shot = false;
        swordatk = false;
        fist = true;  
    }
    if(mouseX >= 750 && mouseX <= 800 && mouseY >= 50 && mouseY <= 100){
        mancondition = swordgay;
        shot = false;
        swordatk = true;
        fist = false;  
    }
    if(mouseX >= 750 && mouseX <= 800 && mouseY >= 100 && mouseY <= 150){
        mancondition = gungay;
        shot = true;
        swordatk = false;
        fist = false;  
    }
  }
}
void draw(){
  if(startGame){
    background(255);
    image(back,0,0,800,600);
    if(gayLife==false){
      if(score<50){
        //print score**
        shot = false;
        swordatk = false;
        fist = false;
        
        fill(0);
        textSize(40);
        text("Only kill: "+score+" monsters",50,100);
        //**print score
      
        textSize(100);
        text("You are Loser !",50,250);
        
        fill(255);
        rect(440,380,65,50);
        fill(0);
        textSize(20);
        text("again",450,410);
        if(mousePressed==true && mouseButton==LEFT && mouseX>=440 && mouseX<=505 && mouseY>=320 && mouseY<=430){
          startGame= false;
         
        }
      }
      else if(score>=50 && bossLife==true){
        shot = false;
        swordatk = false;
        fist = false;
        
        fill(0);
        textSize(40);
        text("Try again",50,100);
        fill(255);
        rect(440,380,65,50);
        fill(0);
        textSize(20);
        text("again",450,410);
        if(mousePressed==true && mouseButton==LEFT && mouseX>=440 && mouseX<=505 && mouseY>=320 && mouseY<=430){
          startGame= false;
         
        }
      }
      else if(score>=50 && bossLife==false){
        shot = false;
        swordatk = false;
        fist = false;
        
        fill(0);
        textSize(40);
        text("Tie",50,100);
        shot = false;
        swordatk = false;
        fist = false;
      }
      
    }
    else if(bossLife==false){
      shot = false;
      swordatk = false;
      fist = false;
      
      textSize(100);
      text("Congratulation!",50,250);
    }
    else if(score>=50 && bossLife==true){
      littlesound.pause();
      bosssound.play();
      //HP**
      fill(255,0,0);
      rect(10,10,HP,20);
      rect(bossHP,10,750-bossHP,20);
      //**HP
      
      //ground**  
      fill(0);
      rect(0,600-groundH,800,100);
      //**ground
      
      //change weapon**
      fill(255);
      image(stone,750,0,50,50);
      image(sword,750,50,50,50);
      image(gun,750,100,50,50);
      //**change weapon
      
      //gayMove**
      if(forJump){
        gayY -= step;
        if(moveRight){
          if(gayX>=800-gayWidth)
            gayX=800-gayWidth;
          else
            gayX+=10;
        }
        if(moveLeft){
          if(gayX<=0)
            gayX=0;
          else
            gayX-=10;
        }  
        if(gayY <= 600-groundH-gayWidth*2-50){
          step*=-1;
        }
        if(gayY == 600-groundH-gayWidth+20){
          forJump = false;
          step = 10;
          moveRight = false;
          moveLeft = false;
        }
      }  
      //**gayMove
        
      //man **
      if(gayLife==true)
        image(mancondition,gayX,gayY,gayWidth,gayWidth);
      //**man
      
      //bullet out of screen**
      for(int i=0;i<B;i++){
        if(bullet[i].getX()>=800)
          bullet[i].setLife(false);
      }
      //**bullet out of screen
      
      //bullet shoot**
      for(int i=0;i<B;i++)
        bullet[i].shoot();
      //**bullet shoot
      
      //Bbullet out of screen**
      for(int i=0;i<BbulletNum;i++){
        if(BbulletX[i]<0-BbulletWidth)
          BbulletLife[i]=false;
      }
      //**Bbullet out of screen
      
      //Bbullet move**
      for(int i=0;i<BbulletNum;i++){
        if(BbulletLife[i]==true){
          image(Bbullet,BbulletX[i],BbulletY[i],BbulletWidth,BbulletWidth);
            BbulletX[i] -= 5;
        }
      }
      //**Bbullet move
      
      //Bbullet's statement move in array***
      for(int i=0;i<BbulletNum;i++){
        if(BbulletLife[i]==false){
          if(i<BbulletNum-1){
            for(int j=i;j<BbulletNum;j++){
              if(j<BbulletNum-1){
                BbulletLife[j]=BbulletLife[j+1];
                BbulletX[j]=BbulletX[j+1];
                BbulletY[j]=BbulletY[j+1];
              }
              else{
                BbulletX[j]=(int)random(800,1600);
                BbulletY[j]=600-groundH-BbulletWidth; 
                BbulletLife[j]=true; 
              }
            }
          }
          else{
            BbulletX[i]=(int)random(800,1600);
            BbulletY[i]=600-groundH-BbulletWidth;
            BbulletLife[i]= true;
          }
        }
      }
      //***Bbullet's statement move in array
      
      
      //boss**
      if(bossLife==true){
        image(boss,bossX,bossY,bossWidth,bossWidth);
      }
      //**boss
      
      
      //bullet and Bbullet touch**
      for(int i=0;i<B;i++){
        for(int j=0;j<BbulletNum;j++){
          if( (bullet[i].getLife()==true) && (BbulletLife[j]==true) && (bullet[i].getX()>=BbulletX[j]) && (bullet[i].getX()<=BbulletX[j]+100) && (bullet[i].getY()<=BbulletY[j]+100) && (bullet[i].getY()>=BbulletY[j]) ){
            bullet[i].setLife(false);
            BbulletLife[j]=false;
            
          }
        }
      }
      //**bullet and Bbullet touch
      
  
      
      //bossHP**
  
      bossHurtNum=0;
      for(int i=0;i<B;i++){
        if( (bullet[i].getLife()==true) ){
          if( (bullet[i].getX()>=bossX) && ((bullet[i].getX()-bossX) <=bossWidth) && (bullet[i].getY()>=bossY) && (bullet[i].getY()-bossY<=bossWidth)){
            bullet[i].setLife(false);
            bossHurtNum++; 
          }
        }
      }
      //boss Bbullet with fist**
      if(showfatk){
        if( (bossX>=gayX) && ((bossX-gayX)<gayWidth+45) && (gayY>=bossY) && (gayY<=bossY+bossWidth) ){
          bossHurtNum++;
        }
        
        for(int i=0;i<BbulletNum;i++){
          if( (BbulletLife[i]==true) && (BbulletX[i]>=gayX) && ((BbulletX[i]-gayX)<gayWidth+45) ){
            BbulletLife[i]=false;
            
          }
        }
        
        showfatk = false;
      }
      //**boss Bbullet with fist
      
      //boss Bbullet with sword**
      if(showsatk){
        if( (bossX>=gayX) && ((bossX-gayX)<gayWidth+70) && (gayY>=bossY) && (gayY<=bossY+bossWidth) ){
          bossHurtNum+=10;
        }
        for(int i=0;i<BbulletNum;i++){
          if( (BbulletLife[i]==true) && (BbulletX[i]>=gayX) && ((BbulletX[i]-gayX)<gayWidth+70) ){
            BbulletLife[i]=false;
          }
        }
        
        showsatk = false;
      }
      //**boss Bbullet with sword
      
      
      if(bossHP>0 && bossHP<750){
        bossHP+=bossHurtNum;
      }
      else if(bossHP>=750){
        bossLife=false;
      }
      fill(255,0,0);
      rect(bossHP,10,750-bossHP,20);
  
      //bossHP**
      
      //HP statement**
      hurtNum=0;
      for(int i=0;i<BbulletNum;i++){
        if(BbulletLife[i]==true){
          if((BbulletX[i]>=gayX) && (BbulletX[i]-gayX<=gayWidth) && (BbulletY[i]-gayY<=gayWidth))
            hurtNum++;
        }
      }
      if(HP>0){
        HP-=hurtNum;
      }
      else{
        HP=0;
        gayLife=false;
      }
      fill(255,0,0);
      rect(10,10,HP,20);
      //**HP statement
    }
    
    else{
      littlesound.play();
      //HP**
      fill(255,0,0);
      rect(10,10,HP,20);
      //**HP
        
      //ground**  
      fill(0);
      rect(0,600-groundH,800,100);
      //**ground
        
      //change weapon**
      fill(255);
      image(stone,750,0,50,50);
      image(sword,750,50,50,50);
      image(gun,750,100,50,50);
      //**change weapon
      
      //gayMove**
      if(forJump){
        gayY -= step;
        if(moveRight){
          if(gayX>=800-gayWidth)
            gayX=800-gayWidth;
          else
            gayX+=10;
        }
        if(moveLeft){
          if(gayX<=0)
            gayX=0;
          else
            gayX-=10;
        }  
        if(gayY <= 600-groundH-gayWidth*2-50){
          step*=-1;
        }
        if(gayY == 600-groundH-gayWidth+20){
          forJump = false;
          step = 10;
          moveRight = false;
          moveLeft = false;
        }
      }  
      //**gayMove
        
      //man **
      if(gayLife==true)
        image(mancondition,gayX,gayY,gayWidth,gayWidth);
      //**man
      
      
      //enemy out of screen**
      for(int i=0;i<enemyNum;i++){
        if(enemyX[i]<=0-enemywidth)
          enemyLife[i]=false;
      }
      //**enemy out of screen
      
      //enemy move**
      for(int i=0;i<enemyNum;i++){
        if(enemyLife[i]==true){
          image(enemy,enemyX[i],enemyY[i],enemywidth,enemywidth);
            enemyX[i] -= 5;
        }
      }
      //**enemy move
      
      //enemy's statement move in array***
      for(int i=0;i<enemyNum;i++){
        if(enemyLife[i]==false){
          if(i<enemyNum-1){
            for(int j=i;j<enemyNum;j++){
              if(j<enemyNum-1){
                enemyLife[j]=enemyLife[j+1];
                enemyX[j]=enemyX[j+1];
                enemyY[j]=enemyY[j+1];
              }
              else{
                enemyX[j]=(int)random(800,1600);
                enemyY[j]=600-groundH-enemywidth; 
                enemyLife[j]=true; 
              }
            }
          }
          else{
            enemyX[i]=(int)random(800,1600);
            enemyY[i]=600-groundH-enemywidth;;
            enemyLife[i]= true;
          }
        }
      }
      //***enemy's statement move in array
      
      //bullet out of screen**
      for(int i=0;i<B;i++){
        if(bullet[i].getX()>=800)
          bullet[i].setLife(false);
      }
      //**bullet out of screen
      
      //bullet shoot**
      for(int i=0;i<B;i++)
        bullet[i].shoot();
      //**bullet shoot
      
      //bullet and enemy touch**
      for(int i=0;i<B;i++){
        for(int j=0;j<enemyNum;j++){
          if( (bullet[i].getLife()==true) && (enemyLife[j]==true) && (bullet[i].getX()>enemyX[j]) && (bullet[i].getX()<enemyX[j]+100) && (bullet[i].getY()<enemyY[j]+100) && (bullet[i].getY()>enemyY[j]) ){
            bullet[i].setLife(false);
            enemyLife[j]=false;
            score++;
          }
        }
      }
      //**bullet and enemy touch
      
      //enemy with fist**
      if(showfatk){
        for(int i=0;i<enemyNum;i++){
          if( (enemyLife[i]==true) && (enemyX[i]>=gayX) && ((enemyX[i]-gayX)<gayWidth+45) ){
            enemyLife[i]=false;
            score++;
          }
        }
        showfatk = false;
      }
      //**enemy with fist
      
      //enemy with sword**
      if(showsatk){
        for(int i=0;i<enemyNum;i++){
          if( (enemyLife[i]==true) && (enemyX[i]>=gayX) && ((enemyX[i]-gayX)<gayWidth+70) ){
            enemyLife[i]=false;
            score++;
          }
        }
        showsatk = false;
      }
      //**enemy with sword
      
      
      //print score**
      fill(0);
      text("kill:"+score,50,50);    
      //**print score
      
      //HP statement**
      hurtNum=0;
      for(int i=0;i<enemyNum;i++){
        if(enemyLife[i]==true){
          if((enemyX[i]>=gayX) && (enemyX[i]-gayX<=gayWidth) && (enemyY[i]-gayY<=gayWidth))
            hurtNum++;
        }
      }
      if(HP>0){
        HP-=hurtNum;
      }
      else{
        HP=0;
        gayLife=false;
      }
      fill(255,0,0);
      rect(10,10,HP,20);
      //**HP statement
    }
  }
  
  else{
    image(once,0,0,800,600);
    fill(255);
    rect(370,320,65,50);
    fill(0);
    textSize(20);
    text("start",380,350);
    if(mousePressed==true && mouseButton==LEFT && mouseX>=370 && mouseX<=435 && mouseY>=320 && mouseY<=370){
      startGame= true;
      fist = true;
      score=0;
      hurtNum=0;
      HP=200;
      gayX=20;
      gayY=600-groundH-gayWidth+20;
      gayLife=true;
      B=0;
      bossHP=500;
      bossHurtNum=0;
      bossLife=true;
      mancondition = gay;
      
      //game start random enemy**
      for(int i=0;i<enemyNum;i++){
        enemyX[i]=(int)random(800,1600);
        enemyY[i]=600-groundH-enemywidth;
        enemyLife[i] = true;
      }
      //**game start random enemy
      
      //game start random Bbullet**
      for(int i=0;i<BbulletNum;i++){
        BbulletX[i]=(int)random(800,1600);
        BbulletY[i]=600-groundH-BbulletWidth;
        BbulletLife[i] = true;
      }
      //**Bbullet start random enemy

    }
  }  
}

class Bullet{
  int bLength=5;
  int bX=gayX+gayWidth-20;
  int bY=gayY+45;
  boolean life=true;

  Bullet(){
  }

  void shoot(){
    if(life==true){
      strokeWeight(4);
      stroke(255,0,0);
      line(bX,bY,bX+bLength,bY);
      bX+=3;
    }
    stroke(0);
    strokeWeight(1);
  }
  
  boolean getLife(){
    return life;
  }

  int getY(){
    return bY;
  }

  int getX(){
    return bX;
  }

  void setLife(boolean a){
    life = a;
  }
}

