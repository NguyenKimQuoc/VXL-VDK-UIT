#include<at89x51.h>                      //khai báo thu vi?n cho VÐK 89x51
main()
{
            TMOD=0x02;           //ch?n timer0, ch? d? 2, 8Bit t? n?p l?i
            TL0=0xA4;               //n?p giá tr? cho TL0
            TH0=0xA4;              //n?p giá tr? cho TH0
            TR0=1;                        //kh?i d?ng timer0
            IE=0x82;                     //cho phép ng?t timer0

            while(1)                    //vòng l?p vô h?n
            {
                        P1=~P0;         //C?p nh?t giá tr? cho c?ng P1 t? P0.
            }
}
void songvuong(void) interrupt 1   //Khai báo trình ph?c v? ng?t cho timer0
{
            TR0=0;                       //Ng?ng timer0
            P2_1=~P2_1;                        //Ð?o tr?ng thái chân P2_1.
            TR0=1;                       //Kh?i d?ng timer0
                                                //Không c?n xóa c? TF0, 8051 t? d?ng xóa.
}