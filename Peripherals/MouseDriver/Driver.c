#include <stdio.h> 
#include <conio.h> 
#include <math.h> 

int currX,currY, newX, newY, x,
int temp;    
int scale=20;   
int minX=1;    
int minY=1;    
int maxX=78;    
int maxY=23;    
char cursor='*';
char quit=1;
int ret=0;
int memX=0; 16   intmemY=0; 17   18   voidgetMouseState(int* 19   { 20   inttempX,tempY,tempB; 21   asm{ 22   movax,3 23   int33h 24   movtempX,cx 25   movtempY,dx 26   movtempB,bx 27   } 28   *x=tempX; 29   *y=tempY; 30   *buttonState=tempB; 31   32   if(tempX>600||tempX 33   asm{ 34   movax,4; 35   movcx,100; 36   movdx,100; 37   int33h 38   } 39   currX=100; 40   currY=100; 41   *x=currX; 42   *y=currY; 43   } 44   45   } 46   47   voidshowCursor() 48   { 49   clrscr(); 50   gotoxy(x,y); 51   if(cursor=='`') 52   printf("%c",cursor); 53   printf("%c",cursor); 54   } 55   56   voidchangeCursor(){ 57   if(cursor=='*')cursor 58   elsecursor='*';

int*
=
<
	x,
	20
	y,
	'`';
y,
||
int*
mouseButtons,
tempY
buttonState)
<
	20
	||
	buttons;
tempY
>
180) {
	7 травня 2015 р. 7:41

		C : \borlandC\lab3.cpp 59
} 60   61   voidsetCenter() 62   { 63   x = maxX / 2; 64   y = maxY / 2; 65   } 66   67   voidmain() 68   { 69   clrscr(); 70   asm{ 71   movah,0 72   moval,2 73   int10h 74   movah,1 75   movcx,2607h 76   int10h 77   movax,0 78   int33h 79   movtemp,ax 80 } 81   if (temp != 0) 82   { 83   buttons = 0; 84   setCenter(); 85   getMouseState(&currX, &currY, &buttons); 86   showCursor(); 87   while (quit) 88   { 89   90   getMouseState(&newX, &newY, &mouseButtons); 91   if ((abs(newX - currX)>scale) || (abs(newY 92   { 93   if (newX<currX) 94   { 95   96   y += (abs(newX - currX) / scale); 97   }
else 98   { 99   x -= (abs(newX - currX) / scale); 100   101   } 102   if (newY<currY) 103   { 104   y -= (abs(newY - currY) / scale); 105   x += (abs(newY - currY) / scale); 106   }
else 107   { 108   y += (abs(newY - currY) / scale); 109   x += (abs(newY - currY) / scale); 110   111   } 112   113   if (x<minX) 114   { 115   x = maxX; 116   }
-
currY)>
scale))
}
