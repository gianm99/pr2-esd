with dtauler;
use dtauler;
with darbolordinario;
with dcola;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Characters.Handling;
use Ada.Characters.Handling;

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

   linea: String(1..20); -- String del estado inicial
   indice: Natural; -- longitud del string
   e: estat; -- estado inicial
   e_aux: estat; -- estado actual
   p: integer; -- ultimo jugador
   p_aux: integer; -- jugador actual
   i: integer;
   j: integer;
   k: integer;
   c: tcella;
   a: parbol;
   a_aux: parbol;
   qu: cola;
begin
   Put("Introduce el estado inicial del tablero: ");
   Get_Line(linea,indice); -- lee el estado inicial del tablero
   while indice /= 9 loop
      Put("Introduce el estado inicial del tablero: ");
      Get_Line(linea,indice); -- lee el estado inicial del tablero
   end loop;

   -- último jugador
   Put("Introduce el ultimo jugador (1 o 2): ");
   Get(p);
   e.jugador:= p;
   empty(e.t);
   i:=1;
   k:=1;
   while i <= getDimensio(e.t) loop
      j:=1;
      while j <= getDimensio(e.t) loop
         c.fila:=i;
         c.columna:=j;
         case linea(k) is
            when '-' => mouJugador(e.t,0,c);
            when 'X' => mouJugador(e.t,1,c);
            when 'O' => mouJugador(e.t,2,c);
            when others => raise Constraint_Error; -- cambiar esto
         end case;
         j:=j+1;
         k:=k+1;
      end loop;
      i:=i+1;
   end loop;
   -- creación del árbol
   a:= new arbol;
   atom(a.all,e);
   cvacia(qu);
   poner(qu,a);
   while not esta_vacia(qu) loop
      a:=coger_primero(qu);
      borrar_primero(qu);
      e_aux:= raiz(a.all); -- coge el estado de la raíz
      if e_aux.jugador=1 then -- siguiente turno
         p_aux:=2;
      else
         p_aux:=1;
      end if;
      -- crea los nuevos estados
      i:=1;
      j:=1;
      while i<=3 loop
         c.fila:=i;
         j:=1;
         while j<=3 loop
            c.columna:=j;
            if isCasellaBuida(e_aux.t,c) then
               mouJugador(e_aux.t,p_aux,c);
               e_aux.jugador:=p_aux;
               anadir_hijo(a.all,e_aux);
               e_aux:= raiz(a.all); -- recupera el estado anterior
            end if;
            j:=j+1;
         end loop;
         i:=i+1;
      end loop;
      -- poner elementos en la cola
      if e_primer_hijo(a.all) then
         primer_hijo(a.all,a.all);
         poner(qu,a);
         while e_hermano(a.all) loop
            hermano(a.all,a.all);
            poner(qu,a);
         end loop;
      end if;
   end loop;
   -- Posicionarse en el arbol raiz
   while e_padre(a.all) loop
      padre(a.all, a.all);
   end loop;
   -- Recorrido en amplitud
   amplitud(a.all);
end Main;
