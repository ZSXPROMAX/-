#include <stdlib.h>
#include <string.h>
#include "def.h"
#include "option.h"
#include "2440addr.h"
#include "2440lib.h"
#include "2440slib.h"
#include "mmu.h"
#include "profile.h"
#include "memtest.h"

extern char Image$$RO$$Limit[];
extern char Image$$RO$$Base[];
extern char Image$$RW$$Limit[];
extern char Image$$RW$$Base[];
extern char Image$$ZI$$Limit[];
extern char Image$$ZI$$Base[];

extern unsigned char lf[];
extern unsigned char sl[];
extern unsigned char sz[];
extern unsigned char nm[];
extern unsigned char nd[];
extern unsigned char qb[];
extern void Lcd_TFT_Init(void);
extern void Paint_Bmp(int x0,int y0,int h,int l,unsigned char bmp[]);
extern void Test_Touchpanel(void);
extern volatile int x,y;
extern volatile int xdata,ydata;

void password(void){
int mima[]={1,2,3,4};
int mima1[4];
int flag1=1;

while(flag1){
int flag=1;
int t=0;

Lcd_printf(300,110,0x0000,(0x1f<<11)|(0x3f<5)|(0x1f),1,"        ");
Lcd_printf(300,510,0x0000,(0x1f<<11)|(0x3f<5)|(0x1f),1,"                ");
Glib_Rectangle(290,60,380,90,0x0000);
while(flag){

if(xdata>0&&xdata<217&&ydata>11&&ydata<227){
if(xdata>25&&xdata<76&&ydata>25&&ydata<76){
mima1[t]=1;
Lcd_printf(300+20*t,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"1");
}
if(xdata>76 && xdata<152 && ydata>25 && ydata <76){
mima1[t]=2;
Lcd_printf(300+20*t,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"2");
}
if(xdata>152 && xdata<217 && ydata>25 && ydata <76){
mima1[t]=3;
Lcd_printf(300+20*t,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"3");
}
if(xdata>25 && xdata<76 && ydata>76 && ydata <126){
mima1[t]=4;
Lcd_printf(300+20*t,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"4");
}
if(xdata>76 && xdata<152 && ydata>76 && ydata <126){
mima1[t]=5;
Lcd_printf(300+20*t,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"5");
}
if(xdata>152 && xdata<217 && ydata>76 && ydata <126){
mima1[t]=6;
Lcd_printf(300+20*t,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"6");
}
if(xdata>25 && xdata<76 && ydata>126 && ydata <176){
mima1[t]=7;
Lcd_printf(300+20*t,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"7");
}
if(xdata>76 && xdata<152 && ydata>126 && ydata <176){
mima1[t]=8;
Lcd_printf(300+20*t,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"8");
}
if(xdata>152 && xdata<217 && ydata>126 && ydata <176){
mima1[t]=9;
Lcd_printf(300+20*t,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"9");
}
if(xdata>76 && xdata<152 && ydata>176 && ydata <227){
mima1[t]=0;
Lcd_printf(300+20*t,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"0");
}
t++;
xdata=0;
ydata=0;
}
if(t==4){
flag=0;
Delay(800);
Lcd_printf(300,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"*");
Lcd_printf(320,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"*");
Lcd_printf(340,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"*");
Lcd_printf(360,70,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"*");
}
}
if(mima[0]==mima1[0] && mima[1]==mima1[1] && mima[2]==mima1[2] &&
mima[3]==mima1[3]){
Lcd_printf(300,110,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"密码正确");
Lcd_printf(300,150,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"欢迎使用智能手机");
Delay(800);
Lcd_ClearScr(0);
flag1=0;
}
else{
Lcd_printf(300,110,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"密码错误");
Lcd_printf(300,150,0x0000,(0x1f<<11) | (0x3f<<5) | (0x1f),1,"请重新输入密码");
Delay(800);
}
}
}