object Form1: TForm1
  Left = 216
  Top = 124
  Width = 857
  Height = 549
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 240
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object meLog: TMemo
    Left = 8
    Top = 368
    Width = 481
    Height = 137
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 481
    Height = 97
    Lines.Strings = (
      'write the text to encrypt here')
    ScrollBars = ssBoth
    TabOrder = 1
    OnChange = Memo1Change
  end
  object Memo2: TMemo
    Left = 8
    Top = 112
    Width = 481
    Height = 105
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object Memo3: TMemo
    Left = 8
    Top = 264
    Width = 481
    Height = 97
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object Button5: TButton
    Left = 512
    Top = 72
    Width = 57
    Height = 25
    Caption = 'SHA1'
    TabOrder = 4
    OnClick = Button5Click
  end
  object meHashedInput: TMemo
    Left = 512
    Top = 104
    Width = 297
    Height = 401
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object Button6: TButton
    Left = 512
    Top = 8
    Width = 169
    Height = 25
    Caption = 'encrypt with private key'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 512
    Top = 40
    Width = 169
    Height = 25
    Caption = 'decrypt with public key'
    TabOrder = 7
    OnClick = Button7Click
  end
end
