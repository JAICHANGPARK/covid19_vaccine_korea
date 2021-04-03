import 'package:covid_19_vaccine_korea/src/db/db.dart';
import 'package:covid_19_vaccine_korea/src/model/vaccine_center.dart';
import 'package:covid_19_vaccine_korea/src/model/vaccine_count.dart';
import 'package:covid_19_vaccine_korea/src/service/api.dart';
import '../../../main.dart';
import 'maps/map_page.dart';
import 'package:covid_19_vaccine_korea/src/ui/screen/note/new_note_page.dart';
import 'package:covid_19_vaccine_korea/src/ui/widgets/note_record_widget.dart';
import 'package:covid_19_vaccine_korea/src/ui/widgets/qa_list_widget.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong/latlong.dart';

import 'web_view_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  VaccineCenter? _vaccineCenter;
  late TabController _tabController;
  VaccineCount? _vaccineCount;
  String? todayDateFormat;

  @override
  void initState() {
    super.initState();
    todayDateFormat = DateFormat("yyyy-MM-dd 00:00:00").format(DateTime.now());
    fetchVaccineCount(1, 100, todayDateFormat).then((value) {
      setState(() {
        _vaccineCount = value;
      });
    });
    _tabController = TabController(length: 4, vsync: this);
    fetchVaccineCountBySido(1, 100, "전국");
    // fetchVaccineCenter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "모두의 백신",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        if (_vaccineCenter != null) {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => MapPage(vaccineCenter: _vaccineCenter)));
                        } else {
                          showDialog(
                              builder: (context) => AlertDialog(
                                    title: Text("알림"),
                                    content: Text("예방접종 센터 탭을 선택하여 우선 확인해주세요."),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("확인"))
                                    ],
                                  ),
                              context: context);
                        }
                      },
                      icon: Icon(Icons.map_outlined)),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/setting");
                      },
                      icon: Icon(Icons.settings_outlined))
                ],
              ),
              TabBar(
                controller: _tabController,
                labelColor: Theme.of(context).accentColor,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: "예방접종 현황",
                  ),
                  Tab(
                    text: "예방접종 센터",
                  ),
                  Tab(
                    text: "기록 및 일지",
                  ),
                  Tab(
                    text: "Q&A",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${todayDateFormat?.split(" ").first} 기준",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              child: _vaccineCount != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 4,
                                              mainAxisSpacing: 4,
                                              childAspectRatio: 0.8),
                                          itemCount: _vaccineCount?.data?.length,
                                          itemBuilder: (context, index) {
                                            Data? d = _vaccineCount?.data?[index];
                                            return Card(
                                              elevation: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "${d?.sido}",
                                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                    ),
                                                    Divider(),
                                                    Text(
                                                      "1회차 전일누적: ${d?.accumulatedFirstCnt} 명",
                                                      style: TextStyle(fontSize: 12),
                                                    ),
                                                    Text(
                                                      "1회차 전일실적: ${d?.firstCnt} 명",
                                                      style: TextStyle(fontSize: 12),
                                                    ),
                                                    Text(
                                                      "1회차 당일누적: ${d?.totalFirstCnt}명",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.blue),
                                                    ),
                                                    Divider(),
                                                    Text(
                                                      "2회차 전일누적: ${d?.accumulatedSecondCnt} 명",
                                                      style: TextStyle(fontSize: 12),
                                                    ),
                                                    Text(
                                                      "2회차 전일실적: ${d?.secondCnt} 명",
                                                      style: TextStyle(fontSize: 12),
                                                    ),
                                                    Text(
                                                      "2회차 당일누적: ${d?.totalSecondCnt}명",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.green),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    )
                                  : Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("정보 불러오는중"),
                                          )
                                        ],
                                      ),
                                    )),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "코로나19 예방접종센터",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder<VaccineCenter?>(
                          future: fetchVaccineCenter(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              VaccineCenter? vaccineCenter = snapshot.data;
                              _vaccineCenter = vaccineCenter;
                              if (vaccineCenter == null) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("문제가 발생했습니다."),
                                      // CircularProgressIndicator(),
                                    ],
                                  ),
                                );
                              }

                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    child: Card(
                                      elevation: 2,
                                      child: InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              isScrollControlled: true,
                                              enableDrag: false,
                                              context: context,
                                              backgroundColor: Colors.transparent,
                                              builder: (context) {
                                                double _lat = double.parse(vaccineCenter.data![index].lat!);
                                                double _lng = double.parse(vaccineCenter.data![index].lng!);
                                                Fimber.d("$_lat / $_lng");
                                                return Container(
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context).cardColor,
                                                      borderRadius: BorderRadius.circular(24)),
                                                  height: MediaQuery.of(context).size.height / 1.3,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        // Container(
                                                        //   height: 4,
                                                        //   width: 32,
                                                        //   decoration: BoxDecoration(
                                                        //     color: Colors.grey,
                                                        //     borderRadius: BorderRadius.circular(16),
                                                        //   ),
                                                        // ),
                                                        Align(
                                                            alignment: Alignment.centerRight,
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                                icon: Icon(Icons.clear))),

                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 16),
                                                          child: Text(
                                                            "${vaccineCenter.data?[index].org != "" ? "${vaccineCenter.data?[index].org}" : "정보 없음"}",
                                                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets.symmetric(horizontal: 16),
                                                          height: MediaQuery.of(context).size.height / 3,
                                                          width: double.infinity,
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey,
                                                              borderRadius: BorderRadius.circular(16)),
                                                          child: FlutterMap(
                                                            options: MapOptions(
                                                                center: LatLng(_lng, _lat), zoom: 15.0, maxZoom: 18.0),
                                                            layers: [
                                                              TileLayerOptions(
                                                                  urlTemplate:
                                                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                                                  subdomains: ['a', 'b', 'c']),
                                                              MarkerLayerOptions(
                                                                markers: [
                                                                  Marker(
                                                                    point: LatLng(_lng, _lat),
                                                                    builder: (ctx) => Container(
                                                                      child: Icon(
                                                                        Icons.location_pin,
                                                                        size: 32,
                                                                        color: Colors.green,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: double.infinity,
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(12.0),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  "정보",
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.bold, fontSize: 12),
                                                                ),
                                                                Text(
                                                                  "센터명: ${vaccineCenter.data?[index].centerName}",
                                                                  style: TextStyle(),
                                                                ),
                                                                Text(
                                                                  "시설명: ${vaccineCenter.data?[index].facilityName}",
                                                                  style: TextStyle(),
                                                                ),
                                                                Text("주소: ${vaccineCenter.data?[index].address}"),
                                                                Text("우편번호: ${vaccineCenter.data?[index].zipCode}"),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "${vaccineCenter.data?[index].org != "" ? "${vaccineCenter.data?[index].org}" : "정보 없음"}",
                                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                  ),
                                                  Spacer(),
                                                  Text("${vaccineCenter.data?[index].sido}")
                                                ],
                                              ),
                                              Text("${vaccineCenter.data?[index].centerName}"),
                                              Text("${vaccineCenter.data?[index].facilityName}"),
                                              Text("${vaccineCenter.data?[index].address}"),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: vaccineCenter.data?.length,
                              );
                            }
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("불러오는중"),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WebViewPage("https://ncv.kdca.go.kr/", "코로나19백신 및 예방접종")));
                          },
                          color: Theme.of(context).accentColor,
                          minWidth: double.infinity,
                          child: Center(
                              child: Text(
                            "코로나19백신 및 예방접종",
                            style: TextStyle(
                                fontSize: 16,
                                color: MediaQuery.of(context).platformBrightness == Brightness.dark
                                    ? Colors.black
                                    : Colors.white),
                          )),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Positioned(
                        child: NoteRecordWidget(),
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: 0,
                      ),
                      Positioned(
                        bottom: 16,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Fimber.d(">>> Touch Add Button");
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewNotePage()));
                            },
                            child: PhysicalModel(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              elevation: 5,
                              child: Container(
                                height: 84,
                                width: 84,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 58,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  QAListWidget(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
