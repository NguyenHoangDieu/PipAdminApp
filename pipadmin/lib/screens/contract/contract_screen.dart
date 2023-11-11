import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pipadmin/models/contract.dart';
import 'package:pipadmin/providers/contract_provider.dart';
import 'package:pipadmin/utils/app_colors.dart';
import 'package:pipadmin/widgets/loading_center_widget.dart';
import 'package:pipadmin/widgets/share_widget.dart';
import 'package:pipadmin/widgets/small_text.dart';

import '../../utils/api.dart';
import '../../utils/dimension.dart';
import '../../utils/helper.dart';

class ContractScreen extends StatefulWidget {
  static const String routeName = "/contract";
  const ContractScreen({Key? key}) : super(key: key);

  @override
  State<ContractScreen> createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen> {
  int selectedMonth = 1;
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
      setState(() {
        selectedMonth;
      });
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
      var apiContractPage = await ContractProvider.fetchListContractByMonth(selectedMonth);
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
      appBar: SharedWidget.getAppBar("Hợp đồng theo tháng", context),
      body: Container(
        padding: EdgeInsets.all(Dimensions.getScaleHeight(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton<int>(
              value: selectedMonth,
              onChanged: (int? newValue) {
                setState(() {
                  selectedMonth = newValue!;
                });
                fetchListContractByMonth();
              },
              items: List.generate(12, (index) {
                return DropdownMenuItem<int>(
                  value: index + 1,
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.mainAppColor
                      ),
                      child: CustomText(
                        text: "Tháng ${index +1}",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        size: 18,
                      )
                  ),
                );
              }),
            ),
            loading? const LoadingCenterWidget():
            Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    // controller: _scrollController,
                    itemCount: _listContracts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 0,
                        mainAxisExtent: Dimensions.getScaleHeight(280),
                        crossAxisCount: 2),
                    itemBuilder: (context, index){
                      var contract =_listContracts[index];
                      return GestureDetector(
                        onTap: (){

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
                                height: Dimensions.getScaleHeight(120),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://api.nongthonviet.com.vn/media/2023/03/07/64069aa35c47da21abf7e772_image9-1677813242-948-width600height384.jpg'))),
                              ),
                              CustomText(
                                text: 'Người cung cấp: ${contract.supplierName}',
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                size: 15,
                              ),
                              CustomText(
                                text: 'Khách hàng: ${contract.customerName}',
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                size: 15,
                              ),
                              const Divider(thickness: 1,color: Colors.white,),
                              CustomText(
                                text: 'Thời gian: ${contract.pickupTime}',
                                color: Colors.white,
                                size: 12,
                              ),
                              CustomText(
                                text: 'Xe: ${contract.carName}',
                                color: Colors.white,
                                size: 12,
                              ),
                              CustomText(
                                text: 'Dịch vụ: ${contract.serviceName}',
                                color: Colors.white,
                                size: 12,
                              ),
                              CustomText(
                                text: 'Giá: ${contract.price}đ',
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
      )
    );
  }
}
