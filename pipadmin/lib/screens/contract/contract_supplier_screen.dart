import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pipadmin/widgets/loading_center_widget.dart';
import 'package:pipadmin/widgets/share_widget.dart';
import 'package:pipadmin/widgets/small_text.dart';

import '../../models/contract.dart';
import '../../providers/contract_provider.dart';
import '../../utils/api.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimension.dart';
import '../../utils/helper.dart';

class ContractSupplierScreen extends StatefulWidget {
  static const String routeName = "/supplier_contract";
  const ContractSupplierScreen({Key? key}) : super(key: key);

  @override
  State<ContractSupplierScreen> createState() => _ContractSupplierScreenState();
}

class _ContractSupplierScreenState extends State<ContractSupplierScreen> {
  String api = '';
  String supplierId = '';
  var loading = false;
  List<Contract> _listContracts = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      var currUser = await Helper.getCurrentUser();
      api = await Services.getApiLink();
      var id = ModalRoute.of(context)!.settings.arguments as String;
      supplierId = id;
      await fetchListContractBySupplier();
    });
  }


  @override
  void dispose() async {
    // _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchListContractBySupplier() async {
    try {
      setState(() {
        loading = true;
      });
      var apiContractPage = await ContractProvider.fetchListContractBySupplierId(supplierId);
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
      appBar: SharedWidget.getAppBar("Chi tiết hợp đồng", context),
      body: Column(
        children: [
          SizedBox(
            height: Dimensions.getScaleHeight(15),
          ),
          loading?
          const LoadingCenterWidget():
          ListView.builder(
            shrinkWrap: true,
              itemCount: _listContracts.length,
              itemBuilder: (context, index){
              var itemContract = _listContracts[index];
            return Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Card(
                shadowColor: AppColors.mainAppColor,
                color: AppColors.mainAppColor,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: Dimensions.getScaleHeight(200),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://api.nongthonviet.com.vn/media/2023/03/07/64069aa35c47da21abf7e772_image9-1677813242-948-width600height384.jpg'))),
                    ),
                    CustomText(
                      text: 'Tài xế: ${itemContract.supplierName} (SDT: ${itemContract.supplierPhone})',
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      size: 15,
                    ),
                    CustomText(
                      text: 'Khách hàng: ${itemContract.customerName} (SDT: ${itemContract.customerPhone})',
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                      size: 15,
                    ),
                    const Divider(thickness: 1,color: Colors.white,),
                    CustomText(
                      text: 'Thời gian: ${itemContract.pickupTime}',
                      color: Colors.white,
                      size: 12,
                    ),
                    CustomText(
                      text: 'Xe: ${itemContract.carName} (Biển số: ${itemContract.carNumber}',
                      color: Colors.white,
                      size: 12,
                    ),
                    CustomText(
                      text: 'Dịch vụ: ${itemContract.serviceName}',
                      color: Colors.white,
                      size: 12,
                    ),
                    CustomText(
                      text: 'Giá: ${itemContract.price}đ',
                      color: Colors.white,
                      size: 12,
                    ),
                    SizedBox(
                      height: Dimensions.getScaleHeight(30),
                    )
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
