#include <stdio.h>
#include <conio.h>
#include <math.h>

int currX, currY, newX, newY, x, y, memX, memY, mouseButtons, buttons;
int temp;
int scale = 5;
int minX = 1;
int minY = 1;
int maxX = 80;																																						      ;
int maxY = 25;
int oneOrTwo = 0;
char cursor = '*';
char quit = 1;

void getMouseState(int* x, int* y, int* buttonsState)
{
	int tempX;
	int tempY;
	int tempB;
	asm{
		mov ax, 3 ;
		int 33h ;
		mov tempX, cx ;		//X
		mov tempY, dx ;		//Y
		mov tempB, bx ;		//state
	}
	*x = tempX;
	*y = tempY;
	*buttonsState = tempB;

	if (tempX > 600 || tempX < 20 || tempY < 20 || tempY > 180)
	{
		asm{
			mov ax, 4
			mov cx, 100
			mov dx, 100
			int 33h
		}
		currX = 100;
		currY = 100;
		*x = currX;
		*y = currY;
	}
}

void showCursor()
{
	clrscr();
	gotoxy(x, y);
	printf("%c", cursor);
}

void setCenter()
{
	x = maxX / 2;
	y = maxY / 2;
}


void main()
{
	clrscr();
	asm{
		mov ah, 0 //set video mode, clear screen
		mov al, 3 //type - text, format - 80*25,color tone
		int 10h		//video service
		mov ah, 1 //set cursor
		mov cx, 2607h //hide cursor
		int 10h
		int 10h
		mov ax, 0 //mouse drive initialize
		int 33h
		mov temp, ax //return mouse status
	}
	if (temp != 0)
	{
		buttons = 0;
		//setCenter();
		getMouseState(&currX, &currY, &buttons);
		showCursor();
		while (quit)
		{
			getMouseState(&newX, &newY, &mouseButtons);
			if ((abs(newX - currX) > scale) || (abs(newY - currY) > scale))  //if mouse was moved
			{
				if (newX < currX) //left
				{
					x -= (abs(newX - currX) / scale);
					//x += (abs(newX - currX) / scale);//right

				}
				else //right
				{
					x += (abs(newX - currX) / scale);
					//x -= (abs(newX - currX) / scale); //left
					//y += (abs(newX - currX) / scale); //down
				}

				if (newY < currY) //up
				{
					y -= (abs(newY - currY) / scale); //up
				}
				else  //down
				{
					y += (abs(newY - currY) / scale); 
					//y -= (abs(newY - currY) / scale); //up
					//x -= (abs(newY - currY) / scale); //left
				}

				//border X
				if (x < minX)
				{
					x = maxX;
				}
				if (x > maxX)
				{
					x = minX;
				}
				//border Y
				if (y < minY)
				{
					y = maxY;
				}
				if (y > maxY)
				{
					y = minY;
				}
				currX = newX;
				currY = newY;
				showCursor();
			}

			if ((mouseButtons == 0) && (buttons == 2)) //010 - released right mouse button
			{
				quit = 0;
			}
			
			if ((mouseButtons == 0) && (buttons == 1)) //001 - released left mouse button
			{
				if (cursor == '#')
				{
					cursor = '*';
				}
				else
				{
					cursor = '#';
				}
				showCursor();
			}
			
			
			if ((mouseButtons == 0) && (buttons == 4)) //100 - released right mouse button
			{
				x = maxX / 2;
				y = maxY / 2;
					
					
			}
			
			/*
			if ((mouseButtons == 0) && (buttons == 1)) //100 - released right mouse button
			{
				
				if(oneOrTwo == 0){
				memX = x;
				memY = y;
				oneOrTwo = 1;
				}else{
				x = memX;
				y = memY;
				oneOrTwo = 0;
				}
				
				showCursor();		
			}
			*/
			buttons = mouseButtons;
		}
	}
}