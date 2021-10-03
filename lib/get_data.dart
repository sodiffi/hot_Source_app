import 'package:hot_source_app/request.dart';
import 'package:hot_source_app/data_models.dart';

class GetData {
  String city;

  late Map<String, String> data;
  late Data _response;

  _request() async {
    Request request = Request();
    await request.dataGet(data);
    _response = await request.getData();
  }

  GetData({required this.city}) {
    data = {'city': city};
  }

  Future<Data> getData() async {
    await _request();
    return this._response;
  }
}
