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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "모두의 백신",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined))
                ],
              ),
              Text("코로나19 예방접종센터",style: TextStyle(),),
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
                          return Card(
                            child: Column(),
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
            ],
          ),
        ),
      ),
    );
  }
}
