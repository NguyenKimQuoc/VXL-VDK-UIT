#include<at89x51.h>                      //khai báo thu vi?n cho 89c51
void send(unsigned char a);           //khai báo nguyên m?u hàm g?i 1 ký t?
main()                                                            //Chuong trình chính
{
            TMOD=0x20;                       //Ch?n Timer1, ch? d? 2
            TH1=0xFA;                           //Cài d?t t?c d? 4800 baud
            SCON=0x50;                                    //0101 0000: Ch?n ch? d? 1, Cho phép nh?n
            TR1=1;                                   //Kh?i d?ng Timer1

            while(1)                                 //Vòng l?p vô h?n
            {
                        send('D');                   //G?i hàm g?i 1 ký t? lên máy tính
            }
}
void send(unsigned char a)                        //Ð?nh nghia hàm g?i 1 ký t?
{
            SBUF=a;                                //Ghi 1 byte d? li?u vào thanh ghi SBUF
            while(TI==0){}                    //vòng l?p d? d?i c? truy?n TI lên 1
            TI=0;                                      //Xóa c? truy?n TI sau khi truy?n xong
}