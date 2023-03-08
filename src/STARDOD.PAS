{*** Created by Nicholas Alexander Hill of Connivex 1999 ***}
{*** 9th October 1999 ***}

program StarDodge;

uses CRT, Graph;

const
  MaxLevels=20;
  StartLevel=1;

var
  A, B, DIR, NUMTURNS: Integer;
  C: Char;
  X, Y, SPEED, SCORE, LEVEL, LIFE, STARSIZE: Integer;
  GAPWALLCOLOUR, NUMEXITS: Integer;
  StrFilled: Boolean;
  STARS, GAPSIZE: Integer;
  ASPEED, ASTARS, AGAPSIZE, ASTARSIZE: Array[1..100] of integer;

procedure Init;
var
  Gd, Gm : Integer;
begin
  Gd:=Detect; InitGraph(Gd, Gm, '');
  if GraphResult <> grOk then Halt(1);
  Randomize;
  {* 'Clear screen'}
  SetFillStyle(1,0); Bar(0,0,640,480);
  {* Variables setup}
  Score:=0; Life:=1000;
  ASpeed[1]:=800; AStars[1]:=0; AGapSize[1]:=50; AStarSize[1]:=0;
  ASpeed[2]:=850; AStars[2]:=15; AGapSize[2]:=100; AStarSize[2]:=7;
  ASpeed[3]:=900; AStars[3]:=45; AGapSize[3]:=150; AStarSize[3]:=4;
  ASpeed[4]:=930; AStars[4]:=90; AGapSize[4]:=150; AStarSize[4]:=3;
  ASpeed[5]:=950; AStars[5]:=10; AGapSize[5]:=50; AStarSize[5]:=8;
  ASpeed[6]:=970; AStars[6]:=4; AGapSize[6]:=30; AStarSize[6]:=30;
  ASpeed[7]:=930; AStars[7]:=100; AGapSize[7]:=200; AStarSize[7]:=4;
  ASpeed[8]:=930; AStars[8]:=150; AGapSize[8]:=190; AStarSize[8]:=3;
  ASpeed[9]:=930; AStars[9]:=250; AGapSize[9]:=100; AStarSize[9]:=2;
  ASpeed[10]:=980; AStars[10]:=10; AGapSize[10]:=50; AStarSize[10]:=18;
  ASpeed[11]:=900; AStars[11]:=10; AGapSize[11]:=12; AStarSize[11]:=8;
  ASpeed[12]:=800; AStars[12]:=450; AGapSize[12]:=100; AStarSize[12]:=2;
  ASpeed[13]:=985; AStars[13]:=0; AGapSize[13]:=26; AStarSize[13]:=0;
  ASpeed[14]:=970; AStars[14]:=100; AGapSize[14]:=40; AStarSize[14]:=2;
  ASpeed[15]:=970; AStars[15]:=200; AGapSize[15]:=38; AStarSize[15]:=2;
  ASpeed[16]:=860; AStars[16]:=700; AGapSize[16]:=20; AStarSize[16]:=1;
  ASpeed[17]:=930; AStars[17]:=280; AGapSize[17]:=36; AStarSize[17]:=3;
  ASpeed[18]:=910; AStars[18]:=360; AGapSize[18]:=34; AStarSize[18]:=3;
  ASpeed[19]:=880; AStars[19]:=440; AGapSize[19]:=12; AStarSize[19]:=5;
  ASpeed[20]:=880; AStars[20]:=2000; AGapSize[20]:=10; AStarSize[20]:=1;
end;

procedure SetLevel(NUM: Integer);
begin
  Level:=NUM;
  X:=0; Y:=0; NumTurns:=0;
  While Y<80 do Y:=random(360);
  Speed:=ASpeed[Level];
  Stars:=AStars[Level];
  Gapsize:=AGapSize[Level];
  StarSize:=AStarSize[Level];
  if Level>0 then NumExits:=5;
  if Level>0 then GapWallColour:=14;
  if Level>2 then NumExits:=3;
  if Level>5 then StrFilled:=TRUE else StrFilled:=FALSE;
  if Level>7 then NumExits:=2;
  if Level>8 then GapWallColour:=13;
  if Level>14 then NumExits:=1;
  if Level>17 then GapWallColour:=15;
