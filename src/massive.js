// Generated by BUCKLESCRIPT VERSION 3.1.5, PLEASE EDIT WITH CARE
'use strict';

var Massive = require("massive");
var Js_primitive = require("bs-platform/lib/js/js_primitive.js");

function create(user, password, ssl, poolSize, host, port, database) {
  var tmp = {
    host: host,
    port: port,
    database: database
  };
  if (user) {
    tmp.user = user[0];
  }
  if (password) {
    tmp.password = password[0];
  }
  if (ssl) {
    tmp.ssl = ssl[0];
  }
  if (poolSize) {
    tmp.poolSize = poolSize[0];
  }
  return Massive(tmp);
}

var table = function (db,name){return db[name];};

function table$1(db, name) {
  return Js_primitive.null_undefined_to_opt(table(db, name));
}

function find(options, table, criteria) {
  var options$1 = options ? options[0] : { };
  return table.find(criteria, options$1);
}

function findOne(options, table, criteria) {
  var options$1 = options ? options[0] : { };
  return table.findOne(criteria, options$1);
}

function findOneId(options, table, id) {
  var options$1 = options ? options[0] : { };
  return table.findOne(id, options$1);
}

function save(options, table, data) {
  var options$1 = options ? options[0] : { };
  return table.save(data, options$1);
}

function insert(options, table, data) {
  var options$1 = options ? options[0] : { };
  return table.insert(data, options$1);
}

function update(options, table, criteria, changes) {
  var options$1 = options ? options[0] : { };
  return table.update(criteria, changes, options$1);
}

function updateId(options, table, id, changes) {
  var options$1 = options ? options[0] : { };
  return table.update(id, changes, options$1);
}

function updateString(options, table, id, changes) {
  var options$1 = options ? options[0] : { };
  return table.update(id, changes, options$1);
}

function reload(prim) {
  return prim.reload();
}

function listTables(prim) {
  return prim.listTables();
}

function listViews(prim) {
  return prim.listViews();
}

function listFunctions(prim) {
  return prim.listFunctions();
}

function count(prim, prim$1) {
  return prim.count(prim$1);
}

function where(prim, prim$1, prim$2) {
  return prim.where(prim$1, prim$2);
}

function whereObj(prim, prim$1, prim$2) {
  return prim.where(prim$1, prim$2);
}

exports.create = create;
exports.reload = reload;
exports.listTables = listTables;
exports.listViews = listViews;
exports.listFunctions = listFunctions;
exports.table = table$1;
exports.find = find;
exports.findOne = findOne;
exports.findOneId = findOneId;
exports.count = count;
exports.where = where;
exports.whereObj = whereObj;
exports.save = save;
exports.insert = insert;
exports.update = update;
exports.updateId = updateId;
exports.updateString = updateString;
/* massive Not a pure module */
