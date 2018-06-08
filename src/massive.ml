type connection = {
  host:     string;
  port:     int;
  database: string;
  user:     string [@bs.optional];
  password: string [@bs.optional];
  ssl:      bool   [@bs.optional];
  poolSize: int    [@bs.optional]
} [@@bs.deriving abstract]

type t

type table

external create : connection -> t Js.Promise.t = "massive" [@@bs.module]

let create ?user ?password ?ssl ?poolSize ~host ~port database =
  create (connection ?user ?password ?ssl ?poolSize ~host ~port ~database ())

external reload : t -> t Js.Promise.t = "" [@@bs.send]

external listTables : t -> string array = "" [@@bs.send]
external listViews : t -> string array = "" [@@bs.send]
external listFunctions : t -> string array = "" [@@bs.send]

let table : t -> string -> table Js.Nullable.t = [%bs.raw fun db name ->
  "db[name]"
]

let table db name =
  Js.toOption (table db name)

let empty = Js.Dict.empty ()

module Queries = struct
  external find : table -> 'a Js.t -> 'b Js.t -> 'c Js.t array Js.Promise.t = "" [@@bs.send]
  let find ?options table criteria =
    let options =
      match options with
        | Some options -> options
        | None -> Obj.magic empty
    in
    find table criteria options 

  external findOne : table -> 'a Js.t -> 'b Js.t -> 'c Js.t Js.Promise.t = "" [@@bs.send]
  let findOne ?options table criteria =
    let options =
      match options with
        | Some options -> options
        | None -> Obj.magic empty
    in
    findOne table criteria options

  external findOneId : table -> float -> 'a Js.t -> 'b Js.t Js.Promise.t = "findOne" [@@bs.send]
  let findOneId ?options table id =
    let options =
      match options with
        | Some options -> options
        | None -> Obj.magic empty
    in
    findOneId table id options

  external count : table -> 'a Js.t -> float Js.Promise.t = "" [@@bs.send]

  external where    : table -> string -> float array -> 'a Js.t array Js.Promise.t = "" [@@bs.send]
  external whereObj : table -> string -> 'a Js.t -> 'b Js.t array Js.Promise.t = "where" [@@bs.send]
end
