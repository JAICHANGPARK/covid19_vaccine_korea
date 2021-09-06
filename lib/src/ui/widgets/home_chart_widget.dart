import 'package:covid_19_vaccine_korea/src/service/api.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeChartWidget extends StatefulWidget {
  HomeChartWidget({Key? key}) : super(key: key);

  @override
  _HomeChartWidgetState createState() => _HomeChartWidgetState();
}

class _HomeChartWidgetState extends State<HomeChartWidget> {
  bool? animate;
  List<FlSpot> firstData = [];
  List<FlSpot> secondData = [];

  final List<Color> gradientColors = [
    Colors.blue,
    Colors.blue[400]!,
    Colors.blue[300]!,
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  final List<Color> gradientColors2 = [
    const Color(0xff02d39a),
    Colors.green,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchVaccineCountBySido(1, 100, "전국").then((value) {
      var items = value?.data;
      if (items!.length > 0) {
        for (int i = 0; i < items.length; i++) {
          firstData.add(FlSpot(i.toDouble(), items[i].firstCnt!.toDouble()));
          secondData.add(FlSpot(i.toDouble(), items[i].secondCnt!.toDouble()));
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return firstData.length > 0
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 1000000,
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => const TextStyle(
                      color: Color(0xff68737d),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    getTitles: (value) {
                      return value.toStringAsFixed(0);
                    },
                    reservedSize: 0,
                    margin: 8,
                  ),
                  rightTitles: SideTitles(
                    showTitles: false,
                  ),
                  topTitles: SideTitles(
                    showTitles: false,
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => const TextStyle(
                      color: Color(0xff67727d),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                    interval: 250000,
                    // getTitles: (value) {
                    //   // print(value);
                    //   switch (value.toInt()) {
                    //     case 10000:
                    //       return '10k';
                    //     case 30000:
                    //       return '30k';
                    //     case 50000:
                    //       return '50k';
                    //     case 100000:
                    //       return '100k';
                    //     case 250000:
                    //       return '250k';
                    //     case 500000:
                    //       return '500k';
                    //     case 1000000:
                    //       return '1000k';
                    //   }
                    //   return '';
                    // },
                    reservedSize: 16,
                    margin: 8,
                  ),
                ),
                // titlesData: LineTitles.getTitleData(),
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      // color: const Color(0xff37434d),
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                  drawVerticalLine: true,
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      // color: const Color(0xff37434d),
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(
                  show: true,
                  // border: Border.all(color: const Color(0xff37434d), width: 1),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: firstData,
                    isCurved: true,
                    colors: gradientColors,
                    barWidth: 1.5,
                    dotData: FlDotData(
                      show: false,
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
                    ),
                  ),
                  LineChartBarData(
                    spots: secondData,
                    isCurved: true,
                    colors: gradientColors2,
                    barWidth: 1.5,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      colors: gradientColors2.map((color) => color.withOpacity(0.3)).toList(),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [CircularProgressIndicator(), Text("데이터 가져오는 중")],
            ),
          );
  }
}

class LineTitles {
  static getTitleData() => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 35,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 35,
          margin: 12,
        ),
      );
}
