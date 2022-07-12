
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as Http;
import 'dart:convert';

import 'package:flutter/foundation.dart';

class NetWorkClient{

  var url;
  dynamic d;
  List list = [];
  late HttpClient _httpClient;
  late HttpClientRequest _httpRequest;
  late HttpClientResponse _httpResponse;

  Future<List> getHttp(String api) async {
    url = Uri.parse(api);
    Http.Response response;
    try{
      response = await Http.get(url);
      list = json.decode(response.body);
      if (kDebugMode) {
        print('Http Response status: ${response.statusCode}');
        //print('Http Response body: ${response.body}');
        print('Http Response body jsons: ${json.decode(response.body)}');
        print('Http Response length: ${list.length}');
        print('Http Response read:' + await Http.read(Uri.parse(url)));
      }
    }catch(e){
      if (kDebugMode) {
        print("Data Http $e");
      }
    }
    return list;
  }

  Future<String> getHttpClient(String api, String? headerName, String? headerValue) async {
    //创建一个HttpClient
    _httpClient = HttpClient();
    //打开Http连接
    _httpRequest = await _httpClient.getUrl(Uri.parse(api));
    //使用iPhone的UA
    if(headerName!.isNotEmpty && headerValue!.isNotEmpty) {
      _httpRequest.headers.add(
        headerName,
        headerValue,
      );
    }
    //等待连接服务器（会将请求信息发送给服务器）
    _httpResponse = await _httpRequest.close();
    //读取响应内容
    d = _httpResponse.transform(utf8.decoder).join();
    //输出响应头
    if (kDebugMode) {
      print('HttpResponse -> $d');
    }
    //关闭client后，通过该client发起的所有请求都会中止。
    _httpClient.close();
    return d;
  }

  Future<List> getDio(String url) async {
    Response response;
    var dio = Dio();
    if (kDebugMode) {
      try {
        response = await dio.get(url);
        list = response.data;
        print('Dio response -> ${response.data} length -> ${list.length}');
      } on DioError catch (e) {
        // The request was made and the server responded with a status code
        // that falls out of the range of 2xx and is also not 304.
        if (e.response != null) {
          print('Dio Error ${e.response?.data.toString()}');
          print('Dio Error ${e.response?.headers.toString()}');
          print('Dio Error ${e.response?.requestOptions.toString()}');
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          print('Dio Error ${e.response?.requestOptions.toString()}');
          print('Dio Error ' + e.message);
        }
      }
    }
    return list;
  }

}