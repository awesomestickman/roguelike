
space[][] level;

int row=40;
int col=40;

//setup
public void setup(){
size(400,400);

level= new space[row][col];
createSpace();
createGrass();


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
		text(symbol,myX*8+10,myY*8+10);
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
			text(symbol,myX*8+10,myY*8+10);
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

public void updateall(){
	for(int i =0;i<row;i++){
    	for(int r=0;r<col;r++){

    		if(level[i][r].groundcheck==true){
    			if(level[i][r].groundtype=="grass"){
    				((grass)level[i][r].ground).update();
    				
    			}




    			

    		}      
    		  
    	}
	}



}