import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pipadmin/screens/car/stats_cartype_screen.dart';
import 'package:pipadmin/screens/car/supplier_detail_screen.dart';
import 'package:pipadmin/screens/car/supplier_list_screen.dart';
import 'package:pipadmin/screens/contract/all_contract_screen.dart';
import 'package:pipadmin/screens/contract/contract_screen.dart';
import 'package:pipadmin/screens/contract/contract_supplier_screen.dart';
import 'package:pipadmin/screens/contract/stats_contract_screen.dart';
import 'package:pipadmin/screens/home/home_screen.dart';
import 'package:pipadmin/screens/login/login_screen.dart';
import 'package:pipadmin/state_maneger/user_changeNotifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserChangeNotifier())
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePageScreen(),
          '/login': (context) => const LoginScreen(),
          '/contract': (context) => const ContractScreen(),
          '/all_contract': (context) => const AllContractScreen(),
          '/supplier_contract': (context) => const ContractSupplierScreen(),
          '/stats_contract': (context) => const StatsContractScreen(),
          '/all_supplier': (context) => const SupplierListScreen(),
          '/supplier_detail': (context) => const SupplierDetailScreen(),
          '/stat_cartype': (context) => const  StatCarTypeScreen()
        },
      ),
    );
  }
}

