import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimension.dart';
import '../../widgets/share_widget.dart';
import '../../widgets/small_text.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool executing = false;
  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();
  final controller = PageController();
  @override
  void initState(){
    super.initState();

  }

  onLogin() async {
    var isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      executing = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    var result = 0;
    var user = User();
    user.phone = phoneController.text;
    user.password = passwordController.text;
    var dataUser = await UserProvider.loginAuthenticate(user.phone??'',user.password??'');
    Map<String, Object?> myData = {
      'status': dataUser['status'],
      'message': dataUser['message'],
      'phone': dataUser['phone'],
      'role': dataUser['role'],
      'access_token': dataUser['access_token'],
      'idUser': dataUser['idUser']
    };
    result = myData['status'] as int;
    user.accessToken = myData['access_token'] as String;
    UserInfo userInfo = UserInfo();
    userInfo.phone = myData['phone'] as String;
    userInfo.role = myData['role'] as String;
    userInfo.sId = myData['idUser'] as String;
    setState(() {
      executing = false;
    });
    SharedWidget.showNotifToast(
        myData['result'] != 0
            ? 'Đăng nhập thành công'
            : 'Tên tài khoản hoặc mật khẩu không chính xác',
        isSucceed: myData['result'] ==0 ? false: true);
    await Future.delayed(const Duration(seconds: 1));
    if(result == 1){
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', user.accessToken??'');
      await prefs.setString('user', jsonEncode(userInfo.toJson()));
      if (context.mounted) {
        Navigator.pushNamed(context, HomePageScreen.routeName);
        // Navigator.popAndPushNamed(context, HomePageScreen.routeName);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.mainAppColorLight,
        width: Dimensions.screenWidth,

        child: ListView(
          children: [
            SizedBox(
              height: Dimensions.getScaleHeight(100),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomText(
                  text: "PIPPIP",
                  fontWeight: FontWeight.w900,
                  size: 60,
                  color: AppColors.mainAppTextWhite,
                ),
                SizedBox(
                  height: Dimensions.getScaleHeight(80),
                ),
                const CustomText(
                  text: "Đăng nhập",
                  fontWeight: FontWeight.w900,
                  size: 40,
                  color: AppColors.mainAppTextWhite,
                ),
                SizedBox(
                  height: Dimensions.getScaleHeight(30),
                ),
              ],
            ),

            Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: Dimensions.getScaleWidth(300),
                      child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập số điện thoại';
                            }
                            return null;
                          },
                          style: TextStyle(
                              height: 1,
                              fontSize: Dimensions.getScaleHeight(18),
                              color: AppColors.mainAppColor),
                          decoration: InputDecoration(
                              labelText: 'Tên đăng nhập',
                              filled: true,
                              fillColor: AppColors.mainAppTextWhite.withOpacity(0.6),
                              labelStyle: TextStyle(
                                  color: AppColors.mainAppColor.withOpacity(0.5),
                                  fontSize: Dimensions.getScaleHeight(18.0)),
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.only(
                                left: Dimensions.getScaleWidth(20),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ))),
                    ),
                    SizedBox(
                      height: Dimensions.getScaleHeight(20),
                    ),
                    SizedBox(
                      width: Dimensions.getScaleWidth(300),
                      child: TextFormField(
                          obscureText: _obscureText,
                          textAlignVertical: TextAlignVertical.center,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            return null;
                          },
                          style: TextStyle(
                              height: 1,
                              fontSize: Dimensions.getScaleHeight(18),
                              color: AppColors.mainAppColor),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  _obscureText ? Icons.visibility : Icons.visibility_off,
                                  color: _obscureText? Colors.grey : AppColors.mainAppColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              labelText: 'Mật khẩu',
                              filled: true,
                              fillColor: AppColors.mainAppTextWhite.withOpacity(0.6),
                              labelStyle: TextStyle(
                                  color: AppColors.mainAppColor.withOpacity(0.5),
                                  fontSize: Dimensions.getScaleHeight(18.0)),
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.only(
                                left: Dimensions.getScaleWidth(20),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ))),
                    ),
                    SizedBox(
                      height: Dimensions.getScaleHeight(50),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Dimensions.getScaleWidth(120),
                          height: Dimensions.getScaleHeight(60),
                          child: GestureDetector(
                            onTap: () {
                              onLogin();
                            },
                            child: Container(
                              // margin: const EdgeInsets.only(left: 30, right: 30),
                              alignment: Alignment.center,
                              height: 60,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: AppColors.mainAppColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: executing
                                  ? SizedBox(
                                width: Dimensions.getScaleHeight(20),
                                height: Dimensions.getScaleHeight(20),
                                child: CircularProgressIndicator(
                                    strokeWidth:
                                    Dimensions.getScaleHeight(2.0),
                                    color: Colors.white),
                              )
                                  : const CustomText(
                                  text: 'Đăng nhập',
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                  size: 18
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )),

          ],
        ),
      ),
    );
  }
}
