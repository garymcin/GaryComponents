unit gemCapPanelBtn;

interface
uses
  Winapi.Windows, Winapi.Messages,

  System.Classes, System.SysUtils,

  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ActnList, Vcl.ExtCtrls,//  Vcl.Dialogs, Vcl.Buttons,

  CodeSiteLogging, GEMUseFullRoutines, GEMComponentsGlobal,

  JvImage, JvExtComponent, JvCaptionPanel;

type
  TgemCapPanelBtn = class;

  TCapPnlEventMouseEnter = procedure(sender: TgemCapPanelBtn) of object;
  TCapPnlEventMouseLeave = procedure(sender: TgemCapPanelBtn) of object;

//  TgemImPnlBtnState = (gim_MouseOver, gim_Seletected, gim_Normal);
  TgemButtonState      = (bsUp, bsDisabled, bsDown, bsExclusive);
  TgemJvDrawPosition   = (dpLeft, dpTop, dpRight, dpBottom);
//  TgemJvAutoDragStartEvent = procedure(Sender: TObject; var AllowDrag: Boolean) of object;

  {$IFDEF RTL230_UP}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF RTL230_UP}

  TgemCapPanelBtn = class(TCustomPanel)//(TJvCustomPanel)
    fImage              : TImage;
  private
    fComponentVersion   : tGEMComponents;

    fOnImage_MouseUp    : TMouseEvent;
    fOnImage_MouseDown  : TMouseEvent;
    fOnImage_MouseMove  : TMouseMoveEvent;

    fOnPnlMouseEnter    : TCapPnlEventMouseEnter;
    fOnPnlMouseLeave    : TCapPnlEventMouseLeave;

    FCaption            : string;
    FCaptionFont        : TFont;
    fCaptionHeight      : integer;
    fCaptionPosition    : TgemJvDrawPosition;
    FCaptionRect        : TRect;
    FResizable          : Boolean;
    fCaptionColor       : TColor;
    fButtonDownColor    : TColor;
    fButtonOverColor    : TColor;
    fButtonUpColor     : TColor;
    FGroupIndex         : Integer;
    FDown               : Boolean;
    FClicksDisabled     : Boolean;
    FAutoDrag           : Boolean;
    FFlat               : Boolean;
    FBevel              : Integer;
    FEndDrag            : TNotifyEvent;
    FOnStartAutoDrag    : TJvAutoDragStartEvent;
    FOutlookLook        : Boolean;
    FOffset             : Integer;
    FMouseDown          : Boolean;
    FAnchorPos          : TPoint;
    FCaptionOffsetSmall : Integer;
    FCaptionOffsetLarge : Integer;
    FAllowAllUp         : Boolean;
    FMouseInControl     : Boolean;
    FState              : TgemButtonState;

    procedure CMPanelMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMPanelMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;

    procedure ImageMouseLeaveHandler(Sender: TObject); { TNotifyEvent }
    procedure ImageMouseEnterHandler(Sender: TObject); { TNotifyEvent }
    procedure ImageMouseUpHandler(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); { TMouseEvent }
    procedure ImageMouseDownHandler(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer); { TMouseEvent }
    procedure ImageMouseMoveHandler(Sender: TObject; Shift: TShiftState; X, Y: Integer); { TMouseMoveEvent }

    function GetImage_Picture: TPicture;
    procedure SetImage_Picture(const Value: TPicture);

    function GetImage_Proportional: Boolean;
    procedure SetImage_Proportional(const Value: Boolean);
    function GetImage_Stretch: Boolean;
    procedure SetImage_Strech(const Value: Boolean);
    function GetImage_Visible: Boolean;
    procedure SetImage_Visible(const Value: Boolean);
    function GetImage_Center: Boolean;
    procedure SetImage_Center(const Value: Boolean);
    procedure SetImage_AutoSize(const Value: Boolean);
    procedure SetCaption(const Value: string);
    procedure SetCaptionColor(const Value: TColor);
    procedure SetCaptionFont(const Value: TFont);
    procedure SetCaptionHeight(const Value: Integer);
    procedure SetCaptionPosition(const Value: TgemJvDrawPosition);
    procedure SetResizable(const Value: Boolean);
    procedure setImageAlign(const Value: TAlign);
    procedure SetImageHeight(const Value: Integer);
    procedure SetImageWidth(const Value: Integer);
    procedure SetGroupIndex(const Value: Integer);

    procedure DrawRotatedText(Rotation: Integer);
    function getImageAlign: TAlign;
    function GetImage_Height: Integer;
    function GetImage_Width: Integer;
    function GetImage_AutoSize: Boolean;

    procedure SetDown(Value: Boolean);
    procedure SetAllowAllUp(const Value: Boolean);
    procedure UpdateExclusive;
    procedure SetButtonUpColor(const Value: tcolor);
    procedure SetButtonDownColor(const Value: TColor);
    procedure SetMouseOverColor(const Value: TColor);
    procedure SetFlat(const Value: Boolean);

    procedure DoCaptionFontChange(Sender: TObject);
  protected

    property MouseInControl: Boolean read FMouseInControl;

    function GetEffectiveCaptionHeight: Integer;
    function CanStartDrag: Boolean; virtual;
    procedure DoMouseEnter; virtual;
    procedure DoMouseLeave; virtual;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure Resize; override;
    procedure DoLeaveDrag; virtual;
    procedure AlignControls(AControl: TControl; var R: TRect); override;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;  X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    // Combine mouse stuff for panel and image
    procedure theMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure theMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure theMouseMove(Shift: TShiftState; X, Y: Integer);
    procedure theMouseEnter;
    procedure theMouseLeave;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destory;
    procedure Click; override;
  published
