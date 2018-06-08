# bs-dynamodb

This module provides a functorial API to npm's [dynamodb](https://www.npmjs.com/package/dynamodb) module.
It makes it easy to define and manipulate dynamodb models in a ORM-oriented fashion. It depends on
[bs-callback](https://github.com/lidcore/bs-callback) for asynchronous computations but can also use `Promise`
via `BsCallback.{to,from}_promise`.

## Installation

```
yarn add https://github.com/lidcore/bs-dynamodb.git
```

## Usage

Add `bs-dynamodb` to the `bs-dependencies` of `bsconfig.json`.

## Example

`medium.mli`:
```
type params = <
  key: string
> Js.t

type attributes = <
  id:    string;
  key:   string;
  state: string [@bs.set]
> Js.t

type model  = <attrs:attributes> Js.t

val create_table : unit BsCallback.t
val create       : params -> model BsCallback.t
val get          : string -> model option BsCallback.t
val set_state    : model -> string -> model BsCallback.t
val update       : attributes -> model option BsCallback.t
```

`medium.ml`:
```
open BsCallback

let uuid : unit -> string [@bs] = [%bs.raw{|function() {
  require("uuid/v1")();
}|}]

module Definition = struct
  open Dynamodb

  type params = <
    key: string
  > Js.t

  type attributes = <
    id:    string;
    key:   string;
    state: string [@bs.set]
  > Js.t

  let name       = "Media"
  let hashKey    = "id"
  let timestamps = true
  let specs =
    let specs = [
      Specs.string "id";
      Specs.string "key"
    ] in
    List.fold_left (fun spec str ->
      str spec) (Specs.make ()) specs
  let table_name = "media"
end

module Model = Dynamodb.Make(Definition)

include Model

external set_id : params -> string -> unit = "id" [@@bs.set]

let create params =
  set_id params (uuid () [@bs]);
  create params

external make_error : string -> exn = "Error" [@@bs.new]

let set_state model state =
  let attrs = model##attrs in
  attrs##state #= state;
  update attrs >> fun model ->
    match model with
      | Some model -> BsCallback.return model
      | None -> BsCallback.fail (make_error "Inconsistent state update (should not happen)")
```
