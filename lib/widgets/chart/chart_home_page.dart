import 'package:crypto_app/models/crypto.dart';
import 'package:crypto_app/pages/details_page.dart';
import 'package:crypto_app/widgets/balance_panel/profit_percentage.dart';
import 'package:crypto_app/widgets/chart/chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Center chartHomePage(
  bool isHomePage,
  String iconUrl,
  String crypto,
  String cryptoCode,
  String exchangeCurrency,
  List<CryptoValueData> spots,
  ThemeData themeData,
) {
  Rx<double> minY = 0.0.obs;
  Rx<double> maxY = 0.0.obs;
  List sortedSpots = spots.toList();
  sortedSpots.sort((a, b) => a.close.compareTo(b.close));
  minY.value = sortedSpots.first.close;
  maxY.value = sortedSpots.last.close;
  double profitPercent = ((spots.last.close - spots[spots.length - 2].close) /
          spots[spots.length - 2].close) *
      100;

  return Center(
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () => Get.to(
          () => DetailsPage(
            cryptoIcon: iconUrl,
            crypto: crypto,
            cryptoCode: cryptoCode,
            exchangeCurrency: exchangeCurrency,
            spots: spots,
            profitPercent: profitPercent,
            maxY: maxY.value,
            minY: minY.value,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 2,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 2.h,
              horizontal: 2.w,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 30,
                        child: Image.network(
                          iconUrl,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 1.w),
                        child: SizedBox(
                          width: 40.w,
                          child: Text(
                            '$crypto ($cryptoCode)',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Transform.scale(
                          child: profitPercentageWidget(profitPercent),
                          scale: 0.9),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 2.h, bottom: 1.h),
                    child: SizedBox(
                      width: 90.w,
                      height: 10.h,
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: Stack(children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 15.0,
                              ),
                              child: SfCartesianChart(
                                borderWidth: 0,
                                plotAreaBorderWidth: 0,
                                primaryXAxis: DateTimeAxis(
                                  majorGridLines: MajorGridLines(width: 0),
                                  axisLine: AxisLine(width: 0),
                                  labelStyle: TextStyle(fontSize: 0),
                                  majorTickLines: MajorTickLines(size: 0),
                                ),
                                primaryYAxis: NumericAxis(
                                  labelStyle: TextStyle(fontSize: 0),
                                  majorGridLines: MajorGridLines(width: 0),
                                  axisLine: AxisLine(width: 0),
                                  majorTickLines: MajorTickLines(size: 0),
                                ),
                                series: <ChartSeries<CryptoValueData,
                                    DateTime>>[
                                  LineSeries<CryptoValueData, DateTime>(
                                    dataSource: spots,
                                    markerSettings:
                                        MarkerSettings(isVisible: false),
                                    dataLabelSettings:
                                        DataLabelSettings(isVisible: false),
                                    enableTooltip: false,
                                    xValueMapper: (CryptoValueData sales, _) =>
                                        DateTime.parse(sales.date),
                                    yValueMapper: (CryptoValueData sales, _) =>
                                        sales.close,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
