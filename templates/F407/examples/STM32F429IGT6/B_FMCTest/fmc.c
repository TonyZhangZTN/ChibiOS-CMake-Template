#include <fmc.h>
#include "ch.h"
typedef struct
{
    volatile uint16_t LCD_REG;
//	vu16 LCD_REGSS;  //add by TonyZhangZTN
    volatile uint16_t LCD_RAM;
} LCD_TypeDef;
//使用NOR/SRAM的 Bank1.sector1,地址位HADDR[27,26]=00 A18作为数据命令区分线 (第19位),当A19为1，则LCD RS脚位为1，读写数据;反之，A19为0，则读写命令
//注意设置时STM32内部会右移一位对齐!
#define LCD_BASE        ((uint32_t)(0x60000000 | 0x0007FFFE))
//#define LCD_BASE        ((u32)(0x60000000 | 0x0007FFFC))//111 1111 1111 1111 1110  //add by TonyZhangZTN
#define LCD             ((LCD_TypeDef *) LCD_BASE)
///////////////////////////////////////////////////////
void fmcInit(){
    RCC->AHB1ENR|=1<<1;			//使能PORTB时钟
    RCC->AHB1ENR|=3<<3;    		//使能PD,PE
    RCC->AHB3ENR|=1<<0;     	//使能FMC时钟

//    GPIO_AF_Set(GPIOD,0,12);	//PD0,AF12 FMC_D2
//    GPIO_AF_Set(GPIOD,1,12);	//PD1,AF12 FMC_D3
//    GPIO_AF_Set(GPIOD,4,12);	//PD4,AF12 FMC_NOE
//    GPIO_AF_Set(GPIOD,5,12);	//PD5,AF12 FMC_NWE
//    GPIO_AF_Set(GPIOD,7,12);	//PD7,AF12 FMC_NE1
//    GPIO_AF_Set(GPIOD,8,12);	//PD8,AF12 FMC_D13
//    GPIO_AF_Set(GPIOD,9,12);	//PD9,AF12 FMC_D14
//    GPIO_AF_Set(GPIOD,10,12);	//PD10,AF12 FMC_D15
//    GPIO_AF_Set(GPIOD,13,12);	//PD13,AF12 FMC_A18
//    GPIO_AF_Set(GPIOD,14,12);	//PD14,AF12 FMC_D0
//    GPIO_AF_Set(GPIOD,15,12);	//PD15,AF12 FMC_D1
//
//    GPIO_AF_Set(GPIOE,7,12);	//PE7,AF12 FMC_D4
//    GPIO_AF_Set(GPIOE,8,12);	//PE8,AF12 FMC_D5
//    GPIO_AF_Set(GPIOE,9,12);	//PE9,AF12 FMC_D6
//    GPIO_AF_Set(GPIOE,10,12);	//PE10,AF12 FMC_D7
//    GPIO_AF_Set(GPIOE,11,12);	//PE11,AF12 FMC_D8
//    GPIO_AF_Set(GPIOE,12,12);	//PE12,AF12 FMC_D9
//    GPIO_AF_Set(GPIOE,13,12);	//PE13,AF12 FMC_D10
//    GPIO_AF_Set(GPIOE,14,12);	//PE14,AF12 FMC_D11
//    GPIO_AF_Set(GPIOE,15,12);	//PE15,AF12 FMC_D12



    //寄存器清零
    //bank1有NE1~4,每一个有一个BCR+TCR，所以总共八个寄存器。
    //这里我们使用NE1 ，也就对应BTCR[0],[1]。
    FMC_Bank1->BTCR[0]=0X00000000;//BCR1
    FMC_Bank1->BTCR[1]=0X00000000;//BTR1
    FMC_Bank1E->BWTR[0]=0X00000000;//BWTR1
    //操作BCR寄存器	使用异步模式
    FMC_Bank1->BTCR[0]|=1<<12;		//存储器写使能
    FMC_Bank1->BTCR[0]|=1<<14;		//读写使用不同的时序
    FMC_Bank1->BTCR[0]|=1<<4; 		//存储器数据宽度为16bit
    //操作BTR寄存器
    //读时序控制寄存器
    FMC_Bank1->BTCR[1]|=0<<28;		//模式A
    FMC_Bank1->BTCR[1]|=0XF<<0; 	//地址建立时间(ADDSET)为15个HCLK 1/192M=5.2ns*15=78ns
    //因为液晶驱动IC的读数据的时候，速度不能太快,尤其是个别奇葩芯片。
    FMC_Bank1->BTCR[1]|=70<<8;  	//数据保存时间(DATAST)为60个HCLK	=5.2*70=360ns
    //写时序控制寄存器
    FMC_Bank1E->BWTR[0]|=0<<28; 	//模式A
    FMC_Bank1E->BWTR[0]|=15<<0;		//地址建立时间(ADDSET)为15个HCLK=78ns
    //10个HCLK（HCLK=192M）,某些液晶驱动IC的写信号脉宽，最少也得50ns。
    FMC_Bank1E->BWTR[0]|=15<<8; 	//数据保存时间(DATAST)为5.2ns*15个HCLK=78ns
    //使能BANK1,区域1
    FMC_Bank1->BTCR[0]|=1<<0;		//使能BANK1，区域1

    chThdSleepMilliseconds(50);
    LCD->LCD_REG =0XD3;
    volatile uint32_t ret=0;
    ret = LCD->LCD_RAM; //dummy
    ret = LCD->LCD_RAM; //0x00
    ret = LCD->LCD_RAM; //0x93
    ret <<= 8;
    ret |= LCD->LCD_RAM; //0x41
}