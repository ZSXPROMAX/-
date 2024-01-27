#include"saolei.h"

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

#include"you.h"
#include"meiyou.h"
#include"you_1.h"
#include"meiyou_1.h"


extern volatile int xdata, ydata;


void test_1(void) ;
void Buzzer_Freq_Set0(U32 freq);
void Buzzer_Freq_Set1(U32 freqk);