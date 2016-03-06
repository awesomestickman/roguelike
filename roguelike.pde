
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
boolean keyHolder;


//setup
public void setup(){
size(800,800);

level= new space[row][col];
createSpace();
createGrass();
createStonewall();
createRacoon();
createDino();
createPlayer();

}

//draw
public void draw(){
background(255);
//background(0);
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
///pathfinding help
boolean checked;


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
		//fill(255);
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
boolean myTurn;



}
	class character extends solid{
		int newX, newY;
		boolean moving;
		

		public void move(){

			if(moving==true){

				if(isValid(newX,newY)){
					if(level[newX][newY].solidcheck==false){

						String typeHolder=level[myX][myY].solidtype;
						level[myX][myY].solidcheck=false;     
						myX=newX;
						myY=newY;
						level[myX][myY].solidcheck=true;     
						level[myX][myY].solidtype=typeHolder; 
						level[myX][myY].solid=this;
						myTurn=false;


					}
				}	
				moving=false;
			}


		}
		public void update(){

			this.drawself();
			
			if(myTurn==true){
				this.ai();
				//System.out.println(newX+" "+newY);
				this.move();
				myTurn=false;
				
			}

		}
		public void ai(){


		}


	}
		class racoon extends character{

			public racoon(int x, int y){
				myX=x;
				myY=y;
				symbol="r";
			}

			public void ai(){
				moving=true;
				int randNum=(int)(Math.random()*4);
				
					if(randNum==0){
						newX=myX-1;
						newY=myY;

					}
					if(randNum==1){
						newX=myX+1;
						newY=myY;
						
					}
					if(randNum==2){
						newX=myX;
						newY=myY-1;
						
					}
					if(randNum==3){
						newX=myX;
						newY=myY+1;
						
					}

				}


			


		}
		class dino extends character{
			int nextx=-1;
			int nexty=-1;
			public dino(int x, int y){
				myX=x;
				myY=y;
				symbol="d";
			}
			public void ai(){
				moving=true;
				int targetx=myX;
				int targety=myY;
				if( (Math.abs(targetx-myX)==1&&targety==myY)||
					(Math.abs(targety-myY)==1&&targetx==myX) ){
					newX=targetx;
					newY=targety;
					nextx=-1;

				}

				else if(nextx>=0){
					newX=nextx;
					newY=nexty;
					nextx=-1;
				}
				else{
					
						for(int i =0;i<row;i++){
		    				for(int r=0;r<col;r++){
		    					if(level[i][r].solidcheck==true){
		    						if(level[i][r].solidtype=="player"){
	    								targetx=((player)level[i][r].solid).myX;
	    								targety=((player)level[i][r].solid).myY;
	    				
	    							}
		    					}    
		    		  
		    				}
						}
					
					int[] currentpos={myX,myY};	
					node startoff=new node(currentpos);
					int[] pathfound=bfs(startoff,targetx,targety);
					if(pathfound.length==4){
						newX=pathfound[0];
						newY=pathfound[1];
						nextx=pathfound[2];
						nexty=pathfound[3];
					
					}
					//uh hopefully solves some pathfinding bugs
					if(targety<myY){
						int gen=(int)(Math.random()*2);
						if(gen==0){

							newX=myX;
							newY=myY-1;
							nextx=-1;
						}

					}
				}

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
				if(myTurn==true){
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
public void createRacoon(){
			for(int i =0;i<row;i++){
		    	for(int r=0;r<col;r++){
		    		int chance=(int)(Math.random()*200);
		    		if(chance==6){

		    		level[i][r].solidcheck=true;     
		    		level[i][r].solidtype="racoon"; 
		    		level[i][r].solid= new racoon(i,r);  
		    		}
		    	}
			}
}
public void createDino(){
			for(int i =0;i<row;i++){
		    	for(int r=0;r<col;r++){
		    		int chance=(int)(Math.random()*200);
		    		if(chance==6){

		    		level[i][r].solidcheck=true;     
		    		level[i][r].solidtype="dino"; 
		    		level[i][r].solid= new dino(i,r);  
		    		}
		    	}
			}
			// int whev=15;
			// level[whev][whev].solidcheck=true;     
		 // 	level[whev][whev].solidtype="dino"; 
		 // 	level[whev][whev].solid= new dino(whev,whev);  
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
	if(keyHolder==false){


	
		if(keyPressed){
			turn=true;
			keyHolder=true;
		}
	}	
	//turn good
	if(turn==true){
		for(int i =0;i<row;i++){
	    	for(int r=0;r<col;r++){
	    		if(level[i][r].solidcheck==true){
	    			((solid)level[i][r].solid).myTurn=true;

	    		}    
	    		  
	    	}
		}
	}	
	//update
	for(int i =0;i<row;i++){
    	for(int r=0;r<col;r++){
    		if(level[i][r].solidcheck==true){
    			if(level[i][r].solidtype=="stonewall"){
    				((stonewall)level[i][r].solid).update();
    				
    				}
    			if(level[i][r].solidtype=="player"){
    				((player)level[i][r].solid).update();
    				
    				}
    			if(level[i][r].solidtype=="racoon"){
    				((racoon)level[i][r].solid).update();
    				
    				}
    			if(level[i][r].solidtype=="dino"){
    				((dino)level[i][r].solid).update();
    				
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
	keyHolder=false;
}


class node{
	int[] position={0,0};
	Object myParent;
	boolean hasparent;
	node(int[] coords, Object parent){
		position=coords;
		myParent=parent;
		hasparent=true;
	}
	node(int[] coords){
		position=coords;
		hasparent=false;
	}
}

public int[] bfs(Object start,int goalx,int goaly){
	///bredth first search
	//problem:depends on order of nodes because he may just cahnge his course once he goes 
	//to the next square in a sequence, sending him back to start rip
	int x;
	int y;

	boolean goalcheck=false;
	
	Object goalnode=start;
	Object nextstepnode=start;
	Object secondstep=start;
	for(int i =0;i<row;i++){

    	for(int r=0;r<col;r++){
    		level[i][r].checked=false;
    	}
    }     
	int[] returner = {
		((node)start).position[0], 
		((node)start).position[1],
		((node)start).position[0],
		((node)start).position[1]};
	ArrayList <node> theList= new ArrayList <node>();
	ArrayList <node> thePath= new ArrayList <node>();
	theList.add(((node)start));
	while(theList.size()>0){
		
		node tempNode=theList.get(0);
		theList.remove(0);
		level[tempNode.position[0]][tempNode.position[1]].checked=true;

		y=tempNode.position[1];
		x =tempNode.position[0];


		int where=0;
		if(theList.size()>1){
		 	
			where=theList.size()-1;
			
				    						
		}
			for(int i =y-1;i<y+2;i++){

		    	for(int r=x-1;r<x+2;r++){
		    		//only concerned with certain tiles
		    		if( (r==x-1&&i==y)||
		    			(r==x+1&&i==y)||
		    			(r==x&&i==y+1)||
		    			(r==x&&i==y-1)){


			    				//if checked

			    			if(isValid(r,i)){
			    				if(level[r][i].solidtype!="stonewall"
			    					&&level[r][i].solidtype!="racoon"){
				    				if(level[r][i].checked==false){
				    					level[r][i].checked=true;
				    					int[] newcoord={r,i};
				    					if(newcoord[0]==goalx&&newcoord[1]==goaly){
				    						goalcheck=true;
				    						////maybe finicky for attack
				    						goalnode=tempNode;
				    						break;
				    					}
				    						
				    						theList.add(where,new node(newcoord,tempNode));
				    					


				    				}
								}
							}
				  	}		
				}
			}
	}

	if(goalcheck==true){

		while(((node)goalnode).hasparent==true){
			thePath.add(0,(node)goalnode);
			goalnode=((node)goalnode).myParent;

		}
		if(thePath.size()>0){
			nextstepnode=thePath.get(0);
			if(thePath.size()>1){
				secondstep=thePath.get(1);
			}
			//lol go all the way out then back in
			// for(int i=0;i<thePath.size();i++){

			// 	node debug=thePath.get(i);
			// 	System.out.println(i+" "+((node)debug).position[0]+","+((node)debug).position[1]);
			// }
		}
		returner[0]=((node)nextstepnode).position[0];
		returner[1]=((node)nextstepnode).position[1];
		returner[2]=((node)secondstep).position[0];
		returner[3]=((node)secondstep).position[1];
		
		
	}


	return returner;
}