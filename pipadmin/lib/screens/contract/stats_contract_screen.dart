import 'dart:io';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pipadmin/models/contract.dart';
import 'package:pipadmin/utils/app_colors.dart';
import 'package:pipadmin/utils/dimension.dart';
import 'package:pipadmin/widgets/share_widget.dart';
import 'package:pipadmin/widgets/small_text.dart';

import '../../providers/contract_provider.dart';
import '../../utils/api.dart';
import '../../utils/helper.dart';
import '../../widgets/loading_center_widget.dart';

class StatsContractScreen extends StatefulWidget {
  static const String routeName = "/stats_contract";
  const StatsContractScreen({Key? key}) : super(key: key);

  @override
  State<StatsContractScreen> createState() => _StatsContractScreenState();
}

class _StatsContractScreenState extends State<StatsContractScreen> {
  List<int> years = List.generate(13, (index) => 2011 + index);
  int selectedYear = 2022;
  String api = '';
  var loading = false;
  List<ContractStats> _listStatsContracts = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      api = await Services.getApiLink();
      await fetchListContractByYear();
      setState(() {
        selectedYear;
      });
    });
  }

  @override
  void dispose() async {
    // _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchListContractByYear() async {
    try {
      setState(() {
        loading = true;
      });
      var apiContractPage = await ContractProvider.fetchListContractByYear(selectedYear);
      var contracts = apiContractPage;
      setState(() {
        loading = false;
        _listStatsContracts = contracts;
      });
    } on SocketException catch (ex) {
      throw Exception('Failed to load ${ex.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedWidget.getAppBar("Thống kê", context),
      body: Container(
        color: AppColors.mainAppColor.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              CustomText(
                  text: "Thống kê số hợp đồng trong năm ${selectedYear}",
                color: AppColors.mainAppColor,
                fontWeight: FontWeight.bold,
                size: 22,
              ),
              const SizedBox(height: 10,),
              DropdownButton<int>(
                focusColor: AppColors.mainAppColor,
                value: selectedYear,
                onChanged: (int? newValue) {
                  setState(() {
                    selectedYear = newValue!;
                    fetchListContractByYear();
                  });
                },
                items: years.map((int year) {
                  return DropdownMenuItem<int>(
                    value: year,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.mainAppColor
                        ),
                        child: CustomText(
                          text: "Năm $year",
                          color: Colors.white,
                        )
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10,),
              loading? Padding(
                padding: EdgeInsets.only(top: Dimensions.getScaleHeight(20)),
                child: const LoadingCenterWidget(),
              ):
              SizedBox(
                height: Dimensions.getScaleHeight(300),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.center,
                    barGroups: List.generate(
                      _listStatsContracts.length,
                          (index) => BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                              fromY: 0,
                              toY: (_listStatsContracts[index].totalContractByMonth??0).toDouble()
                          ),
                        ],
                      ),
                    ),
                    maxY: 100,
                    titlesData: const FlTitlesData(
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: getBottomTitles
                      )),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if(!loading)
              Expanded(
                  child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _listStatsContracts.length,
                  itemBuilder: (context, index){
                    var contract = _listStatsContracts[index];
                    return Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(bottom: 10, left: 50, right: 50),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.mainAppColor, width: 2),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "Tháng ${contract.month}", color: AppColors.mainAppColor, fontWeight: FontWeight.bold,size: 18,),
                          CustomText(text: "Số hợp đồng: ${contract.totalContractByMonth}", color: Colors.grey,),
                          CustomText(text: "Tổng tiền: ${contract.priceByMonth}đ", color: Colors.grey,)
                        ],
                      ),
                    );
                  }))
            ],
          ),
        ),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta){
  const style = TextStyle(
    color: AppColors.mainAppColor,
    fontWeight: FontWeight.bold,
    fontSize: 14
  );
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text("1", style: style);
    case 2:
      text = const Text("2", style: style);
    case 3:
      text = const Text("3", style: style);
    case 4:
      text = const Text("4", style: style);
    case 5:
      text = const Text("5", style: style);
    case 6:
      text = const Text("6", style: style);
    case 7:
      text = const Text("7", style: style);
    case 8:
      text = const Text("8", style: style);
    case 9:
      text = const Text("9", style: style);
    case 10:
      text = const Text("10", style: style);
    case 11:
      text = const Text("11", style: style);
    case 12:
      text = const Text("12", style: style);
    default:
      text = const Text("", style: style);
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
