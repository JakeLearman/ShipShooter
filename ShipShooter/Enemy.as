//This is the basic form for all classes
package
	{
		//Content needs to be imported so the script works
		//This imports any movie clips from the library
		import flash.display.MovieClip;
		//This imports any events written in the source script
		import flash.events.*;
		//this just means that Enemy will act like a MovieClip
		
		//This applies the class Enemy to its movieclip counterpart
		public class Enemy extends MovieClip
			{
				//This assigns the value _root so it can be referenced more easily
				private var _root:Object;
				//This sets the speed of the enemy ship to 7
				private var speed:int = 7; 
					
			//This will run whenever an enemy is added to the stage
			public function Enemy()
				{
					//This listens for MCmain and runs corresponding functions
					addEventListener(Event.ADDED, beginClass);
					//This listens for when the Enemy ship joins the stage and runs corresponding functions
					addEventListener(Event.ENTER_FRAME, eFrame);
				}
		
		//This function runs when MCmain join the stage
		private function beginClass(event:Event):void
			{
				//This assigns the root of this file its object counterpart in the library
				_root = MovieClip(root);
			}
			
		//This function runs when the ship enters the frame
		private function eFrame(event:Event):void
			{
				//This moves the spaceship down the screen
				y += speed;
				//This removes the spaceship if it goes off the stage 
				if(this.y > stage.stageHeight)
					{
						//This removes the event listeners looking for ship which are off frame
						removeEventListener(Event.ENTER_FRAME, eFrame);
						//This removes the physical child of the stage
						_root.removeChild(this);
					}
			
				//This will check if the amount of bullets equal the amount of bullet container, if not it will increment by 1
				for(var i:int = 0;i<_root.bulletContainer.numChildren;i++)
					{
						//This variable hold the bullet which is currently being tested for hit detection.
						var bulletTarget:MovieClip = _root.bulletContainer.getChildAt(i);
						
						//This if statement performs code if a hit is detected
						if(hitTestObject(bulletTarget))
							{
								//This will event listener looking for the hit spaceship
								removeEventListener(Event.ENTER_FRAME, eFrame);
								//This will remove the spaceship which is hit by the bullet
								_root.removeChild(this);
								//This will remove the bullet container which hits the spaceship
								_root.bulletContainer.removeChild(bulletTarget);
								//This removes the event listener looking for the bullet
								bulletTarget.removeListeners();
								//This increases the score by 1
								_root.score += 1;
							}
					}
			
				//This checks that the enemy spaceship has hit the player's ship
				//This if statement checks if the hitTestObject has hit mcMain   
				if(hitTestObject(_root.mcMain))
					{
						//This deducts 1 life point from the player's ship
						_root.lives -- ;
						//This if statement checks if the player has any health left i.e. health equal to zero
						if (_root.lives == 0)
							{	
								//If the statement is true then the game will stop
								_root.gameOver = true;
								//This will send the player to the game over screen
								_root.gotoAndStop('lose');
							}
					}
				//This if statement will check if the game is over
				if(_root.gameOver)
					{
						//This will remove the event listeners looking for spaceship
						removeEventListener(Event.ENTER_FRAME, eFrame);
						//This will remove all enemy spaceships from the scene
						this.parent.removeChild(this);
					}
			}
			//This function removes all event listeners effectively stopping anything from spawning in.
			public function removeListeners():void
				{
					//This will remove any active event listeners
					this.removeEventListener(Event.ENTER_FRAME, eFrame);
				}
		}
	}