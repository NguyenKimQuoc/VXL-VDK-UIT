#include<at89x51.h>                      //khai b�o thu vi?n cho V�K 89x51
main()
{
            TMOD=0x02;           //ch?n timer0, ch? d? 2, 8Bit t? n?p l?i
            TL0=0xA4;               //n?p gi� tr? cho TL0
            TH0=0xA4;              //n?p gi� tr? cho TH0
            TR0=1;                        //kh?i d?ng timer0
            IE=0x82;                     //cho ph�p ng?t timer0

            while(1)                    //v�ng l?p v� h?n
            {
                        P1=~P0;         //C?p nh?t gi� tr? cho c?ng P1 t? P0.
            }
}
void songvuong(void) interrupt 1   //Khai b�o tr�nh ph?c v? ng?t cho timer0
{
            TR0=0;                       //Ng?ng timer0
            P2_1=~P2_1;                        //�?o tr?ng th�i ch�n P2_1.
            TR0=1;                       //Kh?i d?ng timer0
                                                //Kh�ng c?n x�a c? TF0, 8051 t? d?ng x�a.
}