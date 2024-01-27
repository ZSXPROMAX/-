#include "test_1.h"
#include "saolei.h"


extern int sum;

void test_1(void) {
    // Determine the coordinates of the clicked block
    int block_x = xdata / 40; // Each block has a width of 60
    int block_y = ydata / 68; // Each block has a height of 68

    // Calculate the coordinates of the top-left corner of the block
    int block_top_left_x = block_x * 40;
    int block_top_left_y = block_y * 68;

    if ((block_x == 4 && block_y == 1) ||
        (block_x == 2 && block_y == 2) ||
        (block_x == 5 && block_y == 3)) {
 
	rGPBCON &= ~3;			//set GPB0 as tout0, pwm output
	rGPBCON |= 2;
		
	rTCFG0 &= ~0xff;
	rTCFG0 |= 15;			//prescaler = 15+1
	rTCFG1 &= ~0xf;
	rTCFG1 |= 2;			//mux = 1/8

	rTCNTB0 = (PCLK>>7)/250;
	rTCMPB0 = rTCNTB0*0.03;	//�޸���һ�䣬������ռ�ձȣ�ͬѧ�ǿ����Լ���ʵ�鳢��
	
	rTCON &= ~0x1f;
	rTCON |= 0xb;			//disable deadzone, auto-reload, inv-off, update TCNTB0&TCMPB0, start timer 0
	rTCON &= ~2;			//clear manual update bit

  // If a specific block is clicked, display the "false" image
       // Paint_Bmp(block_top_left_x, block_top_left_y, 60, 68, false);ʧ�ܵ�Сͼ
         Delay(1000);
        Paint_Bmp(0, 0, 480, 272, shibai);
         Delay(1000);
            
        
    } 
    
    else if (block_x == 3 && block_y == 2){
    
rGPBCON &= ~3;			//set GPB0 as tout0, pwm output
	rGPBCON |= 2;
		
	rTCFG0 &= ~0xff;
	rTCFG0 |= 15;			//prescaler = 15+1
	rTCFG1 &= ~0xf;
	rTCFG1 |= 2;			//mux = 1/8

	rTCNTB0 = (PCLK>>7)/250;
	rTCMPB0 = rTCNTB0*0.03;	//�޸���һ�䣬������ռ�ձȣ�ͬѧ�ǿ����Լ���ʵ�鳢��
	
	rTCON &= ~0x1f;
	rTCON |= 0xb;			//disable deadzone, auto-reload, inv-off, update TCNTB0&TCMPB0, start timer 0
	rTCON &= ~2;			//clear manual update bit


    
    
     Paint_Bmp(0, 0, 480, 272, yin);
     Delay(800);
    // saolei();//��ʾ�ڶ���
     //test_1();
     }
    else if(block_x == 0 && block_y == 0|| block_x == 0 && block_y == 1|| block_x == 0 && block_y == 2|| block_x == 0 && block_y == 3 || block_x == 1 && block_y == 0|| block_x == 5 && block_y == 0 ||block_x == 6 && block_y == 0||block_x == 5 && block_y == 1 ||block_x == 6 && block_y == 1||block_x == 7 && block_y == 1||block_x == 7 && block_y == 2||block_x == 7 && block_y == 3){
    
    
rGPBCON &= ~3;			//set GPB0 as tout0, pwm output
	rGPBCON |= 2;
		
	rTCFG0 &= ~0xff;
	rTCFG0 |= 15;			//prescaler = 15+1
	rTCFG1 &= ~0xf;
	rTCFG1 |= 2;			//mux = 1/8

	rTCNTB0 = (PCLK>>7)/250;
	rTCMPB0 = rTCNTB0*0.03;	//�޸���һ�䣬������ռ�ձȣ�ͬѧ�ǿ����Լ���ʵ�鳢��
	
	rTCON &= ~0x1f;
	rTCON |= 0xb;			//disable deadzone, auto-reload, inv-off, update TCNTB0&TCMPB0, start timer 0
	rTCON &= ~2;			//clear manual update bit


    
    
    Paint_Bmp(block_top_left_x, block_top_left_y, 40, 68, meiyou_1);
    }
    else if(block_x == 7 && block_y == 0){
   
rGPBCON &= ~3;			//set GPB0 as tout0, pwm output
	rGPBCON |= 2;
		
	rTCFG0 &= ~0xff;
	rTCFG0 |= 15;			//prescaler = 15+1
	rTCFG1 &= ~0xf;
	rTCFG1 |= 2;			//mux = 1/8

	rTCNTB0 = (PCLK>>7)/250;
	rTCMPB0 = rTCNTB0*0.03;	//�޸���һ�䣬������ռ�ձȣ�ͬѧ�ǿ����Լ���ʵ�鳢��
	
	rTCON &= ~0x1f;
	rTCON |= 0xb;			//disable deadzone, auto-reload, inv-off, update TCNTB0&TCMPB0, start timer 0
	rTCON &= ~2;			//clear manual update bit

   
    leida();//�ص���ʼ����
    }
    else {
        // Otherwise, display the "right" image
       
rGPBCON &= ~3;			//set GPB0 as tout0, pwm output
	rGPBCON |= 2;
		
	rTCFG0 &= ~0xff;
	rTCFG0 |= 15;			//prescaler = 15+1
	rTCFG1 &= ~0xf;
	rTCFG1 |= 2;			//mux = 1/8

	rTCNTB0 = (PCLK>>7)/250;
	rTCMPB0 = rTCNTB0*0.03;	//�޸���һ�䣬������ռ�ձȣ�ͬѧ�ǿ����Լ���ʵ�鳢��
	
	rTCON &= ~0x1f;
	rTCON |= 0xb;			//disable deadzone, auto-reload, inv-off, update TCNTB0&TCMPB0, start timer 0
	rTCON &= ~2;			//clear manual update bit


      
        Paint_Bmp(block_top_left_x, block_top_left_y, 40, 68, you_1);
       
    }

}