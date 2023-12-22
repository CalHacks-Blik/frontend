import 'dart:convert';

import 'package:animation_list/animation_list.dart';
import 'package:crypto_app/models/crypto.dart';
import 'package:crypto_app/pages/details_page.dart';
import 'package:crypto_app/widgets/actions/actions_widget.dart';
import 'package:crypto_app/widgets/balance_panel/balance_panel.dart';
import 'package:crypto_app/widgets/balance_panel/profit_percentage.dart';
import 'package:crypto_app/widgets/chart/chart.dart';
import 'package:crypto_app/widgets/chart/chart_home_page.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math' as math;
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unicons/unicons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CryptoData> topCryptoDataList = [];
  List<CryptoData> cryptoList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://scintillating-discovery-production.up.railway.app/get_top'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      for (var data in jsonData) {
        cryptoList.add(CryptoData.fromJson(data));
      }

      setState(() {
        topCryptoDataList = cryptoList.take(5).toList();
        isLoading = false; // Set loading to false when data is loaded.
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  bool isLoading = true; // Initially, set loading to true.

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      // backgroundColor: themeData.backgroundColor,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 0),
                      child: Text("Hey Dhravya 👋",
                          style: GoogleFonts.poppins(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // SfCartesianChart(series: <CartesianSeries>[
                    //   AreaSeries<ChartData, double>(
                    //     dataSource: chartData,
                    //     xValueMapper: (ChartData data, _) => data.x,
                    //     yValueMapper: (ChartData data, _) => data.y,
                    //     borderWidth: 4,
                    //     borderGradient: const LinearGradient(colors: <Color>[
                    //       Color.fromRGBO(230, 0, 180, 1),
                    //       Color.fromRGBO(255, 200, 0, 1)
                    //     ], stops: <double>[
                    //       0.2,
                    //       0.9
                    //     ]),
                    //   )
                    // ]),
                    isLoading
                        ? shimmerLoading(context)
                        : Container(
                            height: 200,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0.0, end: 1.0),
                              builder: (context, a, widget) {
                                return Opacity(
                                    opacity: a as double,
                                    child: AnimationList(
                                      duration: 1000,
                                      axis: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      children: topCryptoDataList
                                          .map((e) => Padding(
                                                padding:
                                                    EdgeInsets.only(right: 20),
                                                child: Container(
                                                  width: 200,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                      color: Colors.white
                                                          .withOpacity(0.2),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 15.0),
                                                          child:
                                                              SfCartesianChart(
                                                            borderWidth: 0,
                                                            plotAreaBorderWidth:
                                                                0,
                                                            primaryXAxis:
                                                                DateTimeAxis(
                                                              majorGridLines:
                                                                  MajorGridLines(
                                                                      width: 0),
                                                              axisLine:
                                                                  AxisLine(
                                                                      width: 0),
                                                              labelStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          0),
                                                              majorTickLines:
                                                                  MajorTickLines(
                                                                      size: 0),
                                                            ),
                                                            primaryYAxis:
                                                                NumericAxis(
                                                              labelStyle:
                                                                  TextStyle(
                                                                      fontSize:
                                                                          0),
                                                              majorGridLines:
                                                                  MajorGridLines(
                                                                      width: 0),
                                                              axisLine:
                                                                  AxisLine(
                                                                      width: 0),
                                                              majorTickLines:
                                                                  MajorTickLines(
                                                                      size: 0),
                                                            ),
                                                            series: <ChartSeries<
                                                                CryptoValueData,
                                                                DateTime>>[
                                                              LineSeries<
                                                                  CryptoValueData,
                                                                  DateTime>(
                                                                dataSource:
                                                                    e.values,
                                                                markerSettings:
                                                                    MarkerSettings(
                                                                        isVisible:
                                                                            false),
                                                                dataLabelSettings:
                                                                    DataLabelSettings(
                                                                        isVisible:
                                                                            false),
                                                                enableTooltip:
                                                                    false,
                                                                xValueMapper: (CryptoValueData
                                                                            sales,
                                                                        _) =>
                                                                    DateTime.parse(
                                                                        sales
                                                                            .date),
                                                                yValueMapper:
                                                                    (CryptoValueData
                                                                                sales,
                                                                            _) =>
                                                                        sales
                                                                            .close,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              width: 30,
                                                              child:
                                                                  Image.network(
                                                                e.iconUrl,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top:    10,
                                                                      left:
                                                                          1.w),
                                                              child: Container(
                                                                width: 130,
                                                                child: Text(
                                                                  '${e.cryptoName}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade,
                                                                  //($cryptoCode)  - $exchangeCurrency',
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize:
                                                                        20,
                                                                    height: 01,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  maxLines: 2,
                                                                ),
                                                              ),
                                                            ),
                                                            // Transform.scale(
                                                            //     child: profitPercentageWidget(profitPercent),
                                                            //     scale: 0.9),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ));
                              },
                              duration: Duration(milliseconds: 500),
                            ),
                          ),

                    SizedBox(
                      height: 20,
                    ),
                    // balancePanel(balance, profit, profitPercent, themeData),
                    // actionsWidget(themeData),
                    Text("All Cryptocurrencies",
                        style: GoogleFonts.poppins(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20,
                    ),
                    AnimationList(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: topCryptoDataList
                            .map(
                              (e) => chartHomePage(
                                  true,
                                  e.iconUrl,
                                  e.cryptoName,
                                  e.cryptoCode,
                                  e.values[0].close.toString(),
                                  e.values,
                                  themeData),
                            )
                            .toList())
                  ])),
        ),
      ),
    );
  }
}

