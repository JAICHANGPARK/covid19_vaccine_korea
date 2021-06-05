import 'package:covid_19_vaccine_korea/src/ui/screen/web_view_page.dart';
import 'package:flutter/material.dart';

class QAListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                builder: (context) => WebViewPage("https://ncv.kdca.go.kr/menu.es?mid=a10118010000", "안전한가요?")));
          },
        ),
        Divider(
          height: 4,
        ),
        ListTile(
          title: Text("우리나라에는 어떤 백신이 들어오나요?"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WebViewPage("https://ncv.kdca.go.kr/menu.es?mid=a10119000000", "어떤 백신이 들어오나요?")));
          },
        ),
        Divider(
          height: 4,
        ),
        ListTile(
          title: Text("Q&A 모음"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WebViewPage("https://ncv.kdca.go.kr/menu.es?mid=a12205000000", "Q&A모음")));
          },
        ),
        Divider(
          height: 4,
          color: Colors.black,
          thickness: 1,
        ),
        ListTile(
          title: Text("백신, 치료제 정보"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WebViewPage("https://www.mfds.go.kr/vaccine_covid19.jsp#", "백신, 치료제 정보")));
          },
        ),
        Divider(height: 4),
        ListTile(
          title: Text("예방접종 후 건강상태 확인"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WebViewPage("https://nip.kdca.go.kr/irgd/covid.do?MnLv1=3", "예방접종 후 건강상태 확인")));
          },
        ),
        Divider(
          height: 4,
          color: Colors.black,
          thickness: 1,
        ),
        ListTile(
          title: Text("잔여백신 당일예약 기능 Q&A"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebViewPage("http://kdca.go.kr/gallery.es?mid=a20503010000&bid=0002&b_list=9&act=view&list_no=145144&nPage=1&vlist_no_npage=1&keyField=&keyWord=&orderby=", "잔여백신 당일예약 기능 Q&A")));
          },
        ),
        Divider(height: 4),

        ListTile(
          title: Text("코로나19 예방접종 온라인 예약"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebViewPage("http://kdca.go.kr/gallery.es?mid=a20503010000&bid=0002&b_list=9&act=view&list_no=145131&nPage=1&vlist_no_npage=2&keyField=&keyWord=&orderby=", "코로나19 예방접종 온라인 예약")));
          },
        ),
        Divider(height: 4),

        Divider(
          height: 4,
          color: Colors.black,
          thickness: 1,
        ),

        ListTile(
          title: Text("국내 이상반응발생동향"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebViewPage("https://ncv.kdca.go.kr/board.es?mid=a11707010000&bid=0032", "국내 이상반응발생동향")));
          },
        ),
      ],
    );
  }
}
