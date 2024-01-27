#include"leida.h"
#include"fanhui.h"
void leida(void){

int i;
for(i=8;i>=1;i--){
Paint_Bmp(480-60*i, 0, 60, 68, chushi);
Paint_Bmp(480-60*i, 68, 60, 68, chushi);
Paint_Bmp(480-60*i, 136, 60, 68, chushi);
Paint_Bmp(480-60*i, 204, 60, 68, chushi);
Paint_Bmp(480-60, 0, 60, 68, fanhui);
}

}