//    property Color;

    property AllowAllUp: Boolean read FAllowAllUp write SetAllowAllUp default False;
    property ClicksDisabled: Boolean read FClicksDisabled write FClicksDisabled;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property Image_Align: TAlign read getImageAlign write setImageAlign default alClient;
    property Image_AutoSize: Boolean read GetImage_AutoSize write  SetImage_AutoSize;
    property Image_Center: Boolean read GetImage_Center write  SetImage_Center;
    property Image_Picture: TPicture read GetImage_Picture write SetImage_Picture;
    property Image_Proportional: Boolean read GetImage_Proportional write SetImage_Proportional;
    property Image_Stretch: Boolean read GetImage_Stretch write SetImage_Strech;
    property Image_Visible: Boolean read GetImage_Visible write SetImage_Visible;
    property Image_Width: Integer read GetImage_Width write SetImageWidth default 50;
    property Image_Height: Integer read GetImage_Height write SetImageHeight default 50;

    property ButtonOverColor: TColor read fButtonOverColor write SetMouseOverColor default clSilver;
    property ButtonDownColor : TColor read FButtonDownColor write SetButtonDownColor default clGray;
    property ButtonUpColor: tcolor read fButtonUpColor write SetButtonUpColor default clBtnFace;
//    property ForceUpColor: TColor read fForceUpColor write SetForceUpColor default clBtnFace;

    property Down: Boolean read FDown write SetDown default False;
    property Flat: Boolean read FFlat write SetFlat default False;

//    property OnImageMouseEnter: TNotifyEvent read fOnImageMouseEnter write fOnImageMouseEnter;
//    property OnImageMouseLeave: TNotifyEvent read fOnImageMouseLeave write fOnImageMouseLeave;
//    property OnImageMouseUp: TMouseEvent read fOnImage_MouseUp write fOnImage_MouseUp;
//    property OnImageMouseDown: TMouseEvent read fOnImage_MouseDown write fOnImage_MouseDown;
//    property OnImageMouseMove: TMouseMoveEvent read fOnImage_MouseMove write fOnImage_MouseMove;

    property OnMouseEnter: TCapPnlEventMouseEnter read fOnPnlMouseEnter write fOnPnlMouseEnter;
    property OnMouseLeave: TCapPnlEventMouseLeave read fOnPnlMouseLeave write fOnPnlMouseLeave;

    property Align;
    property BorderStyle default bsSingle;
    property Caption: string read FCaption write SetCaption;
    property CaptionColor: TColor read FCaptionColor write SetCaptionColor default clActiveCaption;
    property CaptionPosition: TgemJvDrawPosition read FCaptionPosition write SetCaptionPosition default dpLeft;
    property CaptionFont: TFont read FCaptionFont write SetCaptionFont;
    property CaptionHeight: Integer read FCaptionHeight write SetCaptionHeight default 15;
    property Cursor;
    property DragCursor;
    property FullRepaint;
    property Locked;
    property DragMode;
    property Enabled;
    property Font;
    property Hint;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Resizable:Boolean read FResizable write SetResizable default True;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartAutoDrag: TJvAutoDragStartEvent read FOnStartAutoDrag write FOnStartAutoDrag;
    property OnEndAutoDrag: TNotifyEvent read FEndDrag write FEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnResize;
  end;


