import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:safana_bekam_management_app/components/custom_scaffold.dart';
import 'package:safana_bekam_management_app/components/top_bar.dart';
import 'package:safana_bekam_management_app/constant/color.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

Widget leftTitleWidgetsLineChart(double value, TitleMeta meta) {
  const style = TextStyle(fontSize: 12, color: Colors.grey);
  return SideTitleWidget(
    space: 20,
    axisSide: meta.axisSide,
    child: Text(
      value.toInt().toString(),
      style: style,
    ),
  );
}

Widget bottomTitleWidgetsLineChart(double value, TitleMeta meta) {
  const style = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = 'Jan';
      break;
    case 1:
      text = 'Feb';
      break;
    case 2:
      text = 'Mar';
      break;
    case 3:
      text = 'Apr';
      break;
    case 4:
      text = 'May';
      break;
    case 5:
      text = 'Jun';
      break;
    case 6:
      text = 'Jul';
      break;
    case 7:
      text = 'Aug';
      break;
    case 8:
      text = 'Sep';
      break;
    case 9:
      text = 'Oct';
      break;
    case 10:
      text = 'Nov';
      break;
    case 11:
      text = 'Dec';
      break;
    default:
      return Container();
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 10,
    child: Text(text, style: style),
  );
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopBar(),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Papan Pemuka',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _jumlahPelanggan(),
                        Column(
                          children: [
                            _pelangganHariIni(),
                            _pelangganBaru(),
                          ],
                        )
                      ],
                    ),
                    _lineChartBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _jumlahPelanggan() {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: Get.width / 2 - 30,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.people_alt_outlined,
                      size: 40,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Jumlah\nPelanggan',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blueGrey.withOpacity(0.5),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '200',
                    style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
}

Widget _pelangganHariIni() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: SizedBox(
      width: Get.width / 2 - 30,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person_search_outlined, size: 30),
                  const SizedBox(width: 20),
                  Expanded(
                      child: Text(
                    "12",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ))
                ],
              ),
              Text(
                'Pelanggan Harini',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _pelangganBaru() {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: SizedBox(
      width: Get.width / 2 - 30,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person_add_alt, size: 30),
                  const SizedBox(width: 20),
                  Expanded(
                      child: Text(
                    "0",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ))
                ],
              ),
              Text(
                'Pelanggan Baharu',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _lineChartBar() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(10),
      height: Get.height * 0.4,
      width: Get.width - 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Semua",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ConstantColor.primaryColor,
                ),
              ),
              const SizedBox(width: 5),
              const Text("Pelanggan Harini",
                  style: TextStyle(
                      color: Colors.blueGrey, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                "Pelanggan Baharu",
                style: TextStyle(
                    color: Colors.blueGrey, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 20, 10),
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    //pelangan harini
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 0),
                        FlSpot(1, 1),
                        FlSpot(2, 3),
                        FlSpot(3, 8),
                        FlSpot(4, 4),
                        FlSpot(5, 5),
                        FlSpot(6, 6),
                      ],
                      color: ConstantColor.primaryColor,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      preventCurveOverShooting: true,
                    ),
                    //pelangan baharu
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 0),
                        FlSpot(1, 3),
                        FlSpot(2, 1),
                        FlSpot(3, 2),
                        FlSpot(4, 6),
                        FlSpot(5, 7),
                        FlSpot(6, 8),
                      ],
                      color: Colors.blue,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      preventCurveOverShooting: true,
                    )
                  ],
                  lineTouchData: LineTouchData(
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      maxContentWidth: 200,
                      getTooltipItems: (touchedSpots) =>
                          touchedSpots.map((LineBarSpot touchedSpot) {
                        final textStyle = TextStyle(
                          color: touchedSpot.bar.gradient?.colors.first ??
                              touchedSpot.bar.color ??
                              Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        );
                        final label = touchedSpot.bar.color == Colors.blue
                            ? "${touchedSpot.y.toInt()} Pelangan Baharu"
                            : "${touchedSpot.y.toInt()} Pelangan Harini";
                        return LineTooltipItem(label, textStyle);
                      }).toList(),
                      getTooltipColor: (touchedSpot) =>
                          Colors.blueGrey.withOpacity(0.2),
                    ),
                  ),
                  titlesData: const FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: bottomTitleWidgetsLineChart,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: leftTitleWidgetsLineChart,
                        interval: 1,
                        reservedSize: 36,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    drawHorizontalLine: true,
                    getDrawingVerticalLine: (value) {
                      return FlLine(
                        color: Colors.blueGrey.withOpacity(0.5),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      left: BorderSide(color: Colors.blueGrey),
                      top: BorderSide(color: Colors.transparent),
                      bottom: BorderSide(color: Colors.blueGrey),
                      right: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
