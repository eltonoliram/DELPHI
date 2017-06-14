object Form1: TForm1
  Left = 415
  Top = 280
  Width = 636
  Height = 243
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    620
    204)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 24
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 112
    Top = 32
    Width = 479
    Height = 137
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
