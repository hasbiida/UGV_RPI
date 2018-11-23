
;CodeVisionAVR C Compiler V2.05.3 Standard
;(C) Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega8
;Program type             : Application
;Clock frequency          : 16.000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 256 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;Global 'const' stored in FLASH     : No
;Enhanced function parameter passing: Yes
;Enhanced core instructions         : On
;Smart register allocation          : On
;Automatic register allocation      : On

	#pragma AVRPART ADMIN PART_NAME ATmega8
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1119
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	RCALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	RCALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _counterkanan=R4
	.DEF _counterkiri=R6
	.DEF _i=R8
	.DEF _j=R10

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	RJMP __RESET
	RJMP _ext_int0_isr
	RJMP _ext_int1_isr
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00
	RJMP 0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;REGISTER BIT VARIABLES INITIALIZATION
__REG_BIT_VARS:
	.DW  0x0000

_0x0:
	.DB  0x62,0x65,0x67,0x69,0x6E,0x20,0x70,0x72
	.DB  0x6F,0x67,0x72,0x61,0x6D,0xD,0xA,0x0
	.DB  0x25,0x73,0x2C,0x25,0x69,0xD,0xA,0x0
	.DB  0x25,0x73,0x0,0x24,0x73,0x6C,0x61,0x76
	.DB  0x65,0x2C,0x25,0x33,0x64,0x2C,0x25,0x33
	.DB  0x64,0xD,0xA,0x0,0x24,0x63,0x6F,0x75
	.DB  0x6E,0x74,0x65,0x72,0x2C,0x25,0x69,0x2C
	.DB  0x25,0x69,0xD,0xA,0x0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  0x02
	.DW  __REG_BIT_VARS*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.3 Standard
;Automatic Program Generator
;© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 4/22/2013
;Author  : estheim
;Company :
;Comments:
;
;
;Chip type               : ATmega8
;Program type            : Application
;AVR Core Clock frequency: 16.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*****************************************************/
;
;#include <mega8.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;unsigned int counterkanan,counterkiri;
;// External Interrupt 0 service routine
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 001D {

	.CSEG
_ext_int0_isr:
	RCALL SUBOPT_0x0
; 0000 001E // Place your code here
; 0000 001F counterkanan++;
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
; 0000 0020 }
	RJMP _0x35
