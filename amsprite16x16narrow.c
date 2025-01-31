/**
 * A primitive Amstrad sprite editor.
 * George Fountis (c) 2025
 *
 * Changelog :
 * Rewrote 'moveMarker' to 'movepen' using '&' to pass the x,y integer pointers, instead of 
 * having two integers and two pointers that point to those integers, passing them as pointers
 * and as their dereferenced value. I'm learning. 
 *
 * TODO:
 * I need to also declare a canvasy, since the canvas begins at 0,0. Or I need to draw the ncurses canvas at 0,0 and
 * re-order everything. 
*/


#include <stdio.h>
#include <ncurses.h>
int movepen(int* currenty, int* currentx, int newy, int newx, int* canvasx, int* canvasy, int canvas[16][16]);
int paint(int* currenty, int* currentx,  int canvas[16][16], int *canvasx, int *canvasy,int color);
int hexes(int canvas[16][16]);

int main() {

	initscr();
	noecho();
	curs_set(false);
	start_color();
	/* initialise colors that we will use */
	init_pair(1, COLOR_YELLOW, COLOR_YELLOW);
	init_pair(2, COLOR_RED, COLOR_RED);
	init_pair(3, COLOR_CYAN, COLOR_CYAN);
	init_pair(4, COLOR_BLUE, COLOR_BLUE);
	init_pair(5, COLOR_WHITE, COLOR_BLACK);

	/* select blue on blue */
	attron(COLOR_PAIR(4));

	mvprintw(0,0, "                \n");
	mvprintw(1,0, "                \n");
	mvprintw(2,0, "                \n");
	mvprintw(3,0, "                \n");
	mvprintw(4,0, "                \n");
	mvprintw(5,0, "                \n");
	mvprintw(6,0, "                \n");
	mvprintw(7,0, "                \n");
	mvprintw(8,0, "                \n");
	mvprintw(9,0, "                \n");
	mvprintw(10,0,"                \n");
	mvprintw(11,0,"                \n");
	mvprintw(12,0,"                \n");
	mvprintw(13,0,"                \n");
	mvprintw(14,0,"                \n");
	mvprintw(15,0,"                \n");
	
     
	int canvas[16][16] = { 
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4},
                               {4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4}
                             };

	int x,y,currcol;
	x = 0; y = 0;
	int canvasx = 0; int canvasy = 0;
	int ch;
	/* status bar */
	attron(COLOR_PAIR(1));
	mvprintw(y,x," ");
	
	attron(COLOR_PAIR(5));
	mvprintw(19,1,"use vim keys (h/j/k/l) for navigation\n");
	mvprintw(20,1,"                                                                         ");
	mvprintw(20,1,"y,x,canvasx,canvasy=%d,%d,%d,%d",y,x,canvasy,canvasx);	
	attron(COLOR_PAIR(1));	mvprintw(21,1," ");
	attron(COLOR_PAIR(2));  mvprintw(21,3," ");
	attron(COLOR_PAIR(3));  mvprintw(21,5," ");
	attron(COLOR_PAIR(4));  mvprintw(21,7," ");
	/* keypresses */
	while ((ch = getch()) != 'q') 
	{
		switch(ch) {
		case 'l': /* right */
			movepen(&y,&x,y,x+1,&canvasx, &canvasy,canvas);
			break;
		case 'h': /* left  */
			movepen(&y,&x,y,x-1,&canvasx,&canvasy,canvas);
			break;	
		case 'k': /* up */
			movepen(&y,&x,y-1,x,&canvasx,&canvasy,canvas);
			break;
		case 'j': /* down */
			movepen(&y,&x,y+1,x,&canvasx,&canvasy,canvas);
			break;
		case '1': 
			paint(&y, &x, canvas, &canvasx, &canvasy, 1);
			break;
		case '2':
			paint(&y,&x, canvas, &canvasx, &canvasy,  2);
			break;
		case '3':
			paint(&y,&x, canvas, &canvasx, &canvasy, 3);
			break;
		case '4': 
			paint(&y,&x,canvas, &canvasx, &canvasy, 4);
			break;

		default:
		        break;	
		}

	}
	refresh();
	endwin();
	for (int i = 0; i < 16; i++) {
		for (int j=0; j < 16; j++) {
			printf("%d", canvas[i][j]);
		}
	printf("\n");
	}

	hexes(canvas);

}

