# RSA_Delphi_Pascal_using_OpenSSL_Library<BR><BR>
This Delphi 7 project use OpenSSL library for encrypt/decrypt strings.<BR><BR>
This project use Private key for encrypt and Public key for decrypt.<BR><BR>
Don't forget to put the libeay32.dll in the same folder with your exe file<BR><BR>
you can find here The libEAY : https://github.com/nunopicado/libeay32 , last update 2017<BR><BR>
This project was developed according to works of Ivan Lodyanoy https://github.com/ddlencemc/RSA-via-OpenSSL-libeay32 but more components was deleted and the unit RSAOpenSSL.pas also deleted.<BR><BR>
This project teach how to call OpenSSL functions and procedures from Delphi 7.<BR><BR>

Generate private key using OpenSSL<BR><BR> 
openssl genrsa 1024 > private.pem<BR><BR>

Generate public key from private<BR><BR>
openssl rsa -in private.pem -pubout > public.pem<BR><BR><BR><BR>
  
<img src="https://iili.io/yTSGSt.png" alt="D" />
  
<h2 style="font-size:40px;"><center>don't forget to subscribe in our youtube channel</center></h2><BR><BR>     
<p><a href="https://youtu.be/fu7zL7QyECE"><img src="https://i.postimg.cc/MTnJc9Vk/b.png" style="width:560px;height:315px;"></a></p>



