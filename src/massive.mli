type 'a promise = 'a BsAsyncMonad.Promise.t

type t

type table

val create : ?user:string -> ?password:string -> ?ssl:bool -> ?poolSize:int ->
              host:string -> port:int -> string -> t promise

val reload : t -> t promise

val listTables    : t -> string array
val listViews     : t -> string array
val listFunctions : t -> string array

val table : t -> string -> table option

module Queries : sig
  val find      : ?options:'a Js.t -> table -> 'b Js.t -> 'c Js.t array promise
  val findOne   : ?options:'a Js.t -> table -> 'b Js.t -> 'c Js.t promise
  val findOneId : ?options:'a Js.t -> table -> float -> 'b Js.t promise
  val count     : table -> 'a Js.t -> float promise
  val where     : table -> string -> float array -> 'a Js.t array promise
  val whereObj  : table -> string -> 'a Js.t -> 'b Js.t array promise
end
