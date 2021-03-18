import 'package:covid_19_vaccine_korea/src/ui/screen/web_view_page.dart';
import 'package:flutter/material.dart';

class QAListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: [
        ListTile(
          title: Text("예방접종 왜 해야 하나요?"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebViewPage("https://ncv.kdca.go.kr/menu.es?mid=a10116010000", "예방접종 왜 해야 하나요?")));
          },
        ),
        Divider(
          height: 4,
        ),
        ListTile(
          title: Text("언제 어디서 할 수 있나요?"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebViewPage("https://ncv.kdca.go.kr/menu.es?mid=a10117010000", "언제 어디서 할 수 있나요?")));
          },
        ),
        Divider(
          height: 4,
        ),
        ListTile(
          title: Text("안전한가요?"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebViewPage("https://ncv.kdca.go.kr/menu.es?mid=a10118010000", "안전한가요?")));
          },
        ),
        Divider(
          height: 4,
        ),
        ListTile(
          title: Text("우리나라에는 어떤 백신이 들어오나요?"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebViewPage("https://ncv.kdca.go.kr/menu.es?mid=a10119000000", "어떤 백신이 들어오나요?")));
          },
        ),
        Divider(
          height: 4,
        ),
        ListTile(
          title: Text("Q&A 모음"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebViewPage("https://ncv.kdca.go.kr/menu.es?mid=a12205000000", "Q&A모음")));
          },
        ),
      ],
    );
  }
}
