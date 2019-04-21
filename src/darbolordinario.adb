package body darbolordinario is
  
   -- procedimiento para vaciar el arbol
   procedure avacio(t: out arbol) is
      r: pnode renames t.raiz;
   begin
      r := null;
   end avacio;

   -- comprueba si el arbol esta vacio
   function esta_vacio (t: out arbol) return Boolean is
      r: pnode renames t.raiz;
   begin
      return r = null;
   end darbolordinario;

   -- crea un hijo
   procedure anadir_hijo (t: in arbol; x: in elem) is
      r: pnode renames t.raiz;
      n: pnode;
   begin
      n:= new node;
      n.c:= x;
      n.padre:= r;
      if e_primer_hijo(t) then
         r.primer_hijo := n;
      else
         null;
      end if;
   exception
      when constraint_error => raise mal_uso;
      when storage_error => espacio_desbordado;
   end anadir_hijo;

   -- comprueba si un nodo tiene hijos
   function e_primer_hijo (t: in arbol) return Boolean is
      r: pnode renames t.raiz;
   begin
      if r.primer_hijo = null then
         return FALSE;
      end if;
      return TRUE;
   exception
      when constraint_error => mal_uso;
   end e_primer_hijo;

   -- el arbol ct pasa a ser el del primer hijo de t
   procedure primer_hijo (t: in out arbol; ct: out arbol) is
      r: pnode renames t.raiz;
   begin
      ct.raiz := r.primer_hijo;
   exception
      when constraint_error => mal_uso;
   end primer_hijo;

   -- crea un arbol con un nodo
   procedure atom (t: in arbol; x: in elem) is
      r: pnode renames t.raiz;
   begin
      r := new node;
      r.c := x;
   exception
      when storage_error => espacio_desbordado;
   end atom;
   
   -- devuelve el elemento de la raiz
   function raiz (t: in arbol) return elem is
      r: pnode renames t.raiz;
   begin
      return r.c;
   exception
      when constraint_error => mal_uso;
   end raiz;
   
   -- comrpueba si un nodo tiene hermano
   function e_hermano (t: in arbol) return Boolean is
      r: pnode renames t.raiz;
   begin
      if r.hermano = null then
         return FALSE;
      end if;
      return TRUE;
   exception
      when constraint_error => mal_uso;
   end e_hermano;
   
   -- el arbol st pasa a ser el del hermano de t
   procedure hermano (t: in arbol; st: out arbol) is
      r: pnode renames t.raiz;
   begin
      st.raiz := r.hermano;
   exception
      when constraint_error => mal_uso;
   end hermano;
   
   -- comprueba si un nodo tiene padre
   function e_padre (t: in arbol) return Boolean is
      r: pnode renames t.raiz;
   begin
      if r.padre = null then
         return FALSE;
      end if;
      return TRUE;
   exception
      when constraint_error => mal_uso;
   end e_padre;
   
   -- el arbol pt pasa a ser el del padre de t
   procedure padre (t: in arbol; pt: out arbol) is
      r: pnode renames t.raiz;
   begin
      pt.raiz := r.padre;
   exception
      when constraint_error => mal_uso;
   end padre;
      -- recorre el arbol en amplitud y lo pone en q
   procedure amplitud (t: in arbol; q: out dcolalem.cola) is 
      r: pnode renames t.raiz;
   begin
      
   end amplitud;
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
end darbolordinario;
