type t

type table

val create : ?user:string -> ?password:string -> ?ssl:bool -> ?poolSize:int ->
              host:string -> port:int -> string -> t Js.Promise.t

val reload : t -> t Js.Promise.t

val listTables    : t -> string array
val listViews     : t -> string array
val listFunctions : t -> string array

val table : t -> string -> table option

module Queries : sig
  val find      : ?options:'a Js.t -> table -> 'b Js.t -> 'c Js.t array Js.Promise.t
  val findOne   : ?options:'a Js.t -> table -> 'b Js.t -> 'c Js.t Js.Promise.t
  val findOneId : ?options:'a Js.t -> table -> float -> 'b Js.t Js.Promise.t
  val count     : table -> 'a Js.t -> float Js.Promise.t
  val where     : table -> string -> float array -> 'a Js.t array Js.Promise.t
  val whereObj  : table -> string -> 'a Js.t -> 'b Js.t array Js.Promise.t
end
