//This is the base format of a class
package
	{
		//Content needs to be imported so the script works
		//This imports any movie clips from the library
		import flash.display.MovieClip;
		//This imports any events written in the source script
		import flash.events.*;
		
		//this applies the class bullet a movieclip
		public class Bullet extends MovieClip
			{
				//This assigns the value _root so it can be referenced more easily
				private var _root:Object;
				//This gives each bullet the damage value of 1
				private static var damage:int = 1;
				//This sets the speed of the bullet
				private var speed:int = 10;
				
				//This function runs whenever a bullet is added to the stage
				public function Bullet()
					{
						//This adds events to the class, they will only run when the MCmain is on the stage
						addEventListener(Event.ADDED, beginClass);
						//functions that will run on enter frame
						addEventListener(Event.ENTER_FRAME, eFrame);
					}
				//This function will run when McMain is on the stage		
				private function beginClass(event:Event):void
					{
						//This assigns _root to the movie clips "bullet"
						_root = MovieClip(root);
					}
				//This function runds when a bullet enters the fame
				private function eFrame(event:Event):void
					{
						//This movies the bullet up the screen
						y -= speed;
						//This will remove any bullets that go off screen 
						if(this.y < -1 * this.height)
							{
								//This removes any event listeners for bullets off screen
								removeEventListener(Event.ENTER_FRAME, eFrame);
								//This removes the graphics representation of the bullet
								_root.bulletContainer.removeChild(this);
							}
			
							//This if statement will run if the condition of the game being over is met
							if(_root.gameOver)
								{
									//This will remove any bullets that are entering the frame
									removeEventListener(Event.ENTER_FRAME, eFrame);
									//This will all bullets from the screen
									this.parent.removeChild(this);
								}
					}
					//This function removes all event listeners effectively stopping any bullets from spawning in.
					public function removeListeners():void
					{
						//This removes any active event listeners on frame entry
						removeEventListener(Event.ENTER_FRAME, eFrame);
					}
			}
	}