implementation

function DrawText(Canvas: TCanvas; const Text: string; Len: Integer; var R: TRect; WinFlags: Integer): Integer; overload;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( 'DrawText' );{$ENDIF}
  {$IFDEF UNICODE}
  Result := Winapi.Windows.DrawText(Canvas.Handle, PChar(Text), Len, R, WinFlags and not DT_MODIFYSTRING); // make sure the string cannot be modified
  {$ELSE}
  Result := DrawText(Canvas, PAnsiChar(Text), Len, R, WinFlags and not DT_MODIFYSTRING); // make sure the string cannot be modified
  {$ENDIF UNICODE}
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( 'DrawText' );{$ENDIF}
end;



{ TgemCapPanelBtn }


constructor TgemCapPanelBtn.Create(AOwner: TComponent);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'Create' );{$ENDIF}
  inherited Create(AOwner);

  DoubleBuffered := True;
  FCaptionFont := TFont.Create;
  FCaptionFont.Size := 10;
  FCaptionFont.Style := [fsBold];
  FCaptionFont.Color := clWhite;
  FCaptionFont.OnChange := DoCaptionFontChange;
  FCaptionPosition := dpBottom;
  FAutoDrag := True;
  FOffset := 8;
  FCaptionColor := clActiveCaption;
  FFlat := False;
  FOutlookLook := false;
  BorderStyle := bsSingle;

  FCaptionOffsetSmall := 2;
  FCaptionOffsetLarge := 3;
  FResizable := True;



  BevelOuter := bvNone;
  TabOrder := 0;
  CaptionPosition := dpBottom;

  fImage := TJvImage.Create(Self);

  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'Create' );{$ENDIF}
end;


destructor TgemCapPanelBtn.Destory;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'Destory' );{$ENDIF}
  FCaptionFont.free;
  Fimage.Free;
  inherited Destroy;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'Destory' );{$ENDIF}
end;


procedure TgemCapPanelBtn.CreateParams(var Params: TCreateParams);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'CreateParams' );{$ENDIF}
  inherited CreateParams(Params);
  // from Jedi Unit JcCaptionPanel
  if BorderStyle = bsSingle then
    with Params do
    begin
      if Resizable then
        Style := Style or WS_THICKFRAME
      else
        Style := Style or WS_DLGFRAME;
      ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
    end;



  Params.WindowClass.style := Params.WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'CreateParams' );{$ENDIF}
end;


procedure TgemCapPanelBtn.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited  CreateWindowHandle(Params);
  with fImage do begin
    OnMouseEnter  := ImageMouseEnterHandler;
    OnMouseLeave  := ImageMouseLeaveHandler;

    OnMouseMove   := ImageMouseMoveHandler;
    OnMouseUp     := ImageMouseUpHandler;
    OnMouseDown   := ImageMouseDownHandler;
    fImage.Parent := Self;
  end;
end;


//[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
//procedure TgemCapPanelBtn.CreateWnd;
//begin
//  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'CreateWnd' );{$ENDIF}
//  inherited CreateWnd;
//  showmessage('CreateWnd;');
//  SendMessage(Handle, BM_SETCHECK, Integer(fChecked), 0);
//  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'CreateWnd' );{$ENDIF}
//end;


procedure TgemCapPanelBtn.setImageAlign(const Value: TAlign);
begin
  fImage.Align := value;
end;


procedure TgemCapPanelBtn.SetImageHeight(const Value: Integer);
begin
  fImage.Height := Value;
end;


procedure TgemCapPanelBtn.SetImageWidth(const Value: Integer);
begin
  fImage.Width := Value;
end;


procedure TgemCapPanelBtn.Paint;
var
  Rotation: Integer;
  R: TRect;
  FlatOffset: Integer;
  AdjustedCaptionHeight: Integer;
