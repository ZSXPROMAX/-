#include"background.h"
#include"test.h"
    #include "config.h"      //为字库添加的声明，"config.h" 到ucosii中找，添加了"config.h" 到其中删除掉不需要使用的include，解决所有的编译错误
    #include  "stdarg.h"    //为字库添加的声明，"stdarg.h" 到ADS1.2安装文件夹里面去找，解决Lcd_printf（）中的一些编译错误
#include "lcd_tft.h"


extern unsigned char __VGA[];//为字库添加的声明，英文ASCII编码
extern unsigned char __CHS[];//为字库添加的声明，汉子字库数组

void Lcd_PutHZ(unsigned int x,unsigned int y,unsigned short int QW,unsigned int c,unsigned int bk_c,unsigned int st);//为字库添加的声明
void Lcd_PutASCII(unsigned int x,unsigned int y,unsigned char ch,unsigned int c,unsigned int bk_c,unsigned int st);//为字库添加的声明
void Lcd_printf(unsigned int x,unsigned int y,unsigned int c,unsigned int bk_c,unsigned int st,char *fmt,...);//为字库添加的声明

int password(void);