;
;// External Interrupt 1 service routine
;interrupt [EXT_INT1] void ext_int1_isr(void)
; 0000 0024 {
_ext_int1_isr:
	RCALL SUBOPT_0x0
; 0000 0025 // Place your code here
; 0000 0026 counterkiri++;
	MOVW R30,R6
	ADIW R30,1
	MOVW R6,R30
; 0000 0027 }
_0x35:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
;
;// Standard Input/Output functions
;#include <stdio.h>
;
;// Declare your global variables here
;#define kanan PORTC.0;
;#define kiri PORTC.1;
;int i,j;
;bit status;
;unsigned char datas[20];
;long pwml,pwmr;
;
;void maju(void);
;void mundur(void);
;void kanan90(void);
;void kiri90(void);
;void stop(void);
;void kirim(void);
;void baca(void);
;void proses(void);
;long rubahdata(unsigned char arah);
;void cekarah(void);
;
;void main(void)
; 0000 0040 {
_main:
; 0000 0041 // Declare your local variables here
; 0000 0042 
; 0000 0043 // Input/Output Ports initialization
; 0000 0044 // Port B initialization
; 0000 0045 // Func7=In Func6=In Func5=In Func4=In Func3=Out Func2=Out Func1=Out Func0=In
; 0000 0046 // State7=T State6=T State5=T State4=T State3=0 State2=0 State1=0 State0=T
; 0000 0047 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0048 DDRB=0x0E;
	LDI  R30,LOW(14)
	OUT  0x17,R30
; 0000 0049 
; 0000 004A // Port C initialization
; 0000 004B // Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 004C // State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 004D PORTC=0xFF;
	LDI  R30,LOW(255)
	OUT  0x15,R30
; 0000 004E DDRC=0xFF;
	OUT  0x14,R30
; 0000 004F 
; 0000 0050 // Port D initialization
; 0000 0051 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0052 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0053 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 0054 DDRD=0x00;
	OUT  0x11,R30
; 0000 0055 
; 0000 0056 // Timer/Counter 0 initialization
; 0000 0057 // Clock source: System Clock
; 0000 0058 // Clock value: Timer 0 Stopped
; 0000 0059 TCCR0=0x00;
	OUT  0x33,R30
; 0000 005A TCNT0=0x00;
	OUT  0x32,R30
; 0000 005B 
; 0000 005C // Timer/Counter 1 initialization
; 0000 005D // Clock source: System Clock
; 0000 005E // Clock value: 16000.000 kHz
; 0000 005F // Mode: Ph. correct PWM top=0x00FF
; 0000 0060 // OC1A output: Non-Inv.
; 0000 0061 // OC1B output: Non-Inv.
; 0000 0062 // Noise Canceler: Off
; 0000 0063 // Input Capture on Falling Edge
; 0000 0064 // Timer1 Overflow Interrupt: Off
; 0000 0065 // Input Capture Interrupt: Off
; 0000 0066 // Compare A Match Interrupt: Off
; 0000 0067 // Compare B Match Interrupt: Off
; 0000 0068 TCCR1A=0xA1;
	LDI  R30,LOW(161)
	OUT  0x2F,R30
; 0000 0069 TCCR1B=0x09;
	LDI  R30,LOW(9)
	OUT  0x2E,R30
; 0000 006A TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 006B TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 006C ICR1H=0x00;
	OUT  0x27,R30
; 0000 006D ICR1L=0x00;
	OUT  0x26,R30
; 0000 006E OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 006F OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0070 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0071 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0072 
; 0000 0073 // Timer/Counter 2 initialization
; 0000 0074 // Clock source: System Clock
; 0000 0075 // Clock value: Timer2 Stopped
; 0000 0076 // Mode: Normal top=0xFF
; 0000 0077 // OC2 output: Set on compare match
; 0000 0078 ASSR=0x00;
	OUT  0x22,R30
; 0000 0079 TCCR2=0x30;
	LDI  R30,LOW(48)
	OUT  0x25,R30
; 0000 007A TCNT2=0x00;
	LDI  R30,LOW(0)
	OUT  0x24,R30
; 0000 007B OCR2=0x00;
	OUT  0x23,R30
; 0000 007C 
; 0000 007D // External Interrupt(s) initialization
; 0000 007E // INT0: On
; 0000 007F // INT0 Mode: Rising Edge
; 0000 0080 // INT1: On
; 0000 0081 // INT1 Mode: Rising Edge
; 0000 0082 GICR|=0xC0;
	IN   R30,0x3B
	ORI  R30,LOW(0xC0)
	OUT  0x3B,R30
; 0000 0083 MCUCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x35,R30
; 0000 0084 GIFR=0xC0;
	LDI  R30,LOW(192)
	OUT  0x3A,R30
; 0000 0085 
; 0000 0086 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 0087 TIMSK=0x00;
	LDI  R30,LOW(0)
	OUT  0x39,R30
; 0000 0088 
; 0000 0089 // USART initialization
; 0000 008A // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 008B // USART Receiver: On
; 0000 008C // USART Transmitter: On
; 0000 008D // USART Mode: Asynchronous
; 0000 008E // USART Baud Rate: 9600
; 0000 008F UCSRA=0x00;
	OUT  0xB,R30
; 0000 0090 UCSRB=0x18;
	LDI  R30,LOW(24)
	OUT  0xA,R30
; 0000 0091 UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 0092 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 0093 UBRRL=0x67;
	LDI  R30,LOW(103)
	OUT  0x9,R30
; 0000 0094 
; 0000 0095 // Analog Comparator initialization
; 0000 0096 // Analog Comparator: Off
; 0000 0097 // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 0098 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0099 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 009A 
; 0000 009B // ADC initialization
; 0000 009C // ADC disabled
; 0000 009D ADCSRA=0x00;
	OUT  0x6,R30
; 0000 009E 
; 0000 009F // SPI initialization
; 0000 00A0 // SPI disabled
; 0000 00A1 SPCR=0x00;
	OUT  0xD,R30
; 0000 00A2 
; 0000 00A3 // TWI initialization
; 0000 00A4 // TWI disabled
; 0000 00A5 TWCR=0x00;
	OUT  0x36,R30
; 0000 00A6 
; 0000 00A7 // Global enable interrupts
; 0000 00A8 #asm("sei")
	sei
; 0000 00A9 
; 0000 00AA pwml=240;
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x2
; 0000 00AB pwmr=240;
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x3
; 0000 00AC printf("begin program\r\n");
	__POINTW1FN _0x0,0
	RCALL SUBOPT_0x4
	LDI  R24,0
	RCALL _printf
	ADIW R28,2
; 0000 00AD while (1)
_0x3:
; 0000 00AE       {
; 0000 00AF       status=0;
	CLT
	BLD  R2,0
; 0000 00B0       kirim();
	RCALL _kirim
; 0000 00B1       baca();
	RCALL _baca
; 0000 00B2       printf("%s,%i\r\n",datas,status);
	__POINTW1FN _0x0,16
	RCALL SUBOPT_0x5
	LDI  R30,0
	SBRC R2,0
	LDI  R30,1
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL SUBOPT_0x6
; 0000 00B3       proses();
	RCALL _proses
; 0000 00B4       }
	RJMP _0x3
; 0000 00B5 }
_0x6:
	RJMP _0x6
