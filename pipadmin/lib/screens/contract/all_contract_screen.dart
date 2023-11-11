import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pipadmin/models/contract.dart';
import 'package:pipadmin/providers/contract_provider.dart';
import 'package:pipadmin/screens/contract/contract_screen.dart';
import 'package:pipadmin/screens/contract/stats_contract_screen.dart';
import 'package:pipadmin/utils/app_colors.dart';
import 'package:pipadmin/utils/common.dart';
import 'package:pipadmin/widgets/loading_center_widget.dart';
import 'package:pipadmin/widgets/share_widget.dart';
import 'package:pipadmin/widgets/small_text.dart';

import '../../utils/api.dart';
import '../../utils/dimension.dart';
import '../../utils/helper.dart';
import 'contract_supplier_screen.dart';

class AllContractScreen extends StatefulWidget {
  static const String routeName = "/all_contract";
  const AllContractScreen({Key? key}) : super(key: key);

  @override
  State<AllContractScreen> createState() => _AllContractScreenState();
}

class _AllContractScreenState extends State<AllContractScreen> {
  String api = '';
  var loading = false;
  List<Contract> _listContracts = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var currUser = await Helper.getCurrentUser();
      api = await Services.getApiLink();
      await fetchListContractByMonth();
    });
  }


  @override
  void dispose() async {
    // _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchListContractByMonth() async {
    try {
      setState(() {
        loading = true;
      });
      var apiContractPage = await ContractProvider.fetchAllListContract();
      var contracts = apiContractPage;
      setState(() {
        loading = false;
        _listContracts = contracts;
      });
    } on SocketException catch (ex) {
      throw Exception('Failed to load ${ex.message}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SharedWidget.getAppBar("Hợp đồng", context),
        body: Container(
          color: AppColors.mainAppColor.withOpacity(0.1),
          child: Padding(
            padding: EdgeInsets.all(Dimensions.getScaleHeight(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, ContractScreen.routeName);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: Dimensions.getScaleWidth(150),
                        margin: EdgeInsets.only(bottom: Dimensions.getScaleHeight(20)),
                        height: Dimensions.getScaleHeight(50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.mainAppColor
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_month_outlined,color: Colors.white,size: 24,),
                            CustomText(
                              text: " Tháng",
                              size: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.getScaleWidth(20),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, StatsContractScreen.routeName);
                      },
                      child: Container(
                        width: Dimensions.getScaleWidth(150),
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(bottom: Dimensions.getScaleHeight(20)),
                        height: Dimensions.getScaleHeight(50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.mainAppColor
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.query_stats,color: Colors.white,size: 24,),
                            CustomText(
                              text: " Thống kê",
                              size: 21,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                loading == true? const LoadingCenterWidget():
                Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        // controller: _scrollController,
                        itemCount: _listContracts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 0,
                            mainAxisExtent: Dimensions.getScaleHeight(250),
                            crossAxisCount: 2),
                        itemBuilder: (context, index){
                          var contract =_listContracts[index];
                          return GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, ContractSupplierScreen.routeName, arguments: contract.supplierId);
                              },
                              child: Container(
                                margin: EdgeInsets.all(Dimensions.getScaleWidth(4)),
                                padding: EdgeInsets.all(Dimensions.getScaleWidth(5)),
                                decoration: BoxDecoration(
                                  color: AppColors.mainAppColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(4),
                                      height: Dimensions.getScaleHeight(150),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  'https://api.nongthonviet.com.vn/media/2023/03/07/64069aa35c47da21abf7e772_image9-1677813242-948-width600height384.jpg'))),
                                    ),
                                    CustomText(
                                      text: 'Tên khách hàng: ${contract.customerName}',
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.bold,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      height: Dimensions.getScaleHeight(10),
                                    ),
                                    CustomText(
                                      text: 'SDT: ${contract.customerPhone}',
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                    CustomText(
                                      text: 'Thời gian: ${contract.pickupTime}',
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ],
                                ),
                              )
                          );
                        }
                    )
                )
              ],
            ),
          ),
        )
    );
  }
}