begin
  if not Enabled then begin
    FState := bsDisabled;
  end
  else
    if FState = bsDisabled then
      if FDown and (GroupIndex <> 0) then
        FState := bsExclusive
      else
        FState := bsUp;

  R := ClientRect;

  if fDown then
    Canvas.Brush.Color := fButtonDownColor
  else
    if FMouseInControl then
      Canvas.Brush.Color := fButtonOverColor
    else
      Canvas.Brush.Color := fButtonUpColor;

  Canvas.FillRect(R);
  Canvas.Brush.Color := FCaptionColor;
  FBevel := FCaptionOffsetSmall;
  Rotation := 0;

  FlatOffset := 0;//Ord(FlatButtons);

  AdjustedCaptionHeight := GetEffectiveCaptionHeight;

  case FCaptionPosition of
    dpLeft:
      begin
        FCaptionRect := Rect(FBevel, FBevel, AdjustedCaptionHeight + FBevel, ClientHeight - FBevel);
        Rotation := 90;
      end;

    dpTop:
      FCaptionRect := Rect(FBevel, FBevel, ClientWidth - FBevel, AdjustedCaptionHeight + FBevel);

    dpRight:
      begin
        FCaptionRect := Rect(ClientWidth - AdjustedCaptionHeight - FBevel, FBevel, ClientWidth - FBevel, ClientHeight - FBevel);
        Rotation := -90;
      end;

    dpBottom: begin
      FCaptionRect := Rect(FBevel, ClientHeight - AdjustedCaptionHeight - FBevel, ClientWidth - FBevel, ClientHeight - FBevel);
    end;
  end; //case

  Canvas.FillRect(FCaptionRect);
  DrawRotatedText(Rotation);

end;


procedure TgemCapPanelBtn.DoCaptionFontChange(Sender: TObject);
begin
  Invalidate;
end;



begin
  case FCaptionPosition of
    dpLeft:
      R := Rect(GetEffectiveCaptionHeight + FCaptionOffsetSmall, 0, ClientWidth, ClientHeight);
    dpTop:
      R := Rect(0, GetEffectiveCaptionHeight + FCaptionOffsetSmall, ClientWidth, ClientHeight);
    dpRight:
      R := Rect(0, 0, ClientWidth - GetEffectiveCaptionHeight - FCaptionOffsetSmall, ClientHeight);
    dpBottom:
      R := Rect(0, 0, ClientWidth, ClientHeight - GetEffectiveCaptionHeight - FCaptionOffsetSmall);
  end;
  inherited AlignControls(AControl, R);
end;


function TgemCapPanelBtn.CanStartDrag: Boolean;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'CanStartDrag' );{$ENDIF}
  Result := Align = alNone;
  if Assigned(FOnStartAutoDrag) then
    FOnStartAutoDrag(Self, Result);
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'CanStartDrag' );{$ENDIF}
end;


procedure TgemCapPanelBtn.CMButtonPressed(var Message: TMessage);
var
  Sender: TgemCapPanelBtn;
begin
  if Message.WParam = WPARAM(FGroupIndex) then begin
    Sender := TgemCapPanelBtn(Message.LParam);
    if Sender <> Self then begin
      if Sender.Down and FDown then begin
        FDown := False;
        Color := fButtonUpColor;
        FState := bsUp;
//        if (Action is TCustomAction) then
//          TCustomAction(Action).Checked := False;
        Invalidate;
//      end
//      else  if fDown then begin
//        fgemNormalStateColor := Color;
//        Color := fSelectedColor;
      end;

      FAllowAllUp := Sender.AllowAllUp;
    end;
  end;
end;


