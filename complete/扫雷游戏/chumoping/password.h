#include"background.h"
#include"test.h"
    #include "config.h"      //Ϊ�ֿ���ӵ�������"config.h" ��ucosii���ң������"config.h" ������ɾ��������Ҫʹ�õ�include��������еı������
    #include  "stdarg.h"    //Ϊ�ֿ���ӵ�������"stdarg.h" ��ADS1.2��װ�ļ�������ȥ�ң����Lcd_printf�����е�һЩ�������
#include "lcd_tft.h"


extern unsigned char __VGA[];//Ϊ�ֿ���ӵ�������Ӣ��ASCII����
extern unsigned char __CHS[];//Ϊ�ֿ���ӵ������������ֿ�����

void Lcd_PutHZ(unsigned int x,unsigned int y,unsigned short int QW,unsigned int c,unsigned int bk_c,unsigned int st);//Ϊ�ֿ���ӵ�����
void Lcd_PutASCII(unsigned int x,unsigned int y,unsigned char ch,unsigned int c,unsigned int bk_c,unsigned int st);//Ϊ�ֿ���ӵ�����
void Lcd_printf(unsigned int x,unsigned int y,unsigned int c,unsigned int bk_c,unsigned int st,char *fmt,...);//Ϊ�ֿ���ӵ�����

int password(void);