
space[][] level;

int row=40;
int col=40;
int texty=15;
int textxplus=13;
int textyplus=13;
int textx=15;

//if its true turn false;
boolean turn;

//setup
public void setup(){
size(800,800);

level= new space[row][col];
createSpace();
createGrass();
createStonewall();


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
				

					if(keyCode==myUp){

					}
					if(keyCode==myDown){
						
					}
					if(keyCode==myLeft){
						
					}
					if(keyCode==myRight){
						
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

public void updateall(){
	for(int i =0;i<row;i++){
    	for(int r=0;r<col;r++){
    		if(level[i][r].solidcheck==true){
    			if(level[i][r].solidtype=="stonewall"){
    				((stonewall)level[i][r].solid).update();
    				
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

void keyPressed(){


}