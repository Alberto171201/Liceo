program muoviti;

uses
  crt;

type coordinate = array[1..3] of integer; // ci servono tre numeri perchè il terzo rappresentera' Inc
type coordOggetti = array[1..3,1..2] of integer; // rappresenta una lista di tre punti, ovvero i posti dove si troveranno gli oggetti da raccogliere

 procedure disegnaBordo;
 	var
 		a, b, i: integer;
 	begin
		a := 25;
	b := 3;
	gotoxy(a, b);
	Write('+----------------------------+');
	for i := 1 to 18 do 
	begin
	    gotoxy(a, b + i);
	    Write('|                            |');
    end;	
    gotoxy(a, b + 19);
    Write('+----------------------------+');
	end;

function muoviti(XY:coordinate):coordinate;
	var ch : char;
	begin
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
          		XY[1] := XY[1] - 1;
          		XY[2] := XY[2];
          		XY[3] := 2;
        	end
        	else if ch = ('d') then
        	begin
          		XY[1] := XY[1] + 1;
          		XY[2] := XY[2];
        	  	XY[3] := 1;
        	end
	        else if ch = ('w') then
	        begin
	          	XY[1] := XY[1];
	          	XY[2] := XY[2] - 1;
	          	XY[3] := 3;
	        end
	        else if ch = ('s') then
	        begin
	          	XY[1] := XY[1];
	          	XY[2] := XY[2] + 1;
	          	XY[3] := 4;
	        end;
    	end;
    end
    else
    begin
		if XY[3] = 1 then
		begin
			XY[1] := XY[1] + 1;
			XY[2] := XY[2];
		end
		else if XY[3] = 2 then
		begin
			XY[1] := XY[1] - 1;
			XY[2] := XY[2];
		end
		else if XY[3] = 3 then
		begin
			XY[1] := XY[1];
			XY[2] := XY[2] - 1;
		end
		else if XY[3] = 4 then
		begin
			XY[1] := XY[1];
			XY[2] := XY[2] + 1;
		end;
    end;
    muoviti := XY;
	end;

function generaOggetto(oggetti : coordOggetti) : coordOggetti;
	var i : integer;
	begin
		randomize;
		for i := 1 to 3 do
		begin
			if oggetti[i,1] = 0 then
			begin
				oggetti[i,1] := random(27) + 26;
				oggetti[i,2] := random(19) + 3;
				gotoxy(oggetti[i,1],oggetti[i,2]);
				write('*');
				break;
			end;
		end;
		generaOggetto := oggetti;
	end;


var
	alt, spawnCountdown, tokenOggetto: integer;
	XY : coordinate;
        oggetti : coordOggetti;
	old_xp, old_yp, i:integer;
	old_ch: char;
	ch: char;

begin
cursoroff; // Nasconde il cursore
alt := 200;
spawnCountdown := 20;
tokenOggetto := 3;
XY[1] := 80 div 2;
XY[2] := 40 div 2;
XY[3] := 1;
TextColor(green);
TextBackground(black);
clrscr;
disegnaBordo();  // Disegna il bordo
oggetti := generaOggetto(oggetti);
tokenOggetto := tokenOggetto - 1;
gotoxy(1, 1);
writeln('Usa a-s-d-w per muoverti');
repeat
    XY := muoviti(XY);
    // controllo mangiata
    for i :=1 to 3 do
    begin
    	if (oggetti[i,1] = XY[1]) and (oggetti[i,2] = XY[2]) then // se ho mangiato
    	begin
    		tokenOggetto := tokenOggetto + 1;
    		oggetti[i,1] := 0;
    		break;
    	end;
    end;
    // sposta segnalino
    gotoxy(XY[1], XY[2]);
    Write('o');
    delay(alt);
    //
    //	pausa di riflessione
    //
    spawnCountdown := spawnCountdown - 1;
    // generazione oggetto
    if (spawnCountdown < 0) and (tokenOggetto > 0) then
    begin
    	oggetti := generaOggetto(oggetti);
    	tokenOggetto := tokenOggetto - 1;
        spawnCountdown := 20;
    end;
    gotoxy(XY[1], XY[2]);
    Write(' ');
until ((ch = ('e')) OR (XY[1] = 25) OR (XY[1] = 25+29) OR (XY[2] = 3) OR (XY[2] = 3+19));
end.
