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
      New_Line;
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

   -- Funció que retorna si el tauler està  complet:
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

   -- Funció que retorna si el tauler conté
   -- una disposició de peces pel jugador 'jugador'
   -- que formin una línia (horitzontal o vertical)
   function isLinia (t: in tauler; jugador: in integer) return Boolean is
      -- Funció per completar
   begin
      return true;
   end isLinia;

   -- Funció que retorna si el tauler conté
   -- una disposició de peces pel jugador 'jugador'
   -- que formin una diagonal (normal o inversa)
   function isDiagonal (t: in tauler; jugador: in integer) return Boolean is
      fila: integer;
      columna: integer;
      diagonal: boolean;
   begin
      fila:=1;
      columna:=1;
      diagonal:=true;
      while fila<=dimensio and columna<=dimensio and diagonal loop
         if not peces'Pos(t(fila,columna)) = jugador then
            diagonal := false;
         end if;
         fila:=fila+1;
         columna:=columna+1;
      end loop;
      if diagonal then
         return diagonal;
      end if;
      fila:=dimensio;
      columna:=1;
      diagonal:=true;
      while fila>0 and columna<=dimensio and diagonal loop
         if not peces'Pos(t(fila,columna)) = jugador then
            diagonal = false;
         end if;
         fila:=fila-1;
         columna:=columna+1;
      end loop;
      return diagonal;
   end isDiagonal;

   function isJocGuanyat (t: in tauler; jugador: in integer) return boolean is
      -- Funció per completar
   begin
      return true;
   end isJocGuanyat;

end dtauler;
