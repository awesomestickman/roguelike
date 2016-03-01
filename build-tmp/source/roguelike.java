import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class roguelike extends PApplet {


space[][] level;

int row=40;
int col=40;

//setup
public void setup(){


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
  public void settings() { 
size(400,400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "roguelike" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
