import 'package:covid_19_vaccine_korea/src/model/vaccine_count.dart';
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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back)),
                    Text(
                      "${widget.sidoName} 상세 정보",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                )),
            Expanded(
                flex: 20,
                child: Stack(
                  children: [

                    Positioned(
                      child: SizedBox(child: Card(
                        child: FutureBuilder<VaccineCount?>(
                          future:fetchVaccineCountBySido(1, 100, widget.sidoName),
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              if(snapshot.data?.data?.length == 0) return Text("데이터 없음");
                              if(snapshot.data != null){
                                
                              }
                            }
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  Text("불러오는 중")
                                ],
                              ),
                            );
                          },
                        ),

                      )),
                      left: 0,
                      right: 0,
                      top: 170,
                      bottom: 0,
                    ),
                    Positioned(
                      child: SizedBox(height: 240, child: Card(
                        elevation: 4,

                      )),
                      left: 16,
                      right: 16,
                      top: 0,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
