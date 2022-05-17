//Dynamic headers

import 'package:localstorage/localstorage.dart';
import 'package:dio/dio.dart';
import '../../LocalStoreKey.dart';

Dio createDioClientAuthentication(LocalStorage storage) {
  Dio  dio= new Dio();
   var token = storage.getItem(LocalStoreKey.tokenUser);
   dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
   if(token==null) token="";
   dio.options.headers["Authorization"] ="bearer "+token;   
   return dio;
}

Dio createDioClientNoAuthentication(LocalStorage storage) {
  Dio  dio= new Dio();
   dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
   return dio;
}

