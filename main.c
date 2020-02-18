/* ブート起動用内蔵ROMプログラム(ブートモード1) */
/* 参考：Renesas アプリケーションノート SH7262/SH7264 グループ シリアルフラッシュメモリからのブート例 RJJ06B1015 */

#define FRQCR (*(volatile unsigned short*)(0xFFFE0010))
#define PFCR3 (*(volatile unsigned short*)(0xFFFE38A8))
#define PFCR2 (*(volatile unsigned short*)(0xFFFE38AA))
#define STBCR5 (*(volatile unsigned char*)(0xFFFE0410))
#define SPCR_0 (*(volatile unsigned char*)(0xFFFF8000))
#define SSLP_0 (*(volatile unsigned char*)(0xFFFF8001))
#define SPPCR_0 (*(volatile unsigned char*)(0xFFFF8002))
#define SPSR_0 (*(volatile unsigned char*)(0xFFFF8003))
#define SPDR_0 (*(volatile unsigned char*)(0xFFFF8004))
#define SPSCR_0 (*(volatile unsigned char*)(0xFFFF8008))
#define SPBR_0 (*(volatile unsigned char*)(0xFFFF800A))
#define SPDCR_0 (*(volatile unsigned char*)(0xFFFF800B))
#define SPCKD_0 (*(volatile unsigned char*)(0xFFFF800C))
#define SSLND_0 (*(volatile unsigned char*)(0xFFFF800D))
#define SPCMD_00 (*(volatile unsigned short*)(0xFFFF8010))
#define SPBFCR_0 (*(volatile unsigned char*)(0xFFFF8020))

void system_down(void)
{
	while (1)
	{
	}
}

void halt(void)
{
	while (1)
	{
	}
}

static void SetImask(unsigned long val)
{
	unsigned long sr;
	__asm__("stc sr,%0" : "=r" (sr));
	sr = (sr & 0xffffff0f) | ((val << 4) & 0x000000f0);
	__asm__("ldc %0,sr" : : "r" (sr));
}

static void SetVBR(unsigned long val)
{
	unsigned long vbr;
	vbr = val;
	__asm__("ldc %0,vbr" : : "r" (vbr));
}

void (*vectors[])(void) __attribute__((section(".rodata"))) = {
	(void*)system_down,
	(void*)0xFFF83000,
	(void*)system_down,
	(void*)0xFFF83000,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
	(void*)system_down,
};

void io_wait_tx_end(void)
{
}

void io_cmd_exe_rdmode(unsigned char *ope, int ope_sz, unsigned char *rd, int rd_sz)
{
	SPBFCR_0 = 0xC0;
	SPBFCR_0 = 0x00;

	SPCR_0 = SPCR_0 | 0x40;

	SPCMD_00 = (SPCMD_00 & 0xfffc) | 0x0002;

	while (ope_sz--)
	{
		SPDR_0 = *ope++;
	}
	io_wait_tx_end();

	SPCMD_00 = (SPCMD_00 & 0xfffc) | 0x0001;
	
	SPBFCR_0 = 0xC0;
	SPBFCR_0 = 0x00;

	SPDCR_0 = (SPDCR_0 & 0x7f) | 0x10;
	while (rd_sz--)
	{
		while ((SPSR_0 & 0x80) == 0x00)
		{
		}
		*rd++ = SPDR_0;
	}
	SPDCR_0 = (SPDCR_0 & 0x7f) | 0x00;
	io_wait_tx_end();
}

void sf_byte_read(unsigned long addr, unsigned char *buf, int size)
{
	unsigned char cmd[4];

	cmd[0] = 0x03; /* READ */
	cmd[1] = (unsigned char)((addr >> 16) & 0xff);
	cmd[2] = (unsigned char)((addr >> 8) & 0xff);
	cmd[3] = (unsigned char)((addr >> 0) & 0xff);
	io_cmd_exe_rdmode(cmd, 4, buf, size);
}

void main(void)
{
	/* ブート起動用のスタックポインタを設定 */
	/* ここ(main関数)に来る前にアセンブラ言語で設定済み */

	/* 浮動小数点ステータス／コントロールレジスタ（FPSCR）の設定 */
	/* FPSCRにH'00040001（単精度演算、丸めモード 0  方向への丸め）を設定 */
	/* ここ(main関数)に来る前にアセンブラ言語で設定済み */

	/* ベクタベースレジスタ（VBR）の設定 */
	/* 例外だけ処理する必要あり */
	SetVBR((unsigned long)vectors);

	/* 割り込みマスク */
	SetImask(15);

/*	{
		volatile int a = 3;
		volatile int b = 9;
		volatile int c;
		c = b / a;
	}*/

	/* 周波数制御レジスタ（FRQCR）の設定 */
	FRQCR = 0x1104;	/* クロック設定: I=144M, B=48M, P=24M */

	/* スタンバイコントロールレジスタ3～8の設定 */

	/* キャッシュ有効化 */
	/* 使わないなら有効化しなくて良い? */

	/* ルネサスシリアルペリフェラルインタフェースのチャネル0（RSPI0）の設定 */
	PFCR3 = 0x0003;
	PFCR2 = 0x3330;
	STBCR5 = 0xFD;
	SPCR_0 = 0x00;
	SPPCR_0 = 0x30;
	SPBR_0 = 0x00;
	SPDCR_0 = 0x20;
	SPCKD_0 = 0x00;
	SSLND_0 = 0x00;
	SPSCR_0 = 0x00;
	SPCMD_00 = 0xE780;
	SPBFCR_0 = 0xC0;
	SPBFCR_0 = 0x00;
	SSLP_0 = 0x00;
	SPCR_0 = 0x48;

	/* ローダプログラムの転送 */
	sf_byte_read(0, (unsigned char*)0xFFF80000, 0x2000/*0x10*/);

	/* キャッシュのライトバック処理 */
	/* キャッシュ有効化してなければライトバックしなくて良い? */

	/* ローダプログラムのスタックポインタを設定 */
	/*__asm__("movi20 #-487424,sp");*/
	__asm__("mov %0,sp" : : "r" (0xFFF89000));

	/* ローダプログラムのエントリ関数に分岐 */
	/*__asm__("jmp @r1");
	__asm__("movi20 #-524288,r1");*/
	((void (*)(void))0xFFF80000)();

	halt();
}

