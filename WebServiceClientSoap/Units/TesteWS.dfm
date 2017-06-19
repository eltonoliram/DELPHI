object Form1: TForm1
  Left = 481
  Top = 96
  Width = 734
  Height = 495
  Caption = 'Teste WS Abtra'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    718
    456)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 29
    Top = 405
    Width = 27
    Height = 13
    Caption = 'Cod:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 29
    Top = 423
    Width = 28
    Height = 13
    Caption = 'Msg:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbCod: TLabel
    Left = 66
    Top = 406
    Width = 3
    Height = 13
    Caption = '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object lbMsg: TLabel
    Left = 66
    Top = 424
    Width = 3
    Height = 13
    Caption = '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 24
    Top = 32
    Width = 161
    Height = 25
    Caption = 'Montar Requisi'#231#227'o'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 216
    Top = 32
    Width = 473
    Height = 177
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button2: TButton
    Left = 24
    Top = 216
    Width = 161
    Height = 25
    Caption = 'Enviar'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Memo2: TMemo
    Left = 216
    Top = 216
    Width = 473
    Height = 177
    Anchors = [akLeft, akTop, akRight]
    ScrollBars = ssVertical
    TabOrder = 3
  end
end