int movepen(int *currenty, int *currentx, int newy, int newx, int *canvasx, int* canvasy, int canvas[16][16]) 
{
	
	if (newx >= 0 && newx <= 15 && newy >= 0 && newy <= 15) 
	{

	/* print at new x and y */

		attron(COLOR_PAIR(1));
		mvprintw(newy,newx," ");

		int currcol=canvas[*currenty][*currentx];		
		
		attron(COLOR_PAIR(currcol));
		mvprintw(*currenty,*currentx," ");

		attron(COLOR_PAIR(5));

		*currenty = newy;
		*currentx = newx;

		attron(COLOR_PAIR(5));
		mvprintw(20,1,"                                                                         ");
		mvprintw(20,1,"y,x,canvasy,canvasx=%d,%d,%d,%d",*currenty,*currentx,canvasy,canvasx);	
	}
}	

/* setting the color to the array canvas works, repainting correctly the canvas fails. */

int paint(int* currenty, int* currentx,  int canvas[16][16], int* canvasx, int* canvasy, int color) 
{

	attron(COLOR_PAIR(color));
	mvprintw(*currenty, *currentx, " ");
	canvas[*currenty][*currentx] = color;
}
/**
 * ld hl, &c000
ld (hl), %00000000 ; blue
ld hl, &c800
ld (hl), %00001000 ; cyan
ld hl, &d000
ld (hl), %10000000 ; yellow
ld hl, &d800
ld (hl), %10001000 ; red
*/
// 0000 0000 must be background (blue)
// bit 0
// h:8  b:00001000 cyan 
// h:80 b:10000000 yellow
// h:88 b:10001000 red
// bit 1
// h:4 0000 0100 cyan 
// 0100 0000 yellow 
// 0100 0100 red
// bit 2
// h: 20000 0010 cyan 
// 0010 0000 yellow 
// 0010 0010 red
// bit 3
// h: 10000 0001 cyan 
// 0001 0000 yellow 
// 0001 0001 red 



int hexes(int canvas[16][16]) 
{

	int bit = 0;
	int pixel = 0;
	int byte = 0x00;
	int mask = 0x00;
	int temp = 0;
	int bitmasks[4][4];

	bitmasks[0][1] = 0x80; //yellow
	bitmasks[0][2] = 0x88; //cyan 
	bitmasks[0][3] = 0x08; //red
	bitmasks[0][4] = 0x00; // blue

	bitmasks[1][1] = 0x40;
        bitmasks[1][2] = 0x44;
	bitmasks[1][3] = 0x4;
	bitmasks[1][4] = 0x00;

	bitmasks[2][1] = 0x20;
	bitmasks[2][2] = 0x22;
	bitmasks[2][3] = 0x22;
	bitmasks[2][4] = 0x00;

	bitmasks[3][1] = 0x10;
	bitmasks[3][2] = 0x11;
	bitmasks[3][3] = 0x1;
	bitmasks[3][4] = 0x00;
	for (int k = 0; k < 16; k++) 
	{
	  for (int l=0; l < 16; l++) 
	  {

	    pixel = canvas[k][l];
      	    byte = byte | bitmasks[bit][pixel];

	  if (bit ==  3) 
	    {

		  printf("&%x ",byte);bit = 0; byte=0; 
		  bit = 0; byte = 0;

	    }
	   else {  
	            bit++;
	    }

	  }

   	 }
}
