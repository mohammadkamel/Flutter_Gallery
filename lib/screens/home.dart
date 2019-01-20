import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title; // title tabBar

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

// لازم لعمل هذا البرنامج التسجيل في موقع 
// https://pixabay.com
// بعد التسجيل التوجه الى الرابط التالي https://pixabay.com/api/docs/ قم بأخذ المفتاح من نوع keys سوف تشاهده داخل الصفحة ملون بالون الأخظر انسخة وضعه

const keys = "#ضع المفتاح هنا";//;
const basdURL = "https://pixabay.com/api/?key=$keys&q=yellow+flowers&image_type=photo";

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  var _list = [];

  _fetchData() async {
    var url = basdURL;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print("fetch data is success");
      final map = json.decode(response.body);
      final images = map["hits"];
      _list = images;
      // previewURL
      // webformatURL
      // tags
      // views
      // comments
      // downloads
      setState(() {
         _list = images;
         
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _fetchData();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _list != null ? _list.length : 0,
          itemBuilder: (context, count) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        child:FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image: _list[count]["webformatURL"]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      Padding(
                        child:Text(
                                "Tags: " +
                                _list[count]["tags"].toString()),
                        padding: const EdgeInsets.fromLTRB(10.0, 12.0, 12.0, 0), 
                      ),
                      Padding(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                                "Views: " +
                                _list[count]["views"].toString()),
                            Text(
                                "Comments: " +
                                _list[count]["comments"].toString()),
                            Text(
                                "Downloads: " +
                                _list[count]["downloads"].toString()),
                          ],
                        ) ,
                        padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 10), 
                      ),
                      Divider(height: 1,),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