procedure TgemCapPanelBtn.UpdateExclusive;
var
  Msg: TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg    := CM_BUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := LPARAM(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
  end;
end;


procedure TgemCapPanelBtn.theMouseEnter;
begin
  FMouseInControl := True;
  if fButtonDownColor <> Color then
    Color := fButtonOverColor;
  Invalidate;
  DoMouseEnter;
end;


procedure TgemCapPanelBtn.theMouseLeave;
begin
  FMouseInControl := False;
  if fButtonDownColor <> Color then
    Color := fButtonUpColor;
  Invalidate;
  DoMouseLeave;
end;



procedure TgemCapPanelBtn.theMouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  FMouseInControl := True;
  if (Button = mbLeft) and Enabled then begin
    if not FDown then
    begin
      FState := bsDown;
      Invalidate;
    end;
//    FDragging := True;
  end;
end;


procedure TgemCapPanelBtn.theMouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewState: TgemButtonState;
begin
  FMouseInControl := True;
//
end;


procedure TgemCapPanelBtn.theMouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  DoClick: Boolean;
begin
  if fDown then
    Exit;

  FMouseInControl := True;

  DoClick := True; //(X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
  if FGroupIndex = 0 then begin
    { Redraw face in-case mouse is captured }
    FState := bsUp;
    FMouseInControl := False;
    if DoClick and not (FState in [bsExclusive, bsDown]) then
      Invalidate;
  end
  else
    if DoClick then begin
      SetDown(not FDown);
      if FDown then
        Repaint;
    end
    else  begin
      if FDown then
        FState := bsExclusive;
      Repaint;
     end;
  if DoClick then
    Click;
end;


procedure TgemCapPanelBtn.ImageMouseEnterHandler(Sender: TObject);
begin
  theMouseEnter;
{ Place your event-handling code here. }
end;


procedure TgemCapPanelBtn.ImageMouseLeaveHandler(Sender: TObject);
begin
  theMouseLeave;
{ Place your event-handling code here. }
end;



procedure TgemCapPanelBtn.ImageMouseMoveHandler(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  theMouseMove(Shift, X, Y);
end;


procedure TgemCapPanelBtn.ImageMouseUpHandler(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  theMouseUp(Button, Shift, X, Y);
end;


procedure TgemCapPanelBtn.ImageMouseDownHandler(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  theMouseDown(Button, Shift, X, Y);
end;


procedure TgemCapPanelBtn.CMPanelMouseEnter(var Msg: TMessage);
begin
  inherited;
  theMouseEnter;
end;


procedure TgemCapPanelBtn.CMPanelMouseLeave(var Msg: TMessage);
begin
  theMouseLeave;
  inherited;
end;


procedure TgemCapPanelBtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  theMouseUp(Button, Shift, X, Y);
end;


procedure TgemCapPanelBtn.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
  theMouseMove(Shift, X, Y);
end;


procedure TgemCapPanelBtn.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  theMouseDown(Button, Shift, X, Y);
end;


procedure TgemCapPanelBtn.Click;
begin
  inherited Click;

end;


procedure TgemCapPanelBtn.DoLeaveDrag;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'DoLeaveDrag' );{$ENDIF}
  if Assigned(FEndDrag) then
    FEndDrag(Self);
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'DoLeaveDrag' );{$ENDIF}
end;


procedure TgemCapPanelBtn.DoMouseEnter;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'DoMouseEnter' );{$ENDIF}
  if fButtonDownColor <> color then  begin
    Color := fButtonOverColor;
  end;

  if Assigned(FOnPnlMouseEnter) then
    FOnPnlMouseEnter(Self);
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'DoMouseEnter' );{$ENDIF}
end;


procedure TgemCapPanelBtn.DoMouseLeave;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'DoMouseLeave' );{$ENDIF}
  if fButtonDownColor <> color then
    Color := fButtonUpColor;
//    Color := ForceUpColor;

  if Assigned(FOnPnlMouseLeave) then
    FOnPnlMouseLeave(Self);
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'DoMouseLeave' );{$ENDIF}
end;


procedure TgemCapPanelBtn.DrawRotatedText(Rotation: Integer);
var
  tH: Integer;
  tW: Integer;
  Lf: TLogFont;
  Tf: TFont;
  Flags: Integer;
  R: TRect;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'DrawRotatedText' );{$ENDIF}
  if FCaption = '' then
    Exit;
    SetBkMode(Canvas.Handle, TRANSPARENT);
    with Canvas do
    begin
      Tf := TFont.Create;
      try
        Tf.Assign(CaptionFont);
        GetObject(Tf.Handle, SizeOf(Lf), @Lf);
        Lf.lfEscapement := Rotation * 10;
        Lf.lfOrientation := Rotation * 10;
        Lf.lfOutPrecision := OUT_TT_PRECIS;
        Tf.Handle := CreateFontIndirect(Lf);
        Canvas.Font.Assign(Tf);
      finally
        Tf.Free;
      end;
      R := FCaptionRect;
      tH := ((R.Bottom - R.Top) - Canvas.TextHeight(FCaption)) div 2;
      tW := ((R.Right - R.Left) - Canvas.TextHeight(FCaption)) div 2;
      if FOutlookLook then
      begin
        Dec(tH);
        Dec(tW);
      end;
      case FCaptionPosition of
        dpLeft:
          begin
            R := Rect(R.Left, R.Bottom, R.Right, R.Top);
            OffsetRect(R, tW, -FOffset);
          end;
        dpTop, dpBottom:
          begin
            OffsetRect(R, FOffset, tH);
          end;
        dpRight:
          begin
            R := Rect(R.Right, R.Top, R.Left, R.Bottom);
            OffsetRect(R, -tW, FOffset);
          end;
      end;
      Flags := DT_NOPREFIX;
      if FCaptionPosition in [dpTop, dpBottom] then
        Flags := Flags or DT_VCENTER;
      if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
        Flags := Flags or DT_NOCLIP; { bug or feature? }
      DrawText(Canvas, Caption, -1, R, Flags);
    end;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'DrawRotatedText' );{$ENDIF}
