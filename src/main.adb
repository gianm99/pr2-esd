with dtauler;
use dtauler;
with darbolordinario;
with dcola;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;


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

   s: String(1..15); -- String del estado inicial
   e: estat; -- estado inicial
   e_aux: estat; -- estado actual
   p: integer; -- ultimo jugador
   p_aux: integer; -- jugador actual
   l: integer;
   i: integer;
   j: integer;
   k: integer;
   c: tcella;
   a: parbol;
   a_aux: parbol;
   qu: cola;
begin
   Put_Line("Introduce el estado inicial del tablero:");
   Get_Line(s,l); -- lee el estado inicial
--     while l/=9 loop
--        Put_Line("Introduce el estado inicial del tablero:");
--        Get_Line(s,l); -- lee el estado inicial
--     end loop;
   Put_Line("Indica el último jugador (1 o 2):");
   Ada.Integer_Text_IO.Get(p);
   empty(e.t);
   -- último jugador
   e.jugador:= p;
   i:=1;
   j:=1;
   k:=1;
   -- rellenar el tablero
   while i<=3 loop
      c.fila:=i;
      while j<=3 loop
         c.columna:=j;
         mouJugador(e.t,getJugador(s(k..k)),c);
         j:=j+1;
         k:=k+1;
      end loop;
      i:=i+1;
   end loop;
   -- creación del árbol
   if isTaulerComplet(e.t) then
      if isJocGuanyat(e.t,1) then
         print(e);
         Put_Line("Partida ganada (1):");
         if isLinia(e.t,1) then
            Put_Line("línea");
         end if;
         if isDiagonal(e.t,1) then
            Put_Line("diagonal");
         end if;
      elsif isJocGuanyat(e.t,2) then
         print(e);
         Put_Line("Partida ganada (2):");
         if isLinia(e.t,2) then
            Put_Line("línea");
         end if;
         if isDiagonal(e.t,2) then
            Put_Line("diagonal");
         end if;
      else
         Put_Line("Empate");
      end if;
   else
      a:= new arbol;
      atom(a.all,e);
      cvacia(qu);
      poner(qu,a);
      while not esta_vacia(qu) loop
         a_aux:= coger_primero(qu);
         borrar_primero(qu);
         e_aux:= raiz(a_aux.all);
         if e_aux.jugador=1 then
            p_aux:=2;
         else
            p_aux:=1;
         end if;
         -- visita el elemento
         i:=1;
         j:=1;
         while i<=3 loop
            c.fila:=i;
            while j<=3 loop
               c.columna:=j;
               if isCasellaBuida(e_aux.t,c) then
                  mouJugador(e_aux.t,p_aux,c);
                  anadir_hijo(a_aux.all,e_aux);
                  e_aux:=raiz(a_aux.all); -- recupera el valor anterior
               end if;
               j:=j+1;
            end loop;
            i:=i+1;
         end loop;
         -- poner elementos en la cola
         if e_primer_hijo(a_aux.all) then
            primer_hijo(a_aux.all,a_aux.all);
            poner(qu,a_aux);
            while e_hermano(a_aux.all) loop
               hermano(a_aux.all,a_aux.all);
               poner(qu,a_aux);
            end loop;
         end if;
      end loop;
   end if;
   amplitud(a.all);
end Main;