// Center homeChartTrending(
//   bool isHomePage,
//   IconData cryptoIcon,
//   String crypto,
//   String cryptoCode,
//   String currValue,
//   List<CryptoValueData> spots,
//   ThemeData themeData,
// ) {
//   Rx<double> minY = 0.0.obs;
//   Rx<double> maxY = 0.0.obs;
//   List sortedSpots = spots.toList();
//   sortedSpots.sort((a, b) => a.y.compareTo(b.y));
//   minY.value = sortedSpots.first.y;
//   maxY.value = sortedSpots.last.y;
//   double profitPercent =
//       ((spots.last.y - spots[spots.length - 2].y) / spots[spots.length - 2].y) *
//           100;

//   return Center(
//     child: Padding(
//       padding: const EdgeInsets.only(left: 10.0),
//       child: GestureDetector(
//         onTap: () => Get.to(
//           () => DetailsPage(
//             cryptoIcon: cryptoIcon,
//             crypto: crypto,
//             cryptoCode: cryptoCode,
//             exchangeCurrency: currValue,
//             spots: spots,
//             profitPercent: profitPercent,
//             maxY: maxY.value,
//             minY: minY.value,
//           ),
//         ),
//         child: Container(
//           width: 200,
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(
//               color: Colors.white.withOpacity(0.2),
//               width: 2,
//             ),
//           ),
//           child: Stack(
//             children: [
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Transform.rotate(
//                   angle: math.pi - 85,
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 1.h, bottom: 3.h),
//                     child: SizedBox(
//                       width: 170,
//                       height: 164,
//                       child: lineChart(spots)
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Align(
//                   alignment: Alignment.bottomRight,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         "USD",
//                         style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                       Text(
//                         currValue,
//                         style: GoogleFonts.poppins(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Row(
//                   children: [
//                     Icon(
//                       cryptoIcon,
//                       size: 20.sp,
//                       color: Colors.white,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 1.w),
//                       child: Container(
//                         width: 130,
//                         child: Text(
//                           '$crypto',
//                           overflow: TextOverflow.fade,
//                           //($cryptoCode)  - $exchangeCurrency',
//                           style: GoogleFonts.poppins(
//                             fontSize: 20.sp,
//                             height: 01,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                           maxLines: 2,
//                         ),
//                       ),
//                     ),
//                     // Transform.scale(
//                     //     child: profitPercentageWidget(profitPercent),
//                     //     scale: 0.9),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

Widget shimmerLoading(BuildContext context) {
  return Shimmer.fromColors(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 300,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              Container(
                width: 180,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)),
              ),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 180,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15)),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("All Cryptocurrencies",
            style:
                GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 20,
        ),
        ListView(
          shrinkWrap: true,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(15)),
            )
          ],
        )
      ],
    ),
    baseColor: Colors.grey.withOpacity(0.5),
    highlightColor: Colors.grey.withOpacity(0.2),
  );
}
