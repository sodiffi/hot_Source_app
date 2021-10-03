import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hot_source_app/data_models.dart';

class Request {
  static const String host = '104.199.252.191';
  Map<String, String> headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
  late Map responseBody;
  httpFunction(dynamic response) async {
    responseBody = await json.decode(utf8.decode(response.bodyBytes));

    print('statusCode: ${response.statusCode}');
    print('body: ${utf8.decode(response.bodyBytes)}');
  }

  httpGet(Map<String, String> data, String _url) async {
    Uri _uri = Uri.http(host, _url, data);
    dynamic response = await http.get(_uri, headers: headers);
    await httpFunction(response);
  }

  late Data _data;
  getData() => _data;

  dataGet(Map<String, String> data) async {
    String _url = '/temp';
    await httpGet(data, _url);
    if (responseBody != null) {
      if (responseBody['success']) {
        _data = Data.fromJson(responseBody['D']);
      } else {
        print('error');
      }
    }
  }
}
