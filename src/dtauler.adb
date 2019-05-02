with Ada.Text_IO;
use Ada.Text_IO;

package body dtauler is

   procedure empty (t: out tauler) is
   begin
      t := (others => (others => peces'First));
   end empty;

   procedure print (t: in tauler) is
      p: peces;
      s: String(1..3);
   begin
      for i in t'Range(1) loop
         for j in t'Range(2) loop
            p := t(i, j);
            s := p'Image;
            put(s(2) & " ");
         end loop;
         new_line;
      end loop;
      New_Line;
   end print;

   procedure mouJugador(t: in out tauler; numJugador: in integer; cella: in tcella) is
   begin
      t(cella.fila, cella.columna) := peces'Val(numJugador);
   end mouJugador;

   function getDimensio(t: in tauler) return integer is
   begin
      return dimensio;
   end getDimensio;

   function getNumJugadors(t: in tauler) return integer is
   begin
      return numJugadors;
   end getNumJugadors;

   function isCasellaBuida(t: in tauler; cella: in tcella) return Boolean is
   begin
      return t(cella.fila, cella.columna) = peces'First;
   end isCasellaBuida;

   procedure clone (t1: in tauler; t2: out tauler) is
   begin
      t2 := t1;
   end clone;

   function getJugador(p: in string) return integer is
   begin
      return peces'Pos(peces'Value("'"& p &"'"));
   end getJugador;

   -- Funcio que retorna si el tauler esta complet:
   -- totes les caselles ocupades per peces 'X' o 'O'
   function isTaulerComplet(t: in tauler) return Boolean is
      fila: integer;
      columna: integer;
   begin
      fila := 1;
      columna := 1;
      while fila<dimensio loop
         while columna<dimensio loop
            if t(fila,columna) = peces'First then
               return false;
            end if;
            columna := columna + 1;
         end loop;
         fila := fila + 1;
      end loop;
      return true;
   end isTaulerComplet;

   -- Funcio que retorna si el tauler conte
   -- una disposicio de peces pel jugador 'jugador'
   -- que formin una linia (horitzontal o vertical)
   function isLinia (t: in tauler; jugador: in integer) return Boolean is
      -- En esta funcion basta con utilizar un booleano "linia" en lugar de linea_horizontal/Vertical
      linea_horizontal: Boolean;
      linea_vertical: Boolean;
      fila: integer;
      columna:integer;
   begin
      -- linea horizontal
      fila:=1;
      while fila<=dimensio loop
         columna:=1;
         linea_horizontal:=true;
         while columna<=dimensio loop
            if peces'Pos(t(fila,columna))/=jugador then
               linea_horizontal:=false;
            end if;
            columna:=columna+1;
         end loop;
         exit when linea_horizontal=true;
         fila:=fila+1;
      end loop;
      -- comprobar si hay linia horizontal
      if linea_horizontal then
         return true;
      end if;
      -- linea vertical
      columna:=1;
      while columna<=dimensio loop
         fila:=1;
         linea_vertical:=true;
         while fila<=dimensio loop
            if peces'Pos(t(fila,columna))/=jugador then
               linea_vertical:=false;
            end if;
            fila:=fila+1;
         end loop;
         exit when linea_vertical=true;
         columna:=columna+1;
      end loop;
      return linea_vertical;
   end isLinia;

   -- Funcio que retorna si el tauler conte
   -- una disposicio de peces pel jugador 'jugador'
   -- que formin una diagonal (normal o inversa)
   function isDiagonal (t: in tauler; jugador: in integer) return Boolean is
      fila: integer;
      columna: integer;
      diagonal_normal: boolean;
      diagonal_inversa: boolean;
   begin
      diagonal_normal:=true;
      diagonal_inversa:=true;
      fila:=1;
      columna:=1;
      while fila<=dimensio and columna<=dimensio and diagonal_normal loop
         if  peces'Pos(t(fila,columna)) /= jugador then
            diagonal_normal := false;
         end if;
         fila:=fila+1;
         columna:=columna+1;
      end loop;
      if diagonal_normal then
         return true;
      end if;
      fila:=dimensio;
      columna:=1;
      while fila>=1 and columna<=dimensio and diagonal_inversa loop
         if peces'Pos(t(fila,columna)) /= jugador then
            diagonal_inversa := false;
         end if;
         fila:=fila-1;
         columna:=columna+1;
      end loop;
      return diagonal_inversa;
   end isDiagonal;

   function isJocGuanyat (t: in tauler; jugador: in integer) return boolean is
   begin
      if isDiagonal(t, jugador) or isLinia(t, jugador) then
         return true;
      else
         return false;
      end if;
   end isJocGuanyat;

end dtauler;
