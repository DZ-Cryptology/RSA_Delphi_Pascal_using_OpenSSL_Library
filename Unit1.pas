unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, MMSystem,libeay32;

type
  TForm1 = class(TForm)
    meLog: TMemo;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Button5: TButton;
    meHashedInput: TMemo;
    Button6: TButton;
    Button7: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  var
FPublicKey: pEVP_PKEY;
FPrivateKey: pEVP_PKEY;
var
  aPathToPublickKey, aPathToPrivateKey: string;

var
	rsa: pRSA; // structure RSA
	size: Integer;
	FCryptedBuffer: pointer; // output buffer
	b64, mem: pBIO;
	str, data: AnsiString;
	len, b64len: Integer;
	penc64: PAnsiChar;
	err: Cardinal;
  //------------------------
  var
  rsa0: pRSA;
  out_0: AnsiString;
  str0, data0: PAnsiChar;
  len0, b64len0: Integer;
  penc640: PAnsiChar;
  b640, mem0, bio_out0, bio0: pBIO;
  size0: Integer;
  err0: Cardinal;
  ACryptedData0 : ansistring;  // string in Base64

implementation

{$R *.dfm}

procedure LoadSSL;
begin
  OpenSSL_add_all_algorithms;
  OpenSSL_add_all_ciphers;
  OpenSSL_add_all_digests;
  ERR_load_crypto_strings;
  ERR_load_RSA_strings;
end;


procedure FreeSSL;
begin
  EVP_cleanup;
  ERR_free_strings;
end;


function SHA1(AData: string): string;
var
  Len: cardinal;
  mdctx: EVP_MD_CTX;
  inbuf, outbuf: array [0..1023] of char;
begin
  StrPCopy(inbuf, AData);
  LoadSSL;

  EVP_DigestInit(@mdctx, EVP_sha1);
  EVP_DigestUpdate(@mdctx, @inbuf, StrLen(inbuf));
  EVP_DigestFinal(@mdctx, @outbuf, Len);

  FreeSSL;
  BinToHex(outbuf, inbuf,Len);
  inbuf[2*Len] := #0;
  result := StrPas(inbuf);
end;


function LoadPublicKey(KeyFile: string) :pEVP_PKEY ;
var
  mem: pBIO;
  k: pEVP_PKEY;
begin
  k:=nil;
  mem := BIO_new(BIO_s_file());
  BIO_read_filename(mem, PAnsiChar(KeyFile));
  try
    result := PEM_read_bio_PUBKEY(mem, k, nil, nil);
  finally
    BIO_free_all(mem);
  end;
end;

function LoadPrivateKey(KeyFile: string) :pEVP_PKEY;
var
  mem: pBIO;
  k: pEVP_PKEY;
begin
  k := nil;
  mem := BIO_new(BIO_s_file());
  BIO_read_filename(mem, PAnsiChar(KeyFile));
  try
    result := PEM_read_bio_PrivateKey(mem, k, nil, nil);
  finally
    BIO_free_all(mem);
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);

begin
FORM1.Caption:=' memo1 text length ='+inttostr(length(memo1.Text));
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
meHashedInput.Text := SHA1(Memo1.Text);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  FPrivateKey := LoadPrivateKey('C:\Users\user\Desktop\Nouveau\private.pem');
  LoadSSL;
	rsa := EVP_PKEY_get1_RSA(FPrivateKey); // Get RSA structure
	EVP_PKEY_free(FPrivateKey); // Release pEVP_PKEY
	size := RSA_size(rsa); // Getting the key size
	GetMem(FCryptedBuffer, size); // Determining the size of the output buffer
	str := memo1.Text; // String to encrypt

  if length(memo1.Text) < 118 then
  begin
  //Encryption
  len := RSA_private_encrypt(Length(str),PAnsiChar(str),FCryptedBuffer,rsa,RSA_PKCS1_PADDING);
	//len := RSA_public_encrypt(Length(str),PAnsiChar(str),FCryptedBuffer,rsa,RSA_PKCS1_PADDING);

	if len > 0 then
	  begin
		b64 := BIO_new(BIO_f_base64); // BIO in base64
		mem := BIO_push(b64, BIO_new(BIO_s_mem)); // Stream
		try
			BIO_write(mem, FCryptedBuffer, len); //
			BIO_flush(mem);
			b64len := BIO_get_mem_data(mem, penc64); //
			SetLength(data, b64len); //
			Move(penc64^, PAnsiChar(data)^, b64len); //
      memo2.TEXT:=data;
      //ShowMessage(data);
		finally
			BIO_free_all(mem);
		end;
	  end
	  else
	  begin
		err := ERR_get_error;
		repeat
			meLog.Lines.Add(string(ERR_error_string(err, nil)));
			err := ERR_get_error;
		until err = 0;
	  end;
	RSA_free(rsa);
  end  else showmessage('for RSA_PKCS1_PADDING the length of the string must be under 118 bytes');
freeSSL;
end;




procedure TForm1.Button7Click(Sender: TObject);

begin
FPublicKey := LoadPublicKey('C:\Users\user\Desktop\Nouveau\public.pem');
LoadSSL;
  ACryptedData0 := memo2.Text;
	rsa0 := EVP_PKEY_get1_RSA(FPublicKey);
	size0 := RSA_size(rsa0);
	GetMem(data0, size0);  // Determine the size of the output buffer of the decrypted string
	GetMem(str0, size0);   // Determine the size of the encrypted buffer after converting from base64

  //Decode base64
	b640 := BIO_new(BIO_f_base64);
	mem0 := BIO_new_mem_buf(PAnsiChar(ACryptedData0), Length(ACryptedData0));
	BIO_flush(mem0);
	mem0 := BIO_push(b640, mem0);
	BIO_read(mem0, str0 , Length(ACryptedData0));
	BIO_free_all(mem0);
  len0 := RSA_public_decrypt(size0, PAnsiChar(str0), data0, rsa0, RSA_PKCS1_PADDING);
	//len := RSA_private_decrypt(size, PAnsiChar(str), data, rsa, RSA_PKCS1_PADDING);
	if len0 > 0 then
	begin
		SetLength(out_0, len0);
		Move(data0^, PAnsiChar(out_0 )^, len0);
    memo3.Text:=out_0;
    //ShowMessage(out_0);
	end
	else
    begin
		err0 := ERR_get_error;
		repeat
			meLog.Lines.Add(string(ERR_error_string(err0, nil)));
			err0 := ERR_get_error;
		until err0 = 0;
	end;

EVP_cleanup;
ERR_free_strings;
freeSSL;
label1.Caption:=' memo3 text length ='+inttostr(length(memo3.Text));
end;


procedure TForm1.Memo1Change(Sender: TObject);
begin
FORM1.Caption:=' memo1 text length ='+inttostr(length(memo1.Text));
end;




end.
