
space[][] level;

int row=40;
int col=40;

//setup
public void setup(){
size(400,400);

level= new space[row][col];
createSpace();


}

//draw
public void draw(){
background(255);


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
Object ground;

public space(int x, int y){
myX=x;
myY=y;
groundcheck=false;

}


}


//class for everything on board
class exist{
	int myX, myY;



}



//parent for all ground objects
class ground extends exist{
String symbol;

	
}
//grass
	class grass extends ground{

		public grass(int x, int y){
			myX=x;
			myY=y;
			symbol=",";

		}
	
	}

public void createGrass(){

	for(int i =0;i<row;i++){
    	for(int r=0;r<col;r++){

    		level[i][r].groundcheck=true;      
    		level[i][r].ground= new grass(i,r);  
    	}
	}




}