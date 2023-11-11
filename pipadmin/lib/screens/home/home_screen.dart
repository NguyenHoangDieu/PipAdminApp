import 'package:flutter/material.dart';
import 'package:pipadmin/screens/contract/all_contract_screen.dart';
import 'package:pipadmin/screens/contract/contract_screen.dart';
import 'package:pipadmin/widgets/share_widget.dart';

import '../../models/user.dart';
import '../../providers/user_provider.dart';
import '../../utils/api.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimension.dart';
import '../../utils/helper.dart';
import '../../widgets/small_text.dart';
import '../login/login_screen.dart';

class HomePageScreen extends StatefulWidget {
  static const String routeName = "/";
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedScreenIndex = 0;
  String api = '';
  final int _currentPage = 0;
  UserInfo currentUser = UserInfo();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      currentUser = await Helper.getCurrentUser();
      api = await Services.getApiLink();
      setState(() {
        _currentPage;
      });
    });
  }


  @override
  void dispose() async {
    // _scrollController.dispose();
    super.dispose();
  }

  void onTapHandler(int index)  {
    setState(() {
      _selectedScreenIndex = index;
    });
    switch(_selectedScreenIndex){
      case 0 : Navigator.pushNamed(context, HomePageScreen.routeName, arguments: currentUser);
      break;
      case 1 : Navigator.pushNamed(context, ContractScreen.routeName);
      break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.only(
            top: Dimensions.getScaleHeight(20),
            left: Dimensions.getScaleWidth(10),
            right: Dimensions.getScaleWidth(45),
          ),
          color: AppColors.mainAppColor,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only( left: Dimensions.getScaleWidth(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: const NetworkImage(
                          'https://images.unsplash.com/photo-1640915550677-26ade06905fd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzN3x8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60'),
                      child: InkWell(
                        onTap: (){
                          // currentUser.id != null?
                          // Navigator.pushNamed(context, ProfileScreen.routeName, arguments: currentUser.id):
                          // Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.getScaleHeight(10),
                    ),
                    CustomText(
                      text: currentUser.phone??"Khách hàng",
                      color: Colors.white,

                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.getScaleHeight(20)),

              const Divider(thickness: 1,color: Colors.white,),
              currentUser.phone == null ?
              buildMenuItem(
                  text: 'Đăng nhập',
                  icon: Icons.login,
                  onClick: (){
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  }
              ):
              buildMenuItem(
                  text: 'Đăng xuất',
                  icon: Icons.logout,
                  onClick: (){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(
                            title: const Text(
                                'ĐĂNG XUẤT KHỎI HỆ THỐNG'),
                            content: const Text(
                                'Bạn có chắc chắn không?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Không',
                                    style: TextStyle(
                                        color: AppColors
                                            .mainAppColor)),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors
                                      .mainAppColor,
                                ),
                                onPressed: () {
                                  Helper.onSignOut(context);
                                },
                                child: const Text('Có'),
                              ),
                            ],
                          ),
                    );
                  }
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedScreenIndex,
      //   onTap: (int index) {
      //     onTapHandler(index);
      //   },
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: AppColors.mainAppColor,
      //   selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      //   unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      //   unselectedItemColor: AppColors.mainAppColor.withOpacity(0.5),
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home,
      //         color: AppColors.mainAppColor,
      //       ),
      //       label: 'Trang chủ',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.handshake_sharp,
      //       ),
      //       label: 'Hợp đồng',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.motorcycle_sharp,
      //       ),
      //       label: 'Xe',
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        title: const CustomText(
          text: "PIPPIP xin chào!",
          color: Colors.white,
          fontWeight: FontWeight.bold,
          size: 30,
        ),
      ),
      body: Container(
        color: AppColors.mainAppColor.withOpacity(0.1),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.getScaleHeight(25)),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 0,
                mainAxisExtent: Dimensions.getScaleHeight(100),
                crossAxisCount: 2),
            children: [
              InkWell(
                onTap: (){
                  currentUser.phone == null ?
                  Navigator.pushNamed(context, LoginScreen.routeName):
                  Navigator.pushNamed(context, AllContractScreen.routeName);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Dimensions.getScaleHeight(100),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.mainAppColor
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.handshake,color: Colors.white,size: 24,),
                      CustomText(
                        text: " Hợp đồng",
                        size: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: Dimensions.getScaleHeight(100),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.mainAppColor
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.motorcycle_sharp,color: Colors.white,size: 24,),
                      CustomText(
                        text: " Xe",
                        size: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClick
}){
  const color = Colors.white;
  const hoverColor = Colors.white70;
  return ListTile(
    leading: Icon(icon, color: color,),
    title: CustomText(
      text: text,
      color: color,
    ),
    hoverColor: hoverColor,
    onTap: onClick,
  );
}