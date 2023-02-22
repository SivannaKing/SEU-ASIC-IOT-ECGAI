// See LICENSE for license details.
#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include "hbird_sdk_soc.h"
/*
#include "insn.h"
#define _DEBUG_INFO_
*/
int main(void)
{

	printf("***************enable ECG********************\n");
	ECG -> enable = 0x01;
	/*
	while(!(ECG -> reg6 == 0x0002));
	printf("***************read data********************\n");
	printf("reg 1: %x\t\n",ECG -> reg1);
	printf("reg 2: %x\t\n",ECG -> reg2);
	printf("reg 3: %x\t\n",ECG -> reg3);
	printf("reg 4: %x\t\n",ECG -> reg4);
	printf("reg 5: %x\t\n",ECG -> reg5);

	*/
	printf("-------------------------\n");
	printf("reg 6: %x\t\n",ECG -> reg6);
	printf("-------------------------\n");


	while(!(ECG -> reg6 && 0x0002));
	printf("!!!!!!!!!!!!!!!!!!!!!!!");
/*
	while(1)
	{
		printf("reg 1: %x\t\n",ECG -> reg1);
		printf("reg 2: %x\t\n",ECG -> reg2);
		printf("reg 3: %x\t\n",ECG -> reg3);
		printf("reg 4: %x\t\n",ECG -> reg4);
		printf("reg 5: %x\t\n",ECG -> reg5);
		printf("reg 6: %x\t\n",ECG -> reg6);
	}
*/
	while(1);
    return 0;
}
