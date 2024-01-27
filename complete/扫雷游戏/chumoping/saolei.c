#include "saolei.h"

void saolei(void){

int i;
for(i=12;i>=1;i--){
Paint_Bmp(480-40*i, 0, 40, 68, right_1);
Paint_Bmp(480-40*i, 68, 40, 68, right_1);
Paint_Bmp(480-40*i, 136, 40, 68, right_1);
Paint_Bmp(480-40*i, 204, 40, 68, right_1);
Paint_Bmp(480-40, 0, 40, 68, fanhui_1);

}

}