end;

procedure InfoScreen;
var I2S: String;
begin
  {* 'Clear screen' for the remaining area - leave scores from EndLevel}
  SetFillStyle(1,0);
  Bar(250,30,640,130); Bar(90,260,370,315); Bar(10,418,320,428);
  {* Display information'}
  SetColor(9); SetTextStyle(SansSerifFont, HorizDir, 8);
  MoveTo(260,20); OutText('StarDodge');
  SetTextStyle(DefaultFont, VertDir, 1);
  SetColor(11);
  MoveTo(10,0); OutText('(c) 1999-2015 Nicholas Hill. Contact nick@nick-hill.com');
  SetColor(15);
  SetTextStyle(SansSerifFont, HorizDir, 4);
  Str(Life div 10,I2S); OutTextXY(100,250,'Life left: '+I2S+'%');
  Str(Score,I2S); OutTextXY(100,280,'Total score: '+I2S);
  SetTextStyle(DefaultFont, HorizDir, 1);
  OutTextXY(20,420,'Press a key to try the next level...');
  repeat until keypressed;
end;

procedure DrawStatus;
var I2S: String;
begin
  SetColor(15);
  SetFillStyle(1,9); Bar(0,441,640,480);
  SetFillStyle(1,0); Bar(9,449,211,471);
  if Life>0 then SetFillStyle(1,4);
  if Life>200 then SetFillStyle(1,14);
  if Life>700 then SetFillStyle(1,1);
  Bar(10,450,((Life*2) div 10)+10,470);
  Str(LEVEL,I2S); OutTextXY(220,450,'Level: '+I2S);
  Str(SCORE,I2S); OutTextXY(220,460,'Score: '+I2S);
  Str(SPEED,I2S); OutTextXY(220,470,'Speed: '+I2S);
end;

procedure DrawField(NUM: Integer);
var AX, AY, a1, b1: Integer;
begin
  {* Clear playfield area - not status!}
  SetFillStyle(1,0); Bar(0,0,640,440);
  {* Make all stars}
  for A:=1 to Stars do begin
    AX:=0; AY:=0; SetColor(14);
    While AX<50 do AX:=Random(630);
    AY:=Random(440);
    SetFillStyle(1,14);
    if StrFilled=true then PieSlice(AX,AY,0,360,StarSize);
    if StrFilled=false then Circle(AX,AY,StarSize);
  end;
  {* Gaps and lines}
  SetColor(GapWallColour);
  for A:=640 downto 634 do begin
    MoveTo(A,0); LineTo(A,440);
  end;
  SetColor(0);
  for A1:=1 to NumExits do begin
    AY:=480; While AY>(480-GapSize) do AY:=Random(480);
    for B1:=640 downto 634 do begin
      MoveTo(B1,AY); LineTo(B1,AY+GapSize);
    end;
  end;
  SetColor(15);
  MoveTo(0,0); LineTo(640,0);
  MoveTo(0,440); LineTo(640,440);
  {* Make status area}
  DrawStatus;
end;

procedure EndGame;
var
  F1: Text;
  NAM: String;
  SC: Integer;
begin
  RESTORECRTMODE;
  WriteLn('Total score was ',SCORE,'. You reached level ',LEVEL);
  Write('High score: ');
  Assign(F1,'.\HIGHSCR.DAT');
  Reset(F1);
  readLN(F1,NAM);
  readLN(F1,SC);
  writeln(NAM,' scored ',SC);
  close(F1);
  if Score>SC then begin
    Writeln('You have a new high score!');
    writeln('Enter your name:');
    readln(NAM);
    Assign(F1,'.\HIGHSCR.DAT');
    ReWrite(F1);
    WriteLN(F1,NAM);
    WriteLN(F1,SCORE);
    close(F1);
  end;
  Writeln('Press [ENTER] to exit');
  Readln;
  Halt(1);
end;

procedure DecLife(AMOUNT: Integer);
begin
  if AMOUNT>=0 then begin
    Sound(200); Delay(1000); NoSound;
  end else begin
    Sound(100); Delay(1000); Sound(200); Delay(800);
    Sound(300); Delay(600); NoSound;
  end;
  Life:=Life-AMOUNT;
  if Life<0 then EndGame;
  if Life>1000 then Life:=1000;
  DrawStatus;
end;

procedure CheckCollision;
begin
  if GetPixel(X,Y)=14 then DecLife(17);
  if GetPixel(X,Y)=13 then DecLife(36);
  if GetPixel(X,Y)=15 then begin
    DecLife(150);
    SetLevel(Level);
    DrawField(Level);
  end;
end;

procedure Play;
begin
  while X<641 do begin
    X:=X+1; C:='#';
    {DEBUG:}
    if KeyPressed=true then C:=ReadKey;
    if (C=' ') and (DIR=0) then DIR:=3;
    if (C=' ') and (DIR<>3) then DIR:=4;
    if DIR>2 then NumTurns:=NumTurns+1;
    if DIR=3 then DIR:=1;
    if DIR=4 then DIR:=0;
    if DIR=1 then Y:=Y-1 else Y:=Y+1;
    CheckCollision;
    PutPixel(X,Y,15);
    Delay(1000-Speed);
  end;
end;

procedure EndLevel;
var I2S: String;
begin
  sound(1000); Delay(100); Sound(1500); Delay(30); Sound(2000); Delay(100);
  NoSound; Delay(2000);
  {* Fade out...etc}
  SetColor(15);
  {* Level passing bonus}
  Str(5+(LEVEL),I2S); OutTextXY(20,20,'Level passing bonus: '+I2S);
  sound(400); Delay(90); Sound(500); Delay(120); NoSound; Delay(1200);
  Score:=Score+5+(LEVEL);
  {* Number of turns bonus}
  Str(NumTurns,I2S); OutTextXY(20,30,'Number of turns: '+I2S);
  sound(400); Delay(90); Sound(500); Delay(120); NoSound; Delay(1200);
  if NumTurns<20 then begin
    Str(20-NumTurns,I2S); OutTextXY(20,40,'Turns bonus: '+I2S);
    sound(400); Delay(90); Sound(500); Delay(120); NoSound; Delay(1200);
    Score:=Score+20-NumTurns;
  end;
  {* Life left bonus}
  for A:=Life downto 0 do begin
    SetFillStyle(1,0); Bar(9+((A*2) div 10),449,211,471);
    if A>0 then SetFillStyle(1,4);
    if A>200 then SetFillStyle(1,14);
    if A>700 then SetFillStyle(1,1);
    Bar(10,450,((A*2) div 10)+10,470);
    Sound(A*10); Delay(10); NoSound;
  end;
  Str(Life div 50,I2S); OutTextXY(20,60,'Life left bonus: '+I2S);
  sound(400); Delay(90); Sound(500); Delay(120); NoSound; Delay(1000);
  if Life>0 then Score:=Score+(Life div 50);
  {* Add to life bonus}
  if Level=5 then DecLife(-100);
  if Level=10 then DecLife(-200);
  if Level=15 then DecLife(-140);
  if Level=19 then DecLife(-80);
  Delay(8000);
end;

begin
  Init;
  for B:=StartLevel to MaxLevels do begin
    Level:=B;
    SetLevel(Level);
    InfoScreen;
    DrawField(Level);
    Play;
    EndLevel;
  end;
  EndGame;
end.