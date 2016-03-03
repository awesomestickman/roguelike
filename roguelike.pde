
space[][] level;

int row=40;
int col=40;
int texty=15;
int textxplus=13;
int textyplus=13;
int textx=15;
//so you dont spam the keys
boolean keyreset=true;

//if its true turn false;
boolean turn;

//setup
public void setup(){
size(800,800);

level= new space[row][col];
createSpace();
createGrass();
createStonewall();
createPlayer();

}

//draw
public void draw(){
background(255);
updateall();




}
//create level
public void createSpace(){


	for(int i =0;i<row;i++){
    	for(int r=0;r<col;r++){

    		level[i][r]=new space(i,r);        
    	}
	}




}



//class for grid container
class space{

int myX,myY;
boolean groundcheck;
String groundtype;
Object ground;
boolean solidcheck;
String solidtype;
Object solid;

public space(int x, int y){
myX=x;
myY=y;


}


}


//class for everything on board
class exist{
	int myX, myY;
	String symbol;


	public void drawself(){
		fill(0);
		textSize(20);
		text(symbol,myX*textx+textxplus,myY*texty+textyplus);
	}
	public void update(){


		this.drawself();
	}
}



//parent for all ground objects
class ground extends exist{


	
}
//grass
	class grass extends ground{

		public grass(int x, int y){
			myX=x;
			myY=y;
			symbol=",";

		}
		public void drawself(){
			fill(0,153,0);
			textSize(20);
			text(symbol,myX*textx+textxplus,myY*texty+textyplus);
		}
	
	}

//for chars and walls
class solid extends exist{




}
	class character extends solid{
		int newX, newY;
		boolean moving;

		public void move(){
			if(moving==true){
				if(isValid(newX,newY)){
					if(level[newX][newY].solidcheck==false){


						level[myX][myY].solidcheck=false;     
						myX=newX;
						myY=newY;
						level[myX][myY].solidcheck=true;     
						level[myX][myY].solidtype="player"; 
						level[myX][myY].solid=this;



					}
				}	
				moving=false;
			}


		}


	}
		class wolf extends character{

			public wolf(int x, int y){
				myX=x;
				myY=y;
				symbol="w";
			}




		}
		class player extends character{

				int myUp;
				int myDown;
				int myLeft;
				int myRight;


			public player(int x, int y,int up,int down,int left,int right){
				myX=x;
				myY=y;
				symbol="@";
				myUp=up;
				myDown=down;
				myLeft=left;
				myRight=right;
			}
			public void update(){

				this.drawself();
				this.keyReader();
				if(turn==true){
					this.move();
				}

			}
			public void keyReader(){
				if(keyPressed&&keyreset){

					if(keyCode==myUp){

						this.newX=myX;
						this.newY=myY-1;
						
					}
					if(keyCode==myDown){
						this.newX=myX;
						this.newY=myY+1;
					}
					if(keyCode==myLeft){
						this.newX=myX-1;
						this.newY=myY;
					}
					if(keyCode==myRight){
						this.newX=myX+1;
						this.newY=myY;
					}
					moving=true;
						turn=true;
					keyreset=false;

				}


			}



		}

	class wall extends solid{





	}
		class stonewall extends wall{
			public stonewall(int x, int y){

				myX=x;
				myY=y;
				symbol="#";
			}

		}



public void createGrass(){

	for(int i =0;i<row;i++){
    	for(int r=0;r<col;r++){

    		level[i][r].groundcheck=true;     
    		level[i][r].groundtype="grass"; 
    		level[i][r].ground= new grass(i,r);  
    		
    	}
	}
}

public void createStonewall(){
		for(int i =0;i<row;i++){
	    	for(int r=0;r<col;r++){
	    		int chance=(int)(Math.random()*7);
	    		if(chance==6){

	    		level[i][r].solidcheck=true;     
	    		level[i][r].solidtype="stonewall"; 
	    		level[i][r].solid= new stonewall(i,r);  
	    		}
	    	}
		}


}
public void createWolf(){

}
public void createPlayer(){
	int spawnx=col/2;
	int spawny=row/2;

	level[spawnx][spawny].solidcheck=true;     
	level[spawnx][spawny].solidtype="player"; 
	level[spawnx][spawny].solid= new player(spawnx,spawny,38,40,37,39);
}
////////////////////////////////////////////////////////////////////////
public void updateall(){
	for(int i =0;i<row;i++){
    	for(int r=0;r<col;r++){
    		if(level[i][r].solidcheck==true){
    			if(level[i][r].solidtype=="stonewall"){
    				((stonewall)level[i][r].solid).update();
    				
    				}
    			if(level[i][r].solidtype=="player"){
    				((player)level[i][r].solid).update();
    				
    				}
    			





    		}



    		else if(level[i][r].groundcheck==true){
    				if(level[i][r].groundtype=="grass"){
    				((grass)level[i][r].ground).update();
    				
    				}




    			

    		}      
    		  
    	}
	}

if(turn==true){

	turn =false;
}



}

public boolean isValid(int x,int y){

	if(x<col&&x>-1&&y>-1&&y<row){
		return true;
	}

	return false;
}


public void keyReleased(){

	keyreset=true;
}