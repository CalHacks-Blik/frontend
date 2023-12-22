import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';








// LineChartData chart(
//   bool isHomePage,
//   List<FlSpot> spots,
//   double minY,
//   double maxY,
//   bool profit,
// ) {
//   List<Color> greenColors = [
//     Colors.green.withOpacity(0.5),
//     Colors.green.withOpacity(0),
//   ];
//   List<Color> redColors = [
//     Colors.red.withOpacity(0.5),
//     Colors.red.withOpacity(0),
//   ];

//   return LineChartData(
    
//     backgroundColor: Colors.black,
//     gridData: FlGridData(
//       show: !isHomePage,
//       drawVerticalLine: !isHomePage,
//       drawHorizontalLine: true,
//       verticalInterval: 1,
//       getDrawingHorizontalLine: (value) {
//         return FlLine(
//           color: const Color(0xff37434d),
//           strokeWidth: 1,
//         );
//       },
//       getDrawingVerticalLine: (value) {
//         return FlLine(
//           color: const Color(0xff37434d),
//           strokeWidth: 1,
//         );
//       },
//     ),
//     titlesData: isHomePage
//         ? FlTitlesData(show: false)
//         : FlTitlesData(
//             show: true,
//             rightTitles: AxisTitles(
//               sideTitles: SideTitles(showTitles: false),
//             ),
//             topTitles: AxisTitles(
//               sideTitles: SideTitles(showTitles: false),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 reservedSize: 28,
//                 interval: 1,
//                 getTitlesWidget: (value, c) => Text(
//                   value.toString(),
//                   style: TextStyle(
//                     color: const Color(0xff68737d),
//                     fontWeight: FontWeight.bold,
//                     fontSize: 12.sp,
//                   ),
//                 ),
//               ),
//             ),
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(
//                   interval: 100,
//                   showTitles: true,
//                   reservedSize: 50,
//                   getTitlesWidget: (c, value) => Text(
//                         c.toString(),
//                         textAlign: TextAlign.start,
//                         overflow: TextOverflow.clip,
//                         style: TextStyle(
//                           color: const Color(0xff68737d),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       )),
//             )),
//     lineTouchData: LineTouchData(
//       touchTooltipData: LineTouchTooltipData(
//           tooltipBgColor: Colors.black,
//           getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
//             return touchedBarSpots.map((barSpot) {
//               final flSpot = barSpot;
//               return LineTooltipItem(
//                 flSpot.y
//                     .toStringAsFixed(2)
//                     .replaceFirst('.', ',')
//                     .replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), '.'),
//                 GoogleFonts.poppins(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 12.sp,
//                   letterSpacing: 0.5,
//                 ),
//               );
//             }).toList();
//           }),
//     ),
//     minX: 0,
//     maxX: 6,
//     minY: minY,
//     maxY: maxY,
//     lineBarsData: [
//       LineChartBarData(
//         spots: spots,
//         isCurved: true,
//         gradient: profit
//             ? LinearGradient(
//                 colors: greenColors,
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter)
//             : LinearGradient(
//                 colors: redColors,
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter),
//         barWidth: 5,
//         isStrokeCapRound: true,
//         dotData: FlDotData(
//           show: false,
//         ),
//         belowBarData: BarAreaData(
//           show: true,
//           gradient: profit
//               ? LinearGradient(
//                   colors: greenColors.map((color) => color).toList(),
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter)
//               : LinearGradient(
//                   colors: redColors.map((color) => color).toList(),
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter),
//         ),
//       ),
//     ],
//   );
// }
