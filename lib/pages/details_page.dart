import 'package:crypto_app/models/crypto.dart';
import 'package:crypto_app/widgets/chart/chart.dart';
import 'package:crypto_app/widgets/chart/chart_sort_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unicons/unicons.dart';

class DetailsPage extends StatefulWidget {
  final String cryptoIcon;
  final String crypto;
  final String cryptoCode;
  final String exchangeCurrency;
  final List<CryptoValueData> spots;
  final double profitPercent;
  final double minY;
  final double maxY;
  const DetailsPage({
    Key? key,
    required this.cryptoIcon,
    required this.crypto,
    required this.cryptoCode,
    required this.exchangeCurrency,
    required this.spots,
    required this.profitPercent,
    required this.minY,
    required this.maxY,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    for (var i = 0; i < widget.spots.length; i++) {
      totalSpotsValue.value += widget.spots[i].close;
    }
    super.initState();
  }

  Rx<double> totalSpotsValue = 0.0.obs;
  Rx<int> selectedSort = 2.obs;
  List sortStrings = [
    '1H',
    '1D',
    '1W',
    '1M',
    '1Y',
  ];
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0), //appbar size
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: themeData.backgroundColor,
          leading: Padding(
            padding: EdgeInsets.only(left: 5.w),
            child: SizedBox(
              height: 3.5.h,
              width: 10.w,
              child: InkWell(
                onTap: () => Get.back(),
                child: Container(
                  decoration: BoxDecoration(
                    color: themeData.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    UniconsLine.angle_left,
                    color: themeData.primaryColor,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: 15.w,
          title: Text(
            widget.crypto,
            style: GoogleFonts.lato(
              color: themeData.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: SizedBox(
                height: 3.5.h,
                width: 10.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: themeData.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    UniconsLine.bell,
                    color: themeData.primaryColor,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeData.primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: 30,
                        child: Image.network(
                          widget.cryptoIcon,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0.5.h),
              child: Center(
                child: Text(
                  '\$${widget.spots.last.close.toStringAsFixed(2).replaceFirst('.', ',').replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.')}',
                  style: GoogleFonts.lato(
                    letterSpacing: 1,
                    color: themeData.primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                ' ${widget.cryptoCode}/${widget.exchangeCurrency}',
                style: GoogleFonts.lato(
                  letterSpacing: 1,
                  color: themeData.primaryColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 15.sp,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.profitPercent >= 0
                      ? UniconsLine.arrow_growth
                      : UniconsLine.chart_down,
                  color: widget.profitPercent >= 0
                      ? Colors.green[600]
                      : Colors.red[600],
                  size: 20.sp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    '${widget.profitPercent.toStringAsFixed(2).replaceFirst('.', ',')}%',
                    style: GoogleFonts.poppins(
                      color: widget.profitPercent >= 0
                          ? Colors.green[600]
                          : Colors.red[600],
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 1.h, bottom: 3.h),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: SizedBox(
                          height: 30.h,
                          child: SfCartesianChart(
                            borderWidth:
                                0, // Remove border around the entire chart
                            plotAreaBorderWidth:
                                0, // Remove border around the plot area
                            primaryXAxis: DateTimeAxis(
                              majorGridLines: MajorGridLines(
                                  width: 0), // Remove vertical grid lines
                              axisLine:
                                  AxisLine(width: 0), // Remove X-axis line
                              labelStyle: TextStyle(
                                  fontSize: 0), // Remove X-axis labels
                              majorTickLines: MajorTickLines(
                                  size: 0), // Remove X-axis tick marks
                            ),
                            primaryYAxis: NumericAxis(
                              labelStyle: TextStyle(
                                  fontSize: 0), // Remove Y-axis labels
                              majorGridLines: MajorGridLines(
                                  width: 0), // Remove horizontal grid lines
                              axisLine:
                                  AxisLine(width: 0), // Remove Y-axis line
                              majorTickLines: MajorTickLines(
                                  size: 0), // Remove Y-axis tick marks
                            ),

                            series: <ChartSeries<CryptoValueData, DateTime>>[
                              LineSeries<CryptoValueData, DateTime>(
                                dataSource: widget.spots,
                                enableTooltip: false,
                                xValueMapper: (CryptoValueData sales, _) =>
                                    DateTime.parse(sales.date),
                                yValueMapper: (CryptoValueData sales, _) =>
                                    sales.close,
                                color: widget.profitPercent >= 0
                                    ? Colors.green
                                    : Colors
                                        .red, // Set line color based on profit
                                width: 2.0, // Set the line width
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: SizedBox(
                height: 5.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sortStrings.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Obx(() => i == selectedSort.value
                        ? GestureDetector(
                            onTap: () => selectedSort.value = i,
                            child: chartSortWidget(
                                sortStrings[i], true, themeData))
                        : GestureDetector(
                            onTap: () => selectedSort.value = i,
                            child: chartSortWidget(
                                sortStrings[i], false, themeData)));
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {}, //TODO: add sell action
                    splashColor:
                        themeData.secondaryHeaderColor.withOpacity(0.5),
                    highlightColor:
                        themeData.secondaryHeaderColor.withOpacity(0.8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeData.primaryColor.withOpacity(0.05),
                        border: Border.all(
                          color: themeData.secondaryHeaderColor,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 43.w,
                      height: 7.h,
                      child: Center(
                        child: Text(
                          'Sell',
                          style: GoogleFonts.lato(
                            color: themeData.primaryColor.withOpacity(0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {}, //TODO: add buy action
                    splashColor: themeData.primaryColor,
                    highlightColor: themeData.primaryColor,
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeData.secondaryHeaderColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 43.w,
                      height: 7.h,
                      child: Center(
                        child: Text(
                          'Buy',
                          style: GoogleFonts.lato(
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
