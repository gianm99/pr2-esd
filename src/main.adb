with dtauler;
use dtauler;
with darbolordinario;
with dcola;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

procedure Main is

   type estat is record
      t: tauler;
      jugador: integer;
   end record;

   procedure print (s: in estat) is
   begin
      Put_Line("Jugador: " & s.jugador'Image);
      print(s.t);
   end print;

   package darboltauler is new darbolordinario(estat, print);
   use darboltauler;

   type parbol is access arbol;
   package dcolaarbol is new dcola(parbol);
   use dcolaarbol;

   s_inicial: String(1..9); -- String del estado inicial
   s: estat; -- estado inicial
   p: integer; -- ultimo jugador
   l: integer;
   i: integer;
begin
   Put_Line("Introduce el estado inicial del tablero:");
   get_line(s_inicial,l); -- lee el estado inicial
   while not l=9 loop
      Put_Line("Introduce el estado inicial del tablero:");
      get_line(s_inicial,l); -- lee el estado inicial
   end loop;
   Put_Line("Indica el último jugador (1 o 2):");
   Ada.Integer_Text_IO.Get(p);
   empty(s.tauler);
   s.jugador:= p;
   i:=1;
   while i<=9 loop

   end loop;

end Main;
