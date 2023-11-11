import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:pipadmin/utils/common.dart';
import '../utils/api.dart';

class UserProvider{
  static Future<Map<String, Object>> loginAuthenticate(String phone, String password) async {
    var status = 0;
    var idUser = 0;
    String? role = '';
    String token = '';
    Map<String, Object> myData = {
      'status': status,
      'idUser': idUser,
      'phone': phone,
      'role': role,
      'access_token': token
    };
    final host = await Services.getApiLink();
    final url = "$host/api/auth-user/login";
    final data = {'phone': phone, 'password': password};
    final body = json.encode(data);
    final response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json"
        },
        body: body);
    if (response.isSuccess()) {
      if (response.statusCode == 200) {
        var respBody = json.decode(response.body);
        myData['status'] = respBody['status'];
        var data = respBody['data'];
        var user_info = respBody['data']['user_info'];
        myData['idUser'] = user_info['_id'];
        myData['phone'] = user_info['phone'];
        myData['role'] = user_info['role'];
        myData['access_token'] = data['access_token'];
      }
    }
    return myData;
  }

  static Future<int> Logout(String token) async{
    var status = 0;
    var message = '';
    final host = await Services.getApiLink();
    final url = "$host/api/auth-user/logout";
    final response = await Services.doPost(url, token, null);
    if(response.isSuccess()){
      final responseBody = jsonDecode(response.body);
      status = responseBody['status'];
      message = responseBody['message'];
    }
    else{
      status = 0;
    }
    return status;
  }
}