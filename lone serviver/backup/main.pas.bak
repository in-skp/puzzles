unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TLifeType = 0..1;
  // LifeType has three types
  //  0 : Person is dead
  //  1 : Person is alive

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
    Peoples : Cardinal;
    LoneSurviver: array of TLifeType;
    procedure InitSurvivers;
    function IsLoneSurviver : boolean;
    function FindLoneSurviver : integer;
    function FindNextSurviver(Knife: integer): integer;
    procedure KillSurviver(ASurviver : integer);
    function FindFirstSurviver : integer;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    Peoples := StrToIntDef(Edit1.Text,100);
  Except on E : Exception do
    Peoples:= 100;
  end;
  InitSurvivers;
  Memo1.Lines.Add('Surviver is : ' +IntToStr(FindLoneSurviver+1));
end;

procedure TForm1.InitSurvivers;
var
  i : integer;
begin
  SetLength(LoneSurviver,Peoples);
  for i:=Low(LoneSurviver) to High(LoneSurviver) do
  begin
    LoneSurviver[i] := 1;
  end;
end;

function TForm1.IsLoneSurviver: boolean;
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

function TForm1.FindLoneSurviver: integer;
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

function TForm1.FindNextSurviver(Knife: integer): integer;
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
  if Result = -1 then
    Result := FindFirstSurviver;
end;

procedure TForm1.KillSurviver(ASurviver: integer);
begin
  LoneSurviver[ASurviver] := 0;
end;

function TForm1.FindFirstSurviver: integer;
var
  i : integer;
begin
  //
  Result := -1;
  for i:=Low(LoneSurviver) to High(LoneSurviver) do
  begin
    if LoneSurviver[i] = 1 then
    begin
      Result := i;
      Break;
    end;
  end;
end;

end.

