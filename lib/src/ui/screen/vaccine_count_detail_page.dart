import 'package:covid_19_vaccine_korea/src/service/api.dart';
import 'package:flutter/material.dart';

class VaccineCountDetailPage extends StatefulWidget {
  final String sidoName;


  VaccineCountDetailPage({required this.sidoName});

  @override
  _VaccineCountDetailPageState createState() => _VaccineCountDetailPageState();
}

class _VaccineCountDetailPageState extends State<VaccineCountDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchVaccineCountBySido(1, 100, widget.sidoName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
