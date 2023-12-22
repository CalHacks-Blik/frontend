import 'package:crypto_app/models/crypto.dart';
import 'package:crypto_app/widgets/balance_panel/profit_percentage.dart';
import 'package:crypto_app/widgets/crypto_icon.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Center aiReply(List<CryptoValueData> data, ThemeData themeData, String iconUrl,
    String amount, String summary, BuildContext context) {
  Rx<double> minY = 0.0.obs;
  Rx<double> maxY = 0.0.obs;
  List sortedSpots = data.toList();
  sortedSpots.sort((a, b) => a.close.compareTo(b.close));
  minY.value = sortedSpots.first.close;
  maxY.value = sortedSpots.last.close;
  double profitPercent = ((data.last.close - data[data.length - 2].close) /
          data[data.length - 2].close) *
      100;

  return Center(
    child: Container(
      decoration: BoxDecoration(
        color: themeData.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      width: 90.w,
      height: 42.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              summary,
              maxLines: 2,
              style: GoogleFonts.poppins(),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Current Predictions',
                      style: GoogleFonts.lato(
                        color: themeData.primaryColor.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.5.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeData.backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Container(
                            width: 30,
                            child: Image.network(
                              iconUrl,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 100,
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
                    series: <ChartSeries<CryptoValueData, DateTime>>[
                      LineSeries<CryptoValueData, DateTime>(
                          dataSource: data,
                          markerSettings: MarkerSettings(isVisible: false),
                          dataLabelSettings:
                              DataLabelSettings(isVisible: false),
                          enableTooltip: false,
                          xValueMapper: (CryptoValueData sales, _) =>
                              DateTime.parse(sales.date),
                          yValueMapper: (CryptoValueData sales, _) =>
                              sales.close,
                          color: Colors.white.withOpacity(1)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                int.parse(amount) != 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Profit',
                            style: GoogleFonts.lato(
                              color: themeData.primaryColor.withOpacity(0.7),
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 0.2.h),
                            child: Text(
                              '\$${(int.parse(amount) + (profitPercent / 100)).round()}',
                              style: GoogleFonts.poppins(
                                color: themeData.primaryColor.withOpacity(0.9),
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                profitPercentageWidget(profitPercent),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
