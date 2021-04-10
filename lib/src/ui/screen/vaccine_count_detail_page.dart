import 'package:covid_19_vaccine_korea/src/model/vaccine_count.dart';
import 'package:covid_19_vaccine_korea/src/service/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VaccineCountDetailPage extends StatefulWidget {
  final String sidoName;

  VaccineCountDetailPage({required this.sidoName});

  @override
  _VaccineCountDetailPageState createState() => _VaccineCountDetailPageState();
}

class _VaccineCountDetailPageState extends State<VaccineCountDetailPage> {

  final formatCurrency = NumberFormat.simpleCurrency(locale: "ko_KR", name: "", decimalDigits: 0);

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
                        child: Padding(
                          padding: const EdgeInsets.only(top: 64),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(child: Text("날짜")),
                                    Expanded(child: Text("1차접종")),
                                    Expanded(child: Text("2차접종")),
                                  ],
                                ),
                              ),
                              Divider(color: Colors.grey,),
                              Row(
                                children: [
                                  Expanded(child: Text("")),
                                  Expanded(child: Text("당일실적")),
                                  Expanded(child: Text("당일누적")),
                                  Expanded(child: Text("당일실적")),
                                  Expanded(child: Text("당일누적")),
                                ],
                              ),
                              Expanded(
                                child: FutureBuilder<VaccineCount?>(
                                  future:fetchVaccineCountBySido(1, 100, widget.sidoName),
                                  builder: (context, snapshot){
                                    if(snapshot.hasData){
                                      if(snapshot.data?.data?.length == 0) return Text("데이터 없음");
                                      if(snapshot.data != null){
                                        List<Data?> result = snapshot.data!.data!;
                                        result = result.reversed.toList();
                                        return ListView.separated(itemBuilder: (context, index){
                                          Data? d = result[index];

                                          return  Row(
                                            children: [
                                              Expanded(child: Text("${d?.baseDate?.split(" ").first}")),
                                              Expanded(child: Text("${formatCurrency.format(d?.firstCnt)} 명")),
                                              Expanded(child: Text("${formatCurrency.format(d?.totalFirstCnt)} 명")),
                                              Expanded(child: Text("${formatCurrency.format(d?.secondCnt)} 명")),
                                              Expanded(child: Text("${formatCurrency.format(d?.totalSecondCnt)} 명")),
                                            ],
                                          );
                                        },
                                        itemCount: result.length,
                                          separatorBuilder: (context, index){
                                          return Divider(color: Colors.grey,);
                                          },
                                        );
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
                              ),
                            ],
                          ),
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
