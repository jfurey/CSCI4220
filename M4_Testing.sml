datatype types = INT | BOOL | ERROR;

datatype denotable_value =  Boolean of bool 
                          | Integer of int;

type loc   = int
type env   = (string * types * loc) list
type store = (loc * denotable_value) list

val initialModel = ( []:env, 0:loc, []:store )

exception runtime_error;

fun error msg = ( print msg; raise runtime_error );

fun accessEnv ( id1, (env,_) ) = 
    let
        val msg = "Error: accessEnv " ^ id1 ^ " not found.";

        fun aux [] = error msg  (* If id is not found, return error *)
          | aux ((id,t,loc)::env) = 
				if id1 = id then (t,loc)  (* If id is found, return type and loc *)
				else aux env;  (* Keep searching *)
    in
        aux env
    end;

fun accessStore ( loc1, (_, store) ) =
	let
		val msg = "Error: accessStore " ^ Int.toString loc1 ^ " not found.";
		
		fun aux [] = error msg  (* If loc is not found, return error *)
		  | aux ((loc,v)::store) =
				if loc1 = loc then v  (* If loc is found, return value *)
				else aux store;  (* Keep searching *)
	in
		aux store
	end;

fun updateEnv (id1, t1, loc1, (env, loc, store)) =
    let
        fun updateBinding [] = [(id1, t1, loc1)]  (* If id is not found, add new binding *)
          | updateBinding ((id, t, loc) :: rest) =
                if id = id1 then (id1, t1, loc1) :: rest  (* Update existing binding *)
                else (id, t, loc) :: updateBinding rest  (* Keep searching *)
                
        (* Create updated env *)
        val newEnv = updateBinding env
    in
        (* Return updated model *)
        (newEnv, loc, store)
    end;
	
fun updateStore ( loc, v, (env,


fun getLoc


fun getType


(* Recommended but not required *)
fun printEnv


(* Recommended but not required *)
fun printStore


(* Recommended but not required *)
fun printModel