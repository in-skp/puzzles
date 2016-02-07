program loneserviver;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp
  { you can add units after this };

type
  TLifeType = 0..1;
  // LifeType has three types
  //  0 : Person is dead
  //  1 : Person is alive

  { TLoneServiver }

  { TLoneSurviver }

  TLoneSurviver = class(TCustomApplication)
  protected
    Peoples : Cardinal;
    LoneSurviver: array of TLifeType;
    procedure DoRun; override;
    procedure InitSurvivers;
    function IsLoneSurviver : boolean;
    function FindLoneSurviver : integer;
    function FindNextSurviver(Knife: integer): integer;
    procedure KillSurviver(ASurviver : integer);
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TLoneServiver }

procedure TLoneSurviver.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h','help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h','help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }
  Peoples := 100;
  // input number of peoples
  //readln(Peoples);
  SetLength(LoneSurviver,Peoples);
  InitSurvivers;
  WriteLn('Surviver : '+IntToStr(FindLoneSurviver));
  // stop program loop
  Terminate;
end;

procedure TLoneSurviver.InitSurvivers;
var
  i : integer;
begin
  for i:=Low(LoneSurviver) to High(LoneSurviver) do
  begin
    LoneSurviver[i] := 1;
  end;
end;

function TLoneSurviver.IsLoneSurviver: boolean;
var
  i : Cardinal;
  Alone : Cardinal;
begin
  Result := False;
  Alone := 0;
  for i:=Low(LoneSurviver) to High(LoneSurviver) do
  begin
    Alone := Alone + LoneSurviver[i];
  end;
  Result := (Alone = 1);
end;

function TLoneSurviver.FindLoneSurviver: integer;
var
  knife : Cardinal;
  NextSurviver : Cardinal;
begin
  knife:= 0;
  while not IsLoneSurviver do
  begin
    NextSurviver:= FindNextSurviver(knife);
    KillSurviver(NextSurviver);
    NextSurviver:= FindNextSurviver(knife);
    knife := NextSurviver;
  end;
  Result := knife;
end;

function TLoneSurviver.FindNextSurviver(Knife: integer): integer;
var
  i : integer;
begin
  //
  Result := -1;
  for i:=Knife+1 to High(LoneSurviver) do
  begin
    if LoneSurviver[i] = 1 then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TLoneSurviver.KillSurviver(ASurviver: integer);
begin
  LoneSurviver[ASurviver] := 0;
end;

constructor TLoneSurviver.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TLoneSurviver.Destroy;
begin
  inherited Destroy;
end;

procedure TLoneSurviver.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ',ExeName,' -h');
end;

var
  Application: TLoneSurviver;
begin
  Application:=TLoneSurviver.Create(nil);
  Application.Title:='LoneSurviver';
  Application.Run;
  Application.Free;
end.