end;


procedure TgemCapPanelBtn.SetImage_Picture(const Value: TPicture);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'SetImage_Picture' );{$ENDIF}
  fImage.Picture.Assign(Value);
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'SetImage_Picture' );{$ENDIF}
end;


procedure TgemCapPanelBtn.SetImage_AutoSize(const Value: Boolean);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'SetImage_AutoSize' );{$ENDIF}
//  fImage_AutoSize := value;
  fImage.AutoSize := Value;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'SetImage_AutoSize' );{$ENDIF}
end;


procedure TgemCapPanelBtn.SetImage_Center(const Value: Boolean);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'SetImage_Center' );{$ENDIF}
  fImage.Center := Value;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'SetImage_Center' );{$ENDIF}
end;


function TgemCapPanelBtn.GetEffectiveCaptionHeight: Integer;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'GetEffectiveCaptionHeight' );{$ENDIF}
  if FCaptionHeight = 0 then
    Result := GetSystemMetrics(SM_CYCAPTION)
  else
    Result := FCaptionHeight;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'GetEffectiveCaptionHeight' );{$ENDIF}
end;



function TgemCapPanelBtn.getImageAlign: TAlign;
begin
  Result := fImage.Align;
end;



function TgemCapPanelBtn.GetImage_AutoSize: Boolean;
begin
  result := fImage.AutoSize;
end;


function TgemCapPanelBtn.GetImage_Center: Boolean;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'GetImage_Center' );{$ENDIF}
  result := fImage.Center;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'GetImage_Center' );{$ENDIF}
end;


function TgemCapPanelBtn.GetImage_Height: Integer;
begin
  result := fImage.Height;
end;


function TgemCapPanelBtn.GetImage_Width: Integer;
begin
  result := fImage.Width;
end;


function TgemCapPanelBtn.GetImage_Picture: TPicture;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'GetImage_Picture' );{$ENDIF}
  result := fImage.Picture;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'GetImage_Picture' );{$ENDIF}
end;


function TgemCapPanelBtn.GetImage_Proportional: Boolean;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'GetImage_Proportional' );{$ENDIF}
  Result := fImage.Proportional;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'GetImage_Proportional' );{$ENDIF}
end;


function TgemCapPanelBtn.GetImage_Stretch: Boolean;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'GetImage_Stretch' );{$ENDIF}
  result := fImage.Stretch;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'GetImage_Stretch' );{$ENDIF}
end;


function TgemCapPanelBtn.GetImage_Visible: Boolean;
begin
  Result := fImage.Visible;
end;


procedure TgemCapPanelBtn.SetImage_Proportional(const Value: Boolean);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'SetImage_Proportional' );{$ENDIF}
  fImage.Proportional := (Value);
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'SetImage_Proportional' );{$ENDIF}
end;


procedure TgemCapPanelBtn.SetImage_Strech(const Value: Boolean);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'SetImage_Strech' );{$ENDIF}
  fImage.Stretch := (Value);
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'SetImage_Strech' );{$ENDIF}
end;


procedure TgemCapPanelBtn.SetImage_Visible(const Value: Boolean);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'SetImage_Visible' );{$ENDIF}
  fImage.Visible := (Value);
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'SetImage_Visible' );{$ENDIF}
end;


