import 'package:covid_19_vaccine_korea/src/model/vaccine_center.dart';
import 'package:covid_19_vaccine_korea/src/service/api.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.map_outlined)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined))
                ],
              ),
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
                child: MaterialButton(onPressed: (){},
                  color: Theme.of(context).accentColor,
                  minWidth: double.infinity,
                  child: Center(child: Text("코로나19백신 및 예방접종", style: TextStyle(
                    fontSize: 16,
                    color: Colors.black
                  ),)),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
