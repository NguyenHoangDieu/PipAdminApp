import 'dart:convert';

import 'package:pipadmin/models/supplier.dart';
import 'package:pipadmin/utils/common.dart';

import '../utils/api.dart';

class CarProvider{
  static Future<List<Supplier>> fetchListSupplier() async {
    List<Supplier> result = [];
    final host = await Services.getApiLink();
    var requestToken = await Services.getToken();
    final requestUrl = '$host/api/supplier';
    final response = await Services.doGet(requestUrl, requestToken);
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      List<dynamic> listItem = body['data']['supplier_list'];
      for (var item in listItem) {
        result.add(Supplier.fromJson(item));
      }
    }
    return result;
  }

  static Future<Supplier> fetchListSupplierById(String supplierId) async {
    Supplier result = Supplier();
    final host = await Services.getApiLink();
    var requestToken = await Services.getToken();
    final requestUrl = '$host/api/supplier/detail/$supplierId';
    final response = await Services.doGet(requestUrl, requestToken);
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      Map<String, dynamic> item = body['data']['supplier'];
      result.id = item['_id'];
      result.carNumber = item['carNumber'];
      result.phone= item['phone'];
      result.carName = item['car_name'];
      result.carType = item['car_type'];
      result.carNumber = item['car_number'];
      result.createdAt = item['created_at'];
      result.avatar = item['avartar'];
    }
    return result;
  }

  static Future<List<CarType>> statisticalCarType() async {
    List<CarType> result = [];
    final host = await Services.getApiLink();
    var requestToken = await Services.getToken();
    final requestUrl = '$host/api/car-type/statistical';
    final response = await Services.doGet(requestUrl, requestToken);
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      List<dynamic> listItem = body['data']['result_list'];
      for (var item in listItem) {
        result.add(CarType.fromJson(item));
      }
    }
    return result;
  }

}