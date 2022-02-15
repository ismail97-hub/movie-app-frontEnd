

import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movieapp/app/app_prefs.dart';
import 'package:movieapp/app/constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";
const String bearer = "Bearer ";


class DioFactory {
  AppPreferences _appPreferences;

  DioFactory(this._appPreferences);

  Future<Dio> getDio() async{
    Dio dio = Dio();
    int _timeOut = 60 * 1000; // 1 min
    String token = await _appPreferences.getToken();
    bool isUserLoggedIn = await _appPreferences.isUserLoggedIn();

    Map<String,String> headers = HashMap();

    if (isUserLoggedIn) {
      headers = {
        AUTHORIZATION: bearer+token,
        CONTENT_TYPE: APPLICATION_JSON,
        ACCEPT: APPLICATION_JSON,
      };
    }else{
      headers = {
        CONTENT_TYPE: APPLICATION_JSON,
        ACCEPT: APPLICATION_JSON,
      }; 
    }

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      headers: headers,
    );

    if(!kReleaseMode){
      dio.interceptors.add(PrettyDioLogger(responseBody: false,requestHeader: true,responseHeader:false,requestBody: false));
    }


    return dio;
  }
}