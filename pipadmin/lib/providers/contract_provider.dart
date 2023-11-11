import 'dart:convert';

import 'package:pipadmin/models/contract.dart';
import 'package:pipadmin/utils/common.dart';

import '../utils/api.dart';

class ContractProvider{
  static Future<List<Contract>> fetchListContractByMonth(int month) async {
    List<Contract> result = [];
    final host = await Services.getApiLink();
    var requestToken = await Services.getToken();
    final requestUrl = '$host/api/contract/date?year=2023&month=$month';
    final response = await Services.doGet(requestUrl, requestToken);
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      List<dynamic> listItem = body['data']['contract_list_by_date'];
      for (var item in listItem) {
        result.add(Contract.fromJson(item));
      }
    }
    return result;
  }

  static Future<List<ContractStats>> fetchListContractByYear(int year) async {
    List<ContractStats> result = [];
    final host = await Services.getApiLink();
    var requestToken = await Services.getToken();
    final requestUrl = '$host/api/contract/year?year=$year';
    final response = await Services.doGet(requestUrl, requestToken);
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      List<dynamic> listItem = body['data']['total_contract_by_year'];
      for (var item in listItem) {
        result.add(ContractStats.fromJson(item));
      }
    }
    return result;
  }

  static Future<List<Contract>> fetchListContractBySupplierId(String supplierId) async {
    List<Contract> result = [];
    final host = await Services.getApiLink();
    var requestToken = await Services.getToken();
    final requestUrl = '$host/api/contract/supplier/$supplierId';
    final response = await Services.doGet(requestUrl, requestToken);
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      List<dynamic> listItem = body['data']['contract_supplier_list'];
      for (var item in listItem) {
        result.add(Contract.fromJson(item));
      }
    }
    return result;
  }

  static Future<List<Contract>> fetchAllListContract() async {
    List<Contract> result = [];
    final host = await Services.getApiLink();
    var requestToken = await Services.getToken();
    final requestUrl = '$host/api/contract';
    final response = await Services.doGet(requestUrl, requestToken);
    if (response.isSuccess()) {
      final body = jsonDecode(response.body);
      List<dynamic> listItem = body['data']['contract_list'];
      for (var item in listItem) {
        result.add(Contract.fromJson(item));
      }
    }
    return result;
  }
}