;void maju(void) {
; 0000 00B6 void maju(void) {
_maju:
; 0000 00B7     OCR1AL=pwmr;  //  kanan
	RCALL SUBOPT_0x7
; 0000 00B8     OCR1BL=pwml; //    kiri
; 0000 00B9     PORTC.0=1;// kanan
	SBI  0x15,0
; 0000 00BA     PORTC.1=1;// kiri
	RJMP _0x2060004
; 0000 00BB };
;void stop(void){
; 0000 00BC void stop(void){
_stop:
; 0000 00BD     OCR1AL=0;
	LDI  R30,LOW(0)
	OUT  0x2A,R30
; 0000 00BE     OCR1BL=0;
	OUT  0x28,R30
; 0000 00BF     PORTC.0=0;
	CBI  0x15,0
; 0000 00C0     PORTC.1=0;
	RJMP _0x2060003
; 0000 00C1 };
;void mundur(void){
; 0000 00C2 void mundur(void){
_mundur:
; 0000 00C3     OCR1AL=pwmr;
	RCALL SUBOPT_0x7
; 0000 00C4     OCR1BL=pwml;
; 0000 00C5     PORTC.0=0;
	CBI  0x15,0
; 0000 00C6     PORTC.1=0;
	RJMP _0x2060003
; 0000 00C7 };
;void kanan90(void){
; 0000 00C8 void kanan90(void){
_kanan90:
; 0000 00C9     OCR1AL=pwmr;
	RCALL SUBOPT_0x7
; 0000 00CA     OCR1BL=pwml;
; 0000 00CB     PORTC.0=0;
	CBI  0x15,0
; 0000 00CC     PORTC.1=1;
_0x2060004:
	SBI  0x15,1
; 0000 00CD };
	RET
;void kiri90(void){
; 0000 00CE void kiri90(void){
_kiri90:
; 0000 00CF     OCR1AL=pwmr;
	RCALL SUBOPT_0x7
; 0000 00D0     OCR1BL=pwml;
; 0000 00D1     PORTC.0=1;
	SBI  0x15,0
; 0000 00D2     PORTC.1=0;
_0x2060003:
	CBI  0x15,1
; 0000 00D3 };
	RET
;
;
;void kirim(void)
; 0000 00D7 {
_kirim:
; 0000 00D8     scanf("%s",datas);
	__POINTW1FN _0x0,24
	RCALL SUBOPT_0x5
	LDI  R24,4
	RCALL _scanf
	ADIW R28,6
; 0000 00D9 
; 0000 00DA }
	RET
;void baca(void)
; 0000 00DC {
_baca:
; 0000 00DD j=0;
	CLR  R10
	CLR  R11
; 0000 00DE  //printf("%c",datas[j]);
; 0000 00DF  if(datas[j]==36)//$
	RCALL SUBOPT_0x8
	CPI  R26,LOW(0x24)
	BRNE _0x1B
; 0000 00E0  {
; 0000 00E1  j=j+1;
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
; 0000 00E2   // printf("%c",datas[j]);
; 0000 00E3    if(datas[j]==109)//ascii m
	RCALL SUBOPT_0x8
	CPI  R26,LOW(0x6D)
	BRNE _0x1C
; 0000 00E4    {
; 0000 00E5    i=0;
	CLR  R8
	CLR  R9
; 0000 00E6    j=0;
	CLR  R10
	CLR  R11
; 0000 00E7    status=1;
	SET
	RJMP _0x34
; 0000 00E8    }
; 0000 00E9    else
_0x1C:
; 0000 00EA    {
; 0000 00EB    status=0;
	CLT
_0x34:
	BLD  R2,0
; 0000 00EC    }
; 0000 00ED  }
; 0000 00EE  else
	RJMP _0x1E
_0x1B:
; 0000 00EF  {
; 0000 00F0  status=0;
	CLT
	BLD  R2,0
; 0000 00F1  }
_0x1E:
; 0000 00F2 }
	RET
;void proses(void)
; 0000 00F4 {
_proses:
; 0000 00F5     if(status==1)
	SBRS R2,0
	RJMP _0x1F
; 0000 00F6     {
; 0000 00F7      //   printf("rubah data");
; 0000 00F8         pwml=rubahdata(0);       //0 for left, 1 for right
	LDI  R26,LOW(0)
	RCALL _rubahdata
	RCALL SUBOPT_0x2
; 0000 00F9         pwmr=rubahdata(1);
	LDI  R26,LOW(1)
	RCALL _rubahdata
	RCALL SUBOPT_0x3
; 0000 00FA         cekarah(); //untuk arah
	RCALL _cekarah
; 0000 00FB         status=0;
	CLT
	BLD  R2,0
; 0000 00FC     }
; 0000 00FD     else
	RJMP _0x20
_0x1F:
; 0000 00FE     {
; 0000 00FF     stop();
	RCALL _stop
; 0000 0100     }
_0x20:
; 0000 0101     printf("$slave,%3d,%3d\r\n",pwml,pwmr);
	__POINTW1FN _0x0,27
	RCALL SUBOPT_0x4
	LDS  R30,_pwml
	LDS  R31,_pwml+1
	LDS  R22,_pwml+2
	LDS  R23,_pwml+3
	RCALL __PUTPARD1
	LDS  R30,_pwmr
	LDS  R31,_pwmr+1
	LDS  R22,_pwmr+2
	LDS  R23,_pwmr+3
	RCALL SUBOPT_0x6
; 0000 0102     delay_ms(1); //delay untuk mencegah error
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0103     printf("$counter,%i,%i\r\n",counterkanan,counterkiri);
	__POINTW1FN _0x0,44
	RCALL SUBOPT_0x4
	MOVW R30,R4
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	MOVW R30,R6
	CLR  R22
	CLR  R23
	RCALL SUBOPT_0x6
; 0000 0104     counterkanan=0;
	CLR  R4
	CLR  R5
; 0000 0105     counterkiri=0;
	CLR  R6
	CLR  R7
; 0000 0106 }
	RET
;
;long rubahdata(unsigned char arah)
; 0000 0109 {
_rubahdata:
; 0000 010A     unsigned char temp;
; 0000 010B     unsigned char a,b,c;
; 0000 010C     unsigned char pwm;
; 0000 010D     if (arah==0)
	ST   -Y,R26
	RCALL __SAVELOCR6
;	arah -> Y+6
;	temp -> R17
;	a -> R16
;	b -> R19
;	c -> R18
;	pwm -> R21
	LDD  R30,Y+6
	CPI  R30,0
	BRNE _0x21
; 0000 010E     {
; 0000 010F         a=(datas[8]-48)*100;
	__GETB1MN _datas,8
	RCALL SUBOPT_0x9
; 0000 0110         b=(datas[9]-48)*10;
	__GETB1MN _datas,9
	RCALL SUBOPT_0xA
; 0000 0111         c=datas[10]-48;
	__GETB1MN _datas,10
	RCALL SUBOPT_0xB
; 0000 0112         temp=a+b+c;
; 0000 0113         //printf("dat,%d,%d,%d",a,b,c) ;
; 0000 0114         //printf("datas,%d,%d,%d ",datas[8],datas[9],datas[10]);
; 0000 0115         //printf("arah %d",temp);
; 0000 0116     }
; 0000 0117     else if (arah==1)
	RJMP _0x22
_0x21:
	LDD  R26,Y+6
	CPI  R26,LOW(0x1)
	BRNE _0x23
; 0000 0118     {
; 0000 0119         a=(datas[12]-48)*100;
	__GETB1MN _datas,12
	RCALL SUBOPT_0x9
; 0000 011A         b=(datas[13]-48)*10;
	__GETB1MN _datas,13
	RCALL SUBOPT_0xA
; 0000 011B         c=datas[14]-48;
	__GETB1MN _datas,14
	RCALL SUBOPT_0xB
; 0000 011C         temp=a+b+c;
; 0000 011D         //printf("dat,%d,%d,%d",a,b,c) ;
; 0000 011E         //printf("datas%d,%d,%d ",datas[12],datas[13],datas[14]);
; 0000 011F         //printf("arah %d",temp);
; 0000 0120     }
; 0000 0121     else{
	RJMP _0x24
_0x23:
; 0000 0122     pwm=0;
	LDI  R21,LOW(0)
; 0000 0123     }
_0x24:
_0x22:
; 0000 0124     pwm=temp;
	MOV  R21,R17
; 0000 0125 return pwm;
	MOV  R30,R21
	RCALL SUBOPT_0xC
	RCALL __CWD1
	RCALL __LOADLOCR6
	ADIW R28,7
	RET
; 0000 0126 }
;void cekarah(void){
; 0000 0127 void cekarah(void){
_cekarah:
; 0000 0128     if (datas[16]=='1' && datas[18]=='1')
	RCALL SUBOPT_0xD
	CPI  R26,LOW(0x31)
	BRNE _0x26
	RCALL SUBOPT_0xE
	CPI  R26,LOW(0x31)
	BREQ _0x27
_0x26:
	RJMP _0x25
_0x27:
; 0000 0129     {
; 0000 012A       maju();
	RCALL _maju
; 0000 012B     //  printf("arah maju %c, %c",datas[16],datas[18]);
; 0000 012C     }
; 0000 012D     else if (datas[16]=='0' && datas[18]=='0')
	RJMP _0x28
_0x25:
	RCALL SUBOPT_0xD
	CPI  R26,LOW(0x30)
	BRNE _0x2A
	RCALL SUBOPT_0xE
	CPI  R26,LOW(0x30)
	BREQ _0x2B
_0x2A:
	RJMP _0x29
_0x2B:
; 0000 012E     {
; 0000 012F       mundur();
	RCALL _mundur
; 0000 0130     //  printf("arah mundur %c, %c",datas[16],datas[18]);
; 0000 0131     }
; 0000 0132     else if (datas[16]=='1' && datas[18]=='0')
	RJMP _0x2C
_0x29:
	RCALL SUBOPT_0xD
	CPI  R26,LOW(0x31)
	BRNE _0x2E
	RCALL SUBOPT_0xE
	CPI  R26,LOW(0x30)
	BREQ _0x2F
_0x2E:
	RJMP _0x2D
_0x2F:
; 0000 0133     {
; 0000 0134       kanan90();
	RCALL _kanan90
; 0000 0135      // printf("arah kanan %c, %c",datas[16],datas[18]);
; 0000 0136     }
; 0000 0137     else if (datas[16]=='0' && datas[18]=='1')
	RJMP _0x30
_0x2D:
	RCALL SUBOPT_0xD
	CPI  R26,LOW(0x30)
	BRNE _0x32
	RCALL SUBOPT_0xE
	CPI  R26,LOW(0x31)
	BREQ _0x33
_0x32:
	RJMP _0x31
_0x33:
; 0000 0138     {
; 0000 0139       kiri90();
	RCALL _kiri90
; 0000 013A     //  printf("arah kiri %c, %c",datas[16],datas[18]);
; 0000 013B     }
; 0000 013C }
_0x31:
_0x30:
_0x2C:
_0x28:
	RET
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_getchar:
getchar0:
     sbis usr,rxc
     rjmp getchar0
     in   r30,udr
	RET
_putchar:
	ST   -Y,R26
putchar0:
     sbis usr,udre
     rjmp putchar0
     ld   r30,y
     out  udr,r30
	ADIW R28,1
	RET
_put_usart_G100:
	RCALL SUBOPT_0xF
	LDD  R26,Y+2
	RCALL _putchar
	LD   R26,Y
	LDD  R27,Y+1
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	ADIW R28,3
	RET
__print_G100:
	RCALL SUBOPT_0xF
	SBIW R28,6
	RCALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2000016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x200001C
	CPI  R18,37
	BRNE _0x200001D
	LDI  R17,LOW(1)
	RJMP _0x200001E
_0x200001D:
	RCALL SUBOPT_0x10
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	RCALL SUBOPT_0x10
	RJMP _0x20000C9
_0x2000020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000021
	LDI  R16,LOW(1)
	RJMP _0x200001B
_0x2000021:
	CPI  R18,43
	BRNE _0x2000022
	LDI  R20,LOW(43)
	RJMP _0x200001B
_0x2000022:
	CPI  R18,32
	BRNE _0x2000023
	LDI  R20,LOW(32)
	RJMP _0x200001B
_0x2000023:
	RJMP _0x2000024
_0x200001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2000025
_0x2000024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2000026
	ORI  R16,LOW(128)
	RJMP _0x200001B
_0x2000026:
	RJMP _0x2000027
_0x2000025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x200001B
_0x2000027:
	CPI  R18,48
	BRLO _0x200002A
	CPI  R18,58
	BRLO _0x200002B
_0x200002A:
	RJMP _0x2000029
_0x200002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200001B
_0x2000029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x200002F
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x11
	LDD  R26,Z+4
	ST   -Y,R26
	RCALL SUBOPT_0x13
	RJMP _0x2000030
_0x200002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2000032
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x15
	RCALL _strlen
	MOV  R17,R30
	RJMP _0x2000033
_0x2000032:
	CPI  R30,LOW(0x70)
	BRNE _0x2000035
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x15
	RCALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2000033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2000036
_0x2000035:
	CPI  R30,LOW(0x64)
	BREQ _0x2000039
	CPI  R30,LOW(0x69)
	BRNE _0x200003A
_0x2000039:
	ORI  R16,LOW(4)
	RJMP _0x200003B
_0x200003A:
	CPI  R30,LOW(0x75)
	BRNE _0x200003C
_0x200003B:
	LDI  R30,LOW(_tbl10_G100*2)
	LDI  R31,HIGH(_tbl10_G100*2)
	RCALL SUBOPT_0x16
	LDI  R17,LOW(5)
	RJMP _0x200003D
_0x200003C:
	CPI  R30,LOW(0x58)
	BRNE _0x200003F
	ORI  R16,LOW(8)
	RJMP _0x2000040
_0x200003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2000071
_0x2000040:
	LDI  R30,LOW(_tbl16_G100*2)
	LDI  R31,HIGH(_tbl16_G100*2)
	RCALL SUBOPT_0x16
	LDI  R17,LOW(4)
_0x200003D:
	SBRS R16,2
	RJMP _0x2000042
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x17
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	RCALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2000043:
	CPI  R20,0
	BREQ _0x2000044
	SUBI R17,-LOW(1)
	RJMP _0x2000045
_0x2000044:
	ANDI R16,LOW(251)
_0x2000045:
	RJMP _0x2000046
_0x2000042:
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x17
_0x2000046:
_0x2000036:
	SBRC R16,0
	RJMP _0x2000047
_0x2000048:
	CP   R17,R21
	BRSH _0x200004A
	SBRS R16,7
	RJMP _0x200004B
	SBRS R16,2
	RJMP _0x200004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x200004D
_0x200004C:
	LDI  R18,LOW(48)
_0x200004D:
	RJMP _0x200004E
_0x200004B:
	LDI  R18,LOW(32)
_0x200004E:
	RCALL SUBOPT_0x10
	SUBI R21,LOW(1)
	RJMP _0x2000048
_0x200004A:
_0x2000047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x200004F
_0x2000050:
	CPI  R19,0
	BREQ _0x2000052
	SBRS R16,3
	RJMP _0x2000053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	RCALL SUBOPT_0x16
	RJMP _0x2000054
_0x2000053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2000054:
	RCALL SUBOPT_0x10
	CPI  R21,0
	BREQ _0x2000055
	SUBI R21,LOW(1)
_0x2000055:
	SUBI R19,LOW(1)
	RJMP _0x2000050
_0x2000052:
	RJMP _0x2000056
_0x200004F:
_0x2000058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	RCALL SUBOPT_0x16
_0x200005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x200005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x200005A
_0x200005C:
	CPI  R18,58
	BRLO _0x200005D
	SBRS R16,3
	RJMP _0x200005E
	SUBI R18,-LOW(7)
	RJMP _0x200005F
_0x200005E:
	SUBI R18,-LOW(39)
_0x200005F:
_0x200005D:
	SBRC R16,4
	RJMP _0x2000061
	CPI  R18,49
	BRSH _0x2000063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2000062
_0x2000063:
	RJMP _0x20000CA
_0x2000062:
	CP   R21,R19
	BRLO _0x2000067
	SBRS R16,0
	RJMP _0x2000068
_0x2000067:
	RJMP _0x2000066
_0x2000068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2000069
	LDI  R18,LOW(48)
_0x20000CA:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x200006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	RCALL SUBOPT_0x13
	CPI  R21,0
	BREQ _0x200006B
	SUBI R21,LOW(1)
_0x200006B:
_0x200006A:
_0x2000069:
_0x2000061:
	RCALL SUBOPT_0x10
	CPI  R21,0
	BREQ _0x200006C
	SUBI R21,LOW(1)
_0x200006C:
_0x2000066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2000059
	RJMP _0x2000058
_0x2000059:
_0x2000056:
	SBRS R16,0
	RJMP _0x200006D
_0x200006E:
	CPI  R21,0
	BREQ _0x2000070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL SUBOPT_0x13
	RJMP _0x200006E
_0x2000070:
_0x200006D:
_0x2000071:
_0x2000030:
_0x20000C9:
	LDI  R17,LOW(0)
_0x200001B:
	RJMP _0x2000016
_0x2000018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	RCALL __GETW1P
	RCALL __LOADLOCR6
	ADIW R28,20
	RET
_printf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	RCALL __SAVELOCR2
	MOVW R26,R28
	ADIW R26,4
	RCALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+4,R30
	STD  Y+4+1,R30
	STD  Y+6,R30
	STD  Y+6+1,R30
	MOVW R26,R28
	ADIW R26,8
	RCALL SUBOPT_0x18
	LDI  R30,LOW(_put_usart_G100)
	LDI  R31,HIGH(_put_usart_G100)
	RCALL SUBOPT_0x4
	MOVW R26,R28
	ADIW R26,8
	RCALL __print_G100
	RCALL __LOADLOCR2
	ADIW R28,8
	POP  R15
	RET
_get_usart_G100:
	RCALL SUBOPT_0xF
	ST   -Y,R17
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LDI  R30,LOW(0)
	ST   X,R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	LD   R30,X
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2000078
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0x2000079
_0x2000078:
	RCALL _getchar
	MOV  R17,R30
_0x2000079:
	MOV  R30,R17
	LDD  R17,Y+0
	ADIW R28,5
	RET
__scanf_G100:
	RCALL SUBOPT_0xF
	SBIW R28,5
	RCALL __SAVELOCR6
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STD  Y+8,R30
	STD  Y+8+1,R31
	MOV  R20,R30
_0x200007F:
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	ADIW R30,1
	STD  Y+17,R30
	STD  Y+17+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R19,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000081
	RCALL SUBOPT_0x19
	BREQ _0x2000082
_0x2000083:
	IN   R30,SPL
	IN   R31,SPH
	RCALL SUBOPT_0x4
	PUSH R20
	RCALL SUBOPT_0x13
	POP  R20
	MOV  R19,R30
	CPI  R30,0
	BREQ _0x2000086
	RCALL SUBOPT_0x19
	BRNE _0x2000087
_0x2000086:
	RJMP _0x2000085
_0x2000087:
	RCALL SUBOPT_0x1A
	BRGE _0x2000088
	RCALL SUBOPT_0x1B
	RJMP _0x2060001
_0x2000088:
	RJMP _0x2000083
_0x2000085:
	MOV  R20,R19
	RJMP _0x2000089
_0x2000082:
	CPI  R19,37
	BREQ PC+2
	RJMP _0x200008A
	LDI  R21,LOW(0)
_0x200008B:
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	LPM  R19,Z+
	STD  Y+17,R30
	STD  Y+17+1,R31
	CPI  R19,48
	BRLO _0x200008F
	CPI  R19,58
	BRLO _0x200008E
_0x200008F:
	RJMP _0x200008D
_0x200008E:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R19
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200008B
_0x200008D:
	CPI  R19,0
	BRNE _0x2000091
	RJMP _0x2000081
_0x2000091:
_0x2000092:
	IN   R30,SPL
	IN   R31,SPH
	RCALL SUBOPT_0x4
	PUSH R20
	RCALL SUBOPT_0x13
	POP  R20
	MOV  R18,R30
	MOV  R26,R30
	RCALL _isspace
	CPI  R30,0
	BREQ _0x2000094
	RCALL SUBOPT_0x1A
	BRGE _0x2000095
	RCALL SUBOPT_0x1B
	RJMP _0x2060001
_0x2000095:
	RJMP _0x2000092
_0x2000094:
	CPI  R18,0
	BRNE _0x2000096
	RJMP _0x2000097
_0x2000096:
	MOV  R20,R18
	CPI  R21,0
	BRNE _0x2000098
	LDI  R21,LOW(255)
_0x2000098:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0x200009C
	RCALL SUBOPT_0x1C
	IN   R30,SPL
	IN   R31,SPH
	RCALL SUBOPT_0x4
	PUSH R20
	RCALL SUBOPT_0x13
	POP  R20
	MOVW R26,R16
	ST   X,R30
	RCALL SUBOPT_0x1A
	BRGE _0x200009D
	RCALL SUBOPT_0x1B
	RJMP _0x2060001
_0x200009D:
	RJMP _0x200009B
_0x200009C:
	CPI  R30,LOW(0x73)
	BRNE _0x20000A6
	RCALL SUBOPT_0x1C
_0x200009F:
	MOV  R30,R21
	SUBI R21,1
	CPI  R30,0
	BREQ _0x20000A1
	IN   R30,SPL
	IN   R31,SPH
	RCALL SUBOPT_0x4
	PUSH R20
	RCALL SUBOPT_0x13
	POP  R20
	MOV  R19,R30
	CPI  R30,0
	BREQ _0x20000A3
	RCALL SUBOPT_0x19
	BREQ _0x20000A2
_0x20000A3:
	RCALL SUBOPT_0x1A
	BRGE _0x20000A5
	RCALL SUBOPT_0x1B
	RJMP _0x2060001
_0x20000A5:
	RJMP _0x20000A1
_0x20000A2:
	PUSH R17
	PUSH R16
	__ADDWRN 16,17,1
	MOV  R30,R19
	POP  R26
	POP  R27
	ST   X,R30
	RJMP _0x200009F
_0x20000A1:
	MOVW R26,R16
	LDI  R30,LOW(0)
	ST   X,R30
	RJMP _0x200009B
_0x20000A6:
	LDI  R30,LOW(1)
	STD  Y+10,R30
	MOV  R30,R19
	CPI  R30,LOW(0x64)
	BREQ _0x20000AB
	CPI  R30,LOW(0x69)
	BRNE _0x20000AC
_0x20000AB:
	LDI  R30,LOW(0)
	STD  Y+10,R30
	RJMP _0x20000AD
_0x20000AC:
	CPI  R30,LOW(0x75)
	BRNE _0x20000AE
_0x20000AD:
	LDI  R18,LOW(10)
	RJMP _0x20000A9
_0x20000AE:
	CPI  R30,LOW(0x78)
	BRNE _0x20000AF
	LDI  R18,LOW(16)
	RJMP _0x20000A9
_0x20000AF:
	CPI  R30,LOW(0x25)
	BRNE _0x20000B2
	RJMP _0x20000B1
_0x20000B2:
	RJMP _0x2060002
_0x20000A9:
	LDI  R30,LOW(0)
	STD  Y+6,R30
	STD  Y+6+1,R30
_0x20000B3:
	MOV  R30,R21
	SUBI R21,1
	CPI  R30,0
	BREQ _0x20000B5
	IN   R30,SPL
	IN   R31,SPH
	RCALL SUBOPT_0x4
	PUSH R20
	RCALL SUBOPT_0x13
	POP  R20
	MOV  R19,R30
	CPI  R30,LOW(0x21)
	BRSH _0x20000B6
	RCALL SUBOPT_0x1A
	BRGE _0x20000B7
	RCALL SUBOPT_0x1B
	RJMP _0x2060001
_0x20000B7:
	RJMP _0x20000B8
_0x20000B6:
	LDD  R30,Y+10
	CPI  R30,0
	BRNE _0x20000B9
	CPI  R19,45
	BRNE _0x20000BA
	LDI  R30,LOW(255)
	STD  Y+10,R30
	RJMP _0x20000B3
_0x20000BA:
	LDI  R30,LOW(1)
	STD  Y+10,R30
_0x20000B9:
	CPI  R18,16
	BRNE _0x20000BC
	MOV  R26,R19
	RCALL _isxdigit
	CPI  R30,0
	BREQ _0x20000B8
	RJMP _0x20000BE
_0x20000BC:
	MOV  R26,R19
	RCALL _isdigit
	CPI  R30,0
	BRNE _0x20000BF
_0x20000B8:
	MOV  R20,R19
	RJMP _0x20000B5
_0x20000BF:
_0x20000BE:
	CPI  R19,97
	BRLO _0x20000C0
	SUBI R19,LOW(87)
	RJMP _0x20000C1
_0x20000C0:
	CPI  R19,65
	BRLO _0x20000C2
	SUBI R19,LOW(55)
	RJMP _0x20000C3
_0x20000C2:
	SUBI R19,LOW(48)
_0x20000C3:
_0x20000C1:
	MOV  R30,R18
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RCALL SUBOPT_0xC
	RCALL __MULW12U
	MOVW R26,R30
	MOV  R30,R19
	RCALL SUBOPT_0xC
	ADD  R30,R26
	ADC  R31,R27
	RCALL SUBOPT_0x16
	RJMP _0x20000B3
_0x20000B5:
	RCALL SUBOPT_0x1C
	LDD  R30,Y+10
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R31,0
	SBRC R30,7
	SER  R31
	RCALL __MULW12U
	MOVW R26,R16
	ST   X+,R30
	ST   X,R31
_0x200009B:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,1
	STD  Y+8,R30
	STD  Y+8+1,R31
	RJMP _0x20000C4
_0x200008A:
_0x20000B1:
	IN   R30,SPL
	IN   R31,SPH
	RCALL SUBOPT_0x4
	PUSH R20
	RCALL SUBOPT_0x13
	POP  R20
	CP   R30,R19
	BREQ _0x20000C5
	RCALL SUBOPT_0x1A
	BRGE _0x20000C6
	RCALL SUBOPT_0x1B
	RJMP _0x2060001
_0x20000C6:
_0x2000097:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	SBIW R30,0
	BRNE _0x20000C7
	RCALL SUBOPT_0x1B
	RJMP _0x2060001
_0x20000C7:
	RJMP _0x2000081
_0x20000C5:
_0x20000C4:
_0x2000089:
	RJMP _0x200007F
_0x2000081:
_0x2060002:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
_0x2060001:
	RCALL __LOADLOCR6
	ADIW R28,19
	RET
_scanf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,3
	RCALL __SAVELOCR2
	MOVW R26,R28
	ADIW R26,1
	RCALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,LOW(0)
	STD  Y+3,R30
	STD  Y+3+1,R30
	MOVW R26,R28
	ADIW R26,5
	RCALL SUBOPT_0x18
	LDI  R30,LOW(_get_usart_G100)
	LDI  R31,HIGH(_get_usart_G100)
	RCALL SUBOPT_0x4
	MOVW R26,R28
	ADIW R26,8
	RCALL __scanf_G100
	RCALL __LOADLOCR2
	ADIW R28,5
	POP  R15
	RET

	.CSEG
_isdigit:
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    cpi  r31,'0'
    brlo isdigit0
    cpi  r31,'9'+1
    brlo isdigit1
isdigit0:
    clr  r30
isdigit1:
    ret
_isspace:
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    cpi  r31,' '
    breq isspace1
    cpi  r31,9
    brlo isspace0
    cpi  r31,13+1
    brlo isspace1
isspace0:
    clr  r30
isspace1:
    ret
_isxdigit:
	ST   -Y,R26
    ldi  r30,1
    ld   r31,y+
    subi r31,0x30
    brcs isxdigit0
    cpi  r31,10
    brcs isxdigit1
    andi r31,0x5f
    subi r31,7
    cpi  r31,10
    brcs isxdigit0
    cpi  r31,16
    brcs isxdigit1
isxdigit0:
    clr  r30
isxdigit1:
    ret

	.CSEG
_strlen:
	RCALL SUBOPT_0xF
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
	RCALL SUBOPT_0xF
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret

	.DSEG
_datas:
	.BYTE 0x14
_pwml:
	.BYTE 0x4
_pwmr:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	__GETD1N 0xF0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2:
	STS  _pwml,R30
	STS  _pwml+1,R31
	STS  _pwml+2,R22
	STS  _pwml+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3:
	STS  _pwmr,R30
	STS  _pwmr+1,R31
	STS  _pwmr+2,R22
	STS  _pwmr+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x4:
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	RCALL SUBOPT_0x4
	LDI  R30,LOW(_datas)
	LDI  R31,HIGH(_datas)
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x6:
	RCALL __PUTPARD1
	LDI  R24,8
	RCALL _printf
	ADIW R28,10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x7:
	LDS  R30,_pwmr
	OUT  0x2A,R30
	LDS  R30,_pwml
	OUT  0x28,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x8:
	LDI  R26,LOW(_datas)
	LDI  R27,HIGH(_datas)
	ADD  R26,R10
	ADC  R27,R11
	LD   R26,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	SUBI R30,LOW(48)
	LDI  R26,LOW(100)
	MULS R30,R26
	MOV  R16,R0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	SUBI R30,LOW(48)
	LDI  R26,LOW(10)
	MULS R30,R26
	MOV  R19,R0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	SUBI R30,LOW(48)
	MOV  R18,R30
	MOV  R30,R19
	ADD  R30,R16
	ADD  R30,R18
	MOV  R17,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xC:
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	__GETB2MN _datas,16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	__GETB2MN _datas,18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	ST   -Y,R27
	ST   -Y,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x10:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x11:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x12:
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:30 WORDS
SUBOPT_0x13:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x14:
	RCALL SUBOPT_0x11
	RJMP SUBOPT_0x12

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x15:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x16:
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x17:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x18:
	RCALL __ADDW2R15
	RCALL __GETW1P
	RCALL SUBOPT_0x4
	ST   -Y,R17
	ST   -Y,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x19:
	MOV  R26,R19
	RCALL _isspace
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1A:
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	LD   R26,X
	CPI  R26,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x1B:
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x1C:
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	SBIW R30,4
	STD  Y+15,R30
	STD  Y+15+1,R31
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	ADIW R26,4
	LD   R16,X+
	LD   R17,X
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
