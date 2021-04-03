import 'package:covid_19_vaccine_korea/src/service/api.dart';
import 'package:flutter/material.dart';

class HomeChartWidget extends StatefulWidget {
  HomeChartWidget({Key? key}) : super(key: key);

  @override
  _HomeChartWidgetState createState() => _HomeChartWidgetState();
}

class _HomeChartWidgetState extends State<HomeChartWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchVaccineCountBySido(1, 100, "전국");
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}