procedure TgemCapPanelBtn.SetButtonDownColor(const Value: TColor);
begin
  if FButtonDownColor <> Value then begin
    FButtonDownColor := Value;
    if fDown then begin
      Color := Value;
      Invalidate;
    end;
  end;
end;


procedure TgemCapPanelBtn.SetMouseOverColor(const Value: TColor);
begin
  if fButtonOverColor <> Value then begin
    fButtonOverColor := Value;
//    Invalidate;
  end;
end;


procedure TgemCapPanelBtn.SetButtonUpColor(const Value: tcolor);
begin
{  fButtonUpColor := clBtnFace;}
  if fButtonUpColor <> value then begin
    fButtonUpColor := Value;
    if not fDown then begin
      Color := Value;
      Invalidate;
    end;
  end;
end;


procedure TgemCapPanelBtn.Resize;
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'Resize' );{$ENDIF}
  inherited Resize;
  Repaint;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'Resize' );{$ENDIF}
end;


procedure TgemCapPanelBtn.SetResizable(const Value: Boolean);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'SetResizable' );{$ENDIF}
  if FResizable <> Value then
  begin
    FResizable := Value;
    RecreateWnd;
  end;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'SetResizable' );{$ENDIF}
end;


//procedure TgemCapPanelBtn.UpdateTracking;
//var
//  P: TPoint;
//begin
//  if FFlat then
//  begin
//    if Enabled then
//    begin
//      GetCursorPos(P);
//      FMouseInControl := not (FindDragTarget(P, True) = Self);
//      if FMouseInControl then
//        Perform(CM_MOUSELEAVE, 0, 0)
//      else
//        Perform(CM_MOUSEENTER, 0, 0);
//    end;
//  end;
//end;

procedure TgemCapPanelBtn.SetAllowAllUp(const Value: Boolean);
begin
  if FAllowAllUp <> Value then begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;



procedure TgemCapPanelBtn.SetCaption(const Value: string);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'SetCaption' );{$ENDIF}
  FCaption := Value;
  inherited Caption := '';
  Invalidate;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'SetCaption' );{$ENDIF}
end;


procedure TgemCapPanelBtn.SetCaptionColor(const Value: TColor);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'SetCaptionColor' );{$ENDIF}
  if FCaptionColor <> Value then
  begin
    FCaptionColor := Value;
    Invalidate;
  end;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'SetCaptionColor' );{$ENDIF}
end;


procedure TgemCapPanelBtn.SetCaptionFont(const Value: TFont);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'SetCaptionFont' );{$ENDIF}
  FCaptionFont.Assign(Value);
  Invalidate;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'SetCaptionFont' );{$ENDIF}
end;


procedure TgemCapPanelBtn.SetCaptionHeight(const Value: Integer);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'SetCaptionHeight' );{$ENDIF}
  if FCaptionHeight <> Value then
  begin
    FCaptionHeight := Value;
    Invalidate;
    ReAlign;
  end;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'SetCaptionHeight' );{$ENDIF}
end;


procedure TgemCapPanelBtn.SetCaptionPosition(
  const Value: TgemJvDrawPosition);
begin
  {$IFDEF USE_CODESITE}CodeSite.EnterMethod( Self, 'SetCaptionPosition' );{$ENDIF}
  if FCaptionPosition <> Value then
  begin
    FCaptionPosition := Value;
    RecreateWnd;
  end;
  {$IFDEF USE_CODESITE}CodeSite.ExitMethod( Self, 'SetCaptionPosition' );{$ENDIF}
end;


procedure TgemCapPanelBtn.SetDown(Value: Boolean);
begin
  if FGroupIndex = 0 then
    Value := False;
  if Value <> FDown then begin
    if FDown and (not FAllowAllUp) then
      Exit;

    FDown := Value;
    if Value then  begin
      if FState = bsUp then
        Invalidate;
      FState := bsExclusive;
      Color := fButtonDownColor;
    end
    else begin
      FState := bsUp;
      Color := fButtonUpColor;
      Repaint;
    end;
    if Value then
      UpdateExclusive;
  end;
end;


procedure TgemCapPanelBtn.SetFlat(const Value: Boolean);
begin
  if Value <> FFlat then begin
    FFlat := Value;
    Invalidate;
  end;
end;

procedure TgemCapPanelBtn.SetGroupIndex(const Value: Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

end.