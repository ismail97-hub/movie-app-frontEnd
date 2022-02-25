
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
part 'model.g.dart';

const String DATABASE_PATH = 'myMovieDataBase.db';
const String DATABASE_NAME = 'MyMovieDataBase';

const List<SqfEntityField> movieFields = [
    SqfEntityField('movieId', DbType.integer),
    SqfEntityField('title', DbType.text),
    SqfEntityField('image', DbType.text),    
    SqfEntityField('rating', DbType.real, defaultValue: 0),
    SqfEntityField('quality', DbType.text),
    SqfEntityField('year', DbType.text),
    SqfEntityField('language', DbType.text),
    SqfEntityField('country', DbType.text),
    SqfEntityField('story', DbType.text),
    SqfEntityField('source', DbType.text),
    SqfEntityField('datepublication', DbType.text),
];

const List<SqfEntityField> typeFields = [
    SqfEntityField('identity', DbType.integer),
    SqfEntityField('label', DbType.text),
];

const tableHistory = SqfEntityTable(
  tableName: 'History',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  fields: movieFields
);

const tableFavorite = SqfEntityTable(
  tableName: 'Favorite',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  fields: movieFields);

const tableCategory = SqfEntityTable(
  tableName: 'localCategory',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  fields: typeFields);

const tableGenre = SqfEntityTable(
  tableName: 'localGenre',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.integer_auto_incremental,
  useSoftDeleting: false,
  fields: typeFields);

const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    modelName: DATABASE_NAME, 
    databaseName: DATABASE_PATH,
    sequences: [seqIdentity],
    databaseTables: [tableHistory,tableFavorite,tableCategory,tableGenre]
);



