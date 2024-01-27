#define	GLOBAL_CLK		1

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
#include "LCD_TFT.H"

//----add bgn-----------------
#include "lcd_tft.h"
#ifdef CSTM_LCD
#include "cstm_lcd.h"

#endif
//----add end-----------------

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
#include "config.h"      //为字库添加的声明，"config.h" 到ucosii中找，添加了"config.h" 到其中删除掉不需要使用的include，解决所有的编译错误
#include  "stdarg.h"    //为字库添加的声明，"stdarg.h" 到ADS1.2安装文件夹里面去找，解决Lcd_printf（）中的一些编译错误

extern unsigned char __VGA[];//为字库添加的声明，英文ASCII编码
extern unsigned char __CHS[];//为字库添加的声明，汉子字库数组

void Lcd_PutHZ(unsigned int x,unsigned int y,unsigned short int QW,unsigned int c,unsigned int bk_c,unsigned int st);//为字库添加的声明
void Lcd_PutASCII(unsigned int x,unsigned int y,unsigned char ch,unsigned int c,unsigned int bk_c,unsigned int st);//为字库添加的声明
void Lcd_printf(unsigned int x,unsigned int y,unsigned int c,unsigned int bk_c,unsigned int st,char *fmt,...);//为字库添加的声明

extern void Lcd_TFT_Init(void);
extern void password(void);
extern void Test_Touchpanel(void) ;

volatile int xdata, ydata;
void digitalpic(void){
int pix_x=480;
int pix_y=272;
int a=0;
Lcd_ClearScr(0xffffff);
Paint_Bmp(0, 0, 480,272, lf);
//Delay(50);
Glib_FilledRectangle(8,222,78,262,0xFFFFFF);
Paint_Bmp(8, 222, 70, 40, lf);
//Delay(50);
Glib_FilledRectangle(87,222,157,262,0xFFFFFF);
Paint_Bmp(87,222, 70, 40, sl);
//Delay(50);
Glib_FilledRectangle(166,222,236,262,0xFFFFFF);
Paint_Bmp(166,222, 70, 40, sz);
//Delay(50);
Glib_FilledRectangle(245,222,315,262,0xFFFFFF);
Paint_Bmp(245,222, 70,40, nm);
//Delay(50);
Glib_FilledRectangle(324,222,394,262,0xFFFFFF);
Paint_Bmp(324,222, 70, 40, nd);
//Delay(50);
Glib_FilledRectangle(403,222,473,262,0xFFFFFF);
Paint_Bmp(403, 222, 70, 40, qb);
//Delay(50);
while(1)
{
if(ydata>2*pix_y/3)
{if(xdata<pix_x/6)
{
Paint_Bmp(0, 0, 480,272, lf);
a=1;
}
else if(xdata>pix_x/6&&xdata<pix_x/3)
{
Paint_Bmp(0, 0, 480,272, sl);
a=1;
}
else if(xdata>pix_x/3&&xdata<pix_x/2)
{
Paint_Bmp(0, 0, 480,272, sz);
a=1;
}
else if(xdata>pix_x/2&&xdata<pix_x*2/3){
Paint_Bmp(0, 0, 480,272,nm );
a=1;
}
else if(xdata>pix_x*2/3&&xdata<pix_x*5/6){
Paint_Bmp(0, 0, 480,272, nd);
a=1;
}
else if(xdata>pix_x*5/6){
Paint_Bmp(0, 0, 480,272, qb);
a=1;
}
xdata=0;
ydata=0;
}
if(a==1){
//Delay(50);
Glib_FilledRectangle(8,222,78,262,0xFFFFFF);
Paint_Bmp(8, 222, 70, 40, lf);
//Delay(50);
Glib_FilledRectangle(87,222,157,262,0xFFFFFF);
Paint_Bmp(87,222, 70, 40, sl);
//Delay(50);
Glib_FilledRectangle(166,222,236,262,0xFFFFFF);
Paint_Bmp(166,222, 70, 40, sz);
//Delay(50);
Glib_FilledRectangle(245,222,315,262,0xFFFFFF);
Paint_Bmp(245,222, 70,40, nm);
//Delay(50);
Glib_FilledRectangle(324,222,394,262,0xFFFFFF);
Paint_Bmp(324,222, 70, 40, nd);
//Delay(50);
Glib_FilledRectangle(403,222,473,262,0xFFFFFF);
Paint_Bmp(403, 222, 70, 40, qb);
//Delay(50);
a=0;
}
if(xdata>0&&xdata<40&&ydata>0&&ydata<40){
//Paint_Bmp(0, 0, 480,272, background);
return;
}
}
}
int pow1(int x,int y){
int w=1;
while(y){
w*=x;
--y;
}
return w;
}
