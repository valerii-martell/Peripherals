#include <stdio.h>
#include <intrin.h>
#include <conio.h>
#include <math.h>
#include <dos.h>
#include <windows.h>

#define EAX 0
#define EBX 1
#define ECX 2
#define EDX 3

int currX, currY, newX, newY, x, y, mouseButtons, buttons;
int temp;
int scale = 20;
int minX = 1;
int minY = 1;
int maxX = 78;
int maxY = 23;
char cursor = '*';
char quit = 1;
int ret = 0;
int memX = 0;
int memY = 0;


void getMouseState(int* x, int* y, int* buttonsState)
{
	int tempX;
	int tempY;
	int tempB;
	__asm
	{
		xor eax, eax
		xor ebx, ebx
		xor ecx, ecx
		xor edx, edx
		mov ax, 3
		int 33h
		mov tempX, ecx
		mov tempY, edx
		mov tempB, ebx
	}
	*x = tempX;
	*y = tempY;
	*buttonsState = tempB;

	if (tempX > 600 || tempX < 20 || tempY < 20 || tempY > 180)
	{
		__asm
		{
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

void gotoxy(int xpos, int ypos)
{
	COORD scrn;

	HANDLE hOuput = GetStdHandle(STD_OUTPUT_HANDLE);

	scrn.X = xpos; scrn.Y = ypos;

	SetConsoleCursorPosition(hOuput, scrn);
}

void showCursor()
{
	system("cls");
	gotoxy(x, y);
	if (cursor == '`')
	{
		printf("%c", cursor);
	}
	printf("%c", cursor);
}

void setCenter()
{
	x = maxX / 2;
	y = maxY / 2;
}

int main(void)
{
	system("cls");
	getMouseState(&currX, &currY, &buttons);
	__asm
	{
		xor eax, eax
		xor ebx, ebx
		xor ecx, ecx
		xor edx, edx
		mov ah, 0
		mov al, 2
		int 10h
		mov ah, 1
		mov cx, 2607h
		int 10h
		mov ax, 0
		int 33h
		mov temp, eax
	}
	if (temp != 0)
	{
		buttons = 0;
		setCenter();
		getMouseState(&currX, &currY, &buttons);
		showCursor;
		while (quit)
		{
			getMouseState(&newX, &newY, &mouseButtons);
			if ((abs(newX - currX) > scale) || (abs(newY - currY) > scale))
			{
				if (newX < currX)
				{
					y += (abs(newX - currX) / scale);
				}
				else
				{
					x -= (abs(newX - currX) / scale);
				}

				if (newY < currY)
				{
					y -= (abs(newY - currY) / scale);
					x += (abs(newY - currY) / scale);
				}
				else
				{
					y += (abs(newY - currY) / scale);
					x += (abs(newY - currY) / scale);
				}

				if (x < minX)
				{
					x = maxX;
				}
				if (x > maxX)
				{
					x = minX;
				}

				if (y < minY)
				{
					y = maxY;
				}
				if (y > minY)
				{
					y = minY;
				}
				currX = newX;
				currY = newY;
				showCursor();
			}

			if ((mouseButtons == 0) && (buttons == 1))
			{
				if (ret == 0)
				{
					memX = x;
					memY = y;
					ret = 1;
				}
				else
				{
					x = memX;
					y = memY;
					ret = 0;
				}
				showCursor();
			}

			if ((mouseButtons == 0) && (buttons == 1))
			{
				quit = 0;
			}
			if ((mouseButtons == 0) && (buttons == 2))
			{
				//changeCursor();
				showCursor();
			}

			buttons = mouseButtons;
		}
	}
	else
	{
		printf("Fail!");
	}
}