import 'package:covid_19_vaccine_korea/src/model/vaccine_count.dart';
import 'package:covid_19_vaccine_korea/src/service/api.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class DetailChartWidget extends StatefulWidget {
  final VaccineCount? vaccineCount;
  DetailChartWidget({Key? key, this.vaccineCount}) : super(key: key);

  @override
  _DetailChartWidgetState createState() => _DetailChartWidgetState();
}

class _DetailChartWidgetState extends State<DetailChartWidget> {
  bool? animate;
  List<FlSpot> firstData = [];
  List<FlSpot> secondData = [];

  /// Create one series with sample hard coded data.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.vaccineCount != null){
      if(widget.vaccineCount!.data!.length > 0){
        for(int i = 0; i < widget.vaccineCount!.data!.length ; i++){
          firstData.add(FlSpot(i.toDouble(), widget.vaccineCount!.data![i].firstCnt!.toDouble()));
          secondData.add(FlSpot(i.toDouble(), widget.vaccineCount!.data![i].secondCnt!.toDouble()));
        }
      }
    }
  }

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
  Widget build(BuildContext context) {
    return  firstData.length > 0 ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: LineChart(

        LineChartData(
          minY: 0,

          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,

              getTextStyles: (value) => const TextStyle(
                color: Color(0xff68737d),
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
              getTitles: (value) {
                // print(value);
                return value.toStringAsFixed(0);
              },
              reservedSize: 0,
              margin: 8,
            ),
            leftTitles: SideTitles(
              showTitles: true,
              getTextStyles: (value) => const TextStyle(
                color: Color(0xff67727d),
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
              getTitles: (value) {
                // print(value);
                switch (value.toInt()) {
                  case 10000:
                    return '10k';
                  case 30000:
                    return '30k';
                  case 50000:
                    return '50k';
                }
                return '';
              },
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
              dotData: FlDotData(show: false,),
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
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
                colors: gradientColors2
                    .map((color) => color.withOpacity(0.3))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    ) : Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text("데이터 가져오는 중")
        ],
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
      getTextStyles: (value) => const TextStyle(
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
      getTextStyles: (value) => const TextStyle(
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