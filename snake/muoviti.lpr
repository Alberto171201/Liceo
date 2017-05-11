program muoviti;

uses
  crt;

type coordinate = array[1..3] of integer; // ci servono tre numeri perchè il terzo rappresentera' Inc
type coordOggetti = array[1..3,1..2] of integer; // rappresenta una lista di tre punti, ovvero i posti dove si troveranno gli oggetti da raccogliere
type snake = array[1..505,1..2] of integer;

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

function avanzaGiorgio(XY: coordinate; giorgio: snake): snake;
	var i: integer;
	begin
		for i := 1 to 504 do
			if giorgio[i+1,1] = 0 then break;
		// dobbiamo cancellare la posizione dell'ultimo pezzo di coda su schermo SOLO NEL CASO non fosse uguale al penultimo
		if (giorgio[i,1] <> giorgio[i-1,1]) or (giorgio[i,2] <> giorgio[i-1,2]) then
		begin
			gotoxy(giorgio[i,1], giorgio[i,2]);
			write(' ');
		end;
		for i := i downto 2 do
		begin
			giorgio[i,1] := giorgio [i-1,1];
			giorgio[i,2] := giorgio [i-1,2];
		end;
		giorgio[1,1] := XY[1];
		giorgio[1,2] := XY[2];
	avanzaGiorgio := giorgio;
	end;

function allungaGiorgio(giorgio: snake): snake;
	var i: integer;
	begin
		for i := 1 to 504 do
			if giorgio[i+1,1] = 0 then
			begin
				giorgio[i+1,1] := giorgio[i,1];
				giorgio[i+1,2] := giorgio[i,2];
				break;
			end;
	allungaGiorgio := giorgio;
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
        	if (ch = ('a')) and (XY[3] <> 1) then
        	begin
          		XY[1] := XY[1] - 1;
          		XY[2] := XY[2];
          		XY[3] := 2;
        	end
        	else if (ch = ('d')) and (XY[3] <> 2) then
        	begin
          		XY[1] := XY[1] + 1;
          		XY[2] := XY[2];
        	  	XY[3] := 1;
        	end
	        else if (ch = ('w')) and (XY[3] <> 4) then
	        begin
	          	XY[1] := XY[1];
	          	XY[2] := XY[2] - 1;
	          	XY[3] := 3;
	        end
	        else if (ch = ('s')) and (XY[3] <> 3) then
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
				oggetti[i,1] := random(26) + 27;
				oggetti[i,2] := random(18) + 4;
				gotoxy(oggetti[i,1],oggetti[i,2]);
				write('*');
				break;
			end;
		end;
		generaOggetto := oggetti;
	end;

function generaBigOne(bigOne: coordinate): coordinate;
	begin
		randomize;
		if bigOne[1] = 0 then
		begin
			bigOne[1] := random(26) + 27;
			bigOne[2] := random(18) + 4;
			gotoxy(bigOne[1],bigOne[2]);
			write('@');
		end;
		generaBigOne := bigOne;
    end;

var
	alt, spawnCountdown, bigOneCountdown, tokenOggetto, i: integer;
	XY, bigOne : coordinate;
    oggetti : coordOggetti;
	giorgio: snake;
	gameOver: boolean;

begin
gameOver := false;
cursoroff; // Nasconde il cursore
alt := 200;
spawnCountdown := 20;
bigOneCountdown := 100;
tokenOggetto := 3;
XY[1] := 80 div 2;
XY[2] := 40 div 2;
XY[3] := 1;
for i := 1 to 3 do 				// inizializza l'array coordinate
	begin
		oggetti[i,1] := 0;
		oggetti[i,2] := 0;
	end;
bigOne[1] := 0;
bigOne[2] := 0;					// inizializza big
for i := 1 to 505 do
	begin 
		giorgio[i,1] := 0;
		giorgio[i,2] := 0;	
	end;						//inizializza giorgio	
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
    // controllo gameOver
    for i := 4 to 504 do
    begin
    	if giorgio[i,1] = 0 then break;
    	if (XY[1] = giorgio[i,1]) and (XY[2] = giorgio[i,2]) then gameOver := true;
    end;
    // controllo mangiata
    for i :=1 to 3 do
    	if (oggetti[i,1] = XY[1]) and (oggetti[i,2] = XY[2]) then 		// se ho mangiato
    	begin
    		tokenOggetto := tokenOggetto + 1;
    		oggetti[i,1] := 0;
    		giorgio := allungaGiorgio(giorgio);
    		break;
    	end;
	if (bigOne[1] = XY[1]) and (bigOne[2] = XY[2]) then 
	begin
		bigOne[1] := 0; 			// controllo e "liberazione" del bigOne
		giorgio := allungaGiorgio(giorgio);
	end;
    // sposta segnalino
    gotoxy(XY[1], XY[2]);
    Write('o');
    giorgio := avanzaGiorgio(XY, giorgio);
    delay(alt);
    //
    //	pausa di riflessione
    //
    spawnCountdown := spawnCountdown - 1;
    bigOneCountdown := bigOneCountdown - 1;
    // generazione oggetto
    if (spawnCountdown < 0) and (tokenOggetto > 0) then
    begin
    	oggetti := generaOggetto(oggetti);
    	tokenOggetto := tokenOggetto - 1;
        spawnCountdown := 20;
    end;
    if (bigOneCountdown < 0) then
    begin
    	bigOne := generaBigOne(bigOne);
    	bigOneCountdown := 100;
    end;
    if (XY[1] = 25) OR (XY[1] = 25+29) OR (XY[2] = 3) OR (XY[2] = 3+19) then gameOver := true;
until (gameOver);
end.
