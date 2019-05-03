with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with dtauler; use dtauler;
with darbolordinario;
with dcola;

procedure Main is
   type estat is record
      t: tauler;
      jugador: integer;
   end record;
   valor_incorrecto: exception;

   procedure print (s: in estat) is
   begin
      Put_Line("Jugador: " & s.jugador'Image);
      if isJocGuanyat(s.t,s.jugador) then
         Put_Line("Victoria del jugador " & s.jugador'Image);
      end if;
      print(s.t);
   end print;

   procedure estado_inicial(estado: out estat) is
      linea: String(1..9);
      longitud: natural;
      turno: integer;
      celda: tcella;
      indice: integer;
      i: integer;
      j: integer;
   begin
      Put("Introduce el estado inicial del tablero: ");
      Get_Line(linea,longitud);
      while longitud /= 9 loop
         Put("Error. Introduce el estado inicial del tablero: ");
         Get_Line(linea,longitud);
      end loop;
      -- ultimo jugador
      Put("Introduce el ultimo jugador (1 o 2): ");
         Get(turno);
      while turno /= 1 and turno/=2 loop
         Put("Error. Introduce el ultimo jugador (1 o 2): ");
         Get(turno);
      end loop;
      estado.jugador:= turno;
      empty(estado.t);
      i:=1;
      indice:=1;
      while i <= getDimensio(estado.t) loop
         j:=1;
         while j <= getDimensio(estado.t) loop
            celda.fila:=i;
            celda.columna:=j;
            case linea(indice) is
               when '-' => mouJugador(estado.t,0,celda);
               when 'X' => mouJugador(estado.t,1,celda);
               when 'O' => mouJugador(estado.t,2,celda);
               when others => raise valor_incorrecto;
            end case;
            j:=j+1;
            indice:=indice+1;
         end loop;
         i:=i+1;
      end loop;
   exception
      when valor_incorrecto =>
      Put_Line("El valor introducido para el tablero es incorrecto");
   end estado_inicial;

   package darboltauler is new darbolordinario(estat, print);
   use darboltauler;

   type parbol is access arbol;
   package dcolaarbol is new dcola(parbol);
   use dcolaarbol;

   procedure crear_arbol(p_arbol: in out parbol; estado: in estat) is
      qu: cola; -- cola de punteros a arboles
      p_arbol_1: parbol; -- puntero auxiliar
      p_arbol_2: parbol; -- puntero auxiliar
      estado_aux: estat; -- estado auxiliar
      turno: integer; -- turno actual
      celda: tcella;
      i: integer;
      j: integer;
   begin
      p_arbol:= new arbol;
      atom(p_arbol.all,estado);
      cvacia(qu);
      -- recorrido en amplitud para crear el arbol
      poner(qu,p_arbol);
      while not esta_vacia(qu) loop
         p_arbol:=coger_primero(qu);
         borrar_primero(qu);
         -- coge el estado de la raiz
         estado_aux:= raiz(p_arbol.all);
         -- comprueba si la partida se ha acabado
         if not isJocGuanyat(estado_aux.t,estado_aux.jugador) then
            -- cambio de jugador
            if estado_aux.jugador=1 then
               turno:=2;
            else
               turno:=1;
            end if;
            -- crea los estados derivados del actual
            i:=1;
            while i<=getDimensio(estado_aux.t) loop
               celda.fila:=i;
               j:=1;
               while j<=getDimensio(estado_aux.t) loop
                  celda.columna:=j;
                  if isCasellaBuida(estado_aux.t,celda) then
                     mouJugador(estado_aux.t,turno,celda);
                     estado_aux.jugador:=turno;
                     anadir_hijo(p_arbol.all,estado_aux);
                     estado_aux:= raiz(p_arbol.all); -- recupera el estado anterior
                  end if;
                  j:=j+1;
               end loop;
               i:=i+1;
            end loop;
            -- poner los elementos en la cola
            if e_primer_hijo(p_arbol.all) then
               p_arbol_1 := new arbol;
               primer_hijo(p_arbol.all,p_arbol_1.all);
               poner(qu,p_arbol_1);
               while e_hermano(p_arbol_1.all) loop
                  p_arbol_2 := new arbol;
                  hermano(p_arbol_1.all,p_arbol_2.all);
                  poner(qu,p_arbol_2);
                  p_arbol_1 := p_arbol_2;
               end loop;
            end if;
         end if;
      end loop;
      -- vuelve a la raiz
      while e_padre(p_arbol.all) loop
         padre(p_arbol.all, p_arbol.all);
      end loop;
   exception
      when dcolaarbol.mal_uso =>
         Put_Line("Mal uso de la cola");
      when dcolaarbol.espacio_desbordado=>
         Put_Line("Espacio desbordado por la cola");
      when darboltauler.mal_uso =>
         Put_Line("Mal uso del arbol");
      when darboltauler.espacio_desbordado=>
         Put_Line("Espacio desbordado por el arbol");
   end crear_arbol;

   estado: estat; -- estado de juego inicial
   p_arbol: parbol; -- puntero a arbol
begin
   estado_inicial(estado);
   crear_arbol(p_arbol,estado);
   amplitud(p_arbol.all);
end Main;
