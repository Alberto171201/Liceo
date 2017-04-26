program muoviti;

uses
  crt;

  procedure disegnaBordo;
  var
    a, b: integer;
  begin
    a := 25;
    b := 3;
    gotoxy(a, b);
    Write('+----------------------------+');
    gotoxy(a, b + 1);
    Write('|                            |');
    gotoxy(a, b + 2);
    Write('|                            |');
    gotoxy(a, b + 3);
    Write('|                            |');
    gotoxy(a, b + 4);
    Write('|                            |');
    gotoxy(a, b + 5);
    Write('|                            |');
    gotoxy(a, b + 6);
    Write('|                            |');
    gotoxy(a, b + 7);
    Write('|                            |');
    gotoxy(a, b + 8);
    Write('|                            |');
    gotoxy(a, b + 9);
    Write('|                            |');
    gotoxy(a, b + 10);
    Write('|                            |');
    gotoxy(a, b + 11);
    Write('|                            |');
    gotoxy(a, b + 12);
    Write('|                            |');
    gotoxy(a, b + 13);
    Write('|                            |');
    gotoxy(a, b + 14);
    Write('|                            |');
    gotoxy(a, b + 15);
    Write('|                            |');
    gotoxy(a, b + 16);
    Write('|                            |');
    gotoxy(a, b + 17);
    Write('|                            |');
    gotoxy(a, b + 18);
    Write('|                            |');
    gotoxy(a, b + 19);
    Write('+----------------------------+');
  end;

var
  alt: integer;
  xp, yp, old_xp, old_yp, Inc: integer;
  old_ch: char;
  ch: char;

begin
  cursoroff; // Nasconde il cursore
  alt := 200;
  xp := 80 div 2;
  yp := 40 div 2;
  TextColor(green);
  TextBackground(black);
  Inc := 1;
  clrscr;
  disegnaBordo();  // Disegna il bordo
  gotoxy(1, 1);
  writeln('Usa a-s-d-w per muoverti');
  repeat

    if keypressed then
    begin
      ch := readkey;
      if (ch = #0) then
         begin
              ch:= readkey;
              if (ch = #72) then ch := 'w';
              if (ch = #80) then ch := 's';
              if (ch = #75) then ch := 'a';
              if (ch = #77) then ch := 'd';
         end;
      if (ch = ('a')) or (ch = ('d')) or (ch = ('s')) or (ch = ('w')) then
      begin
        if ch = ('a') then
        begin
          xp := xp - 1;
          yp := yp;
          Inc := 2;
        end
        else if ch = ('d') then
        begin
          xp := xp + 1;
          yp := yp;
          Inc := 1;
        end
        else if ch = ('w') then
        begin
          xp := xp;
          yp := yp - 1;
          Inc := 3;
        end
        else if ch = ('s') then
        begin
          xp := xp;
          yp := yp + 1;
          Inc := 4;
        end;
      end;
    end
    else
    begin
      if Inc = 1 then
      begin
        xp := xp + 1;
        yp := yp;
      end
      else if Inc = 2 then
      begin
        xp := xp - 1;
        yp := yp;
      end
      else if Inc = 3 then
      begin
        xp := xp;
        yp := yp - 1;
      end
      else if Inc = 4 then
      begin
        xp := xp;
        yp := yp + 1;
      end;

    end;
    gotoxy(xp, yp);
    Write('o');
    delay(alt);
    gotoxy(xp, yp);
    Write(' ');
  until ((ch = ('e')) OR (xp = 25) OR (xp = 25+29) OR (yp = 3) OR (yp = 3+19));

end.
