#include<at89x51.h>                      //khai b�o thu vi?n cho 89c51
void send(unsigned char a);           //khai b�o nguy�n m?u h�m g?i 1 k� t?
main()                                                            //Chuong tr�nh ch�nh
{
            TMOD=0x20;                       //Ch?n Timer1, ch? d? 2
            TH1=0xFA;                           //C�i d?t t?c d? 4800 baud
            SCON=0x50;                                    //0101 0000: Ch?n ch? d? 1, Cho ph�p nh?n
            TR1=1;                                   //Kh?i d?ng Timer1

            while(1)                                 //V�ng l?p v� h?n
            {
                        send('D');                   //G?i h�m g?i 1 k� t? l�n m�y t�nh
            }
}
void send(unsigned char a)                        //�?nh nghia h�m g?i 1 k� t?
{
            SBUF=a;                                //Ghi 1 byte d? li?u v�o thanh ghi SBUF
            while(TI==0){}                    //v�ng l?p d? d?i c? truy?n TI l�n 1
            TI=0;                                      //X�a c? truy?n TI sau khi truy?n xong
}