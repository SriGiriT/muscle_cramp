import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:muscle_cramp/constant.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../components/reusable_card.dart';
import 'package:http/http.dart' as http;

class ReadingScreen extends StatefulWidget {
  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  List<double> list_data = [1, 25, 50, 75, 100];
  double EMG = 650;
  String error = "";
  double sodium = 138;
  double calcium = 2.4;
  double potassium = 4.2;
  double oxygen = 95;
  double glucose = 5.9;
  double magnessium = 1.01;
  TextEditingController _textEditingController = TextEditingController();
  String _value = kURL;
  var data;
  @override
  void initState() {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      fetchData();
    });
    super.initState();
  }

  Future<void> _showEditDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter new value'),
          content: TextField(
            controller: _textEditingController,
            keyboardType: TextInputType.text,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  _value = _textEditingController.text;
                  kURL = _value;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void fetchData() async {
    final response = await http.get(Uri.parse('http://${kURL}/'));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        EMG = double.parse(data['data']);
        if (list_data.length > 500) list_data = [];
        list_data.add(EMG);
        sodium = double.parse(data['data1']);
        calcium = double.parse(data['data2']);
        potassium = double.parse(data['data3']);
        oxygen = double.parse(data['data4']);
        glucose = double.parse(data['data5']);
        magnessium = double.parse(data['data1']);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF818CF8),
        title: Text('Muscle Cramp'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditDialog(context);
            },
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'EMG Reading'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<double, String>>[
                    LineSeries<double, String>(
                        dataSource: list_data,
                        xValueMapper: (double sales, _) => _.toString(),
                        yValueMapper: (double sales, _) => sales,
                        name: 'EMG',
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ]),
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    onPress: () {},
                    colour: Colors.white,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Detected Values",
                          style: kNumberTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "EMG : ",
                              style: kNumberTextStyle,
                            ),
                            Text(
                              EMG.toString(),
                              style: kNumberTextStyle,
                            ),
                            Text(
                              "  µV",
                              style: kLabelTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Sodium : ",
                              style: kNumberTextStyle,
                            ),
                            Text(
                              sodium.toString(),
                              style: kNumberTextStyle,
                            ),
                            Text(
                              "  mmol/L",
                              style: kLabelTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Calcium : ",
                              style: kNumberTextStyle,
                            ),
                            Text(
                              calcium.toString(),
                              style: kNumberTextStyle,
                            ),
                            Text(
                              "  mmol/L",
                              style: kLabelTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "potassium : ",
                              style: kNumberTextStyle,
                            ),
                            Text(
                              potassium.toString(),
                              style: kNumberTextStyle,
                            ),
                            Text(
                              "  mmol/L",
                              style: kLabelTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Oxygen : ",
                              style: kNumberTextStyle,
                            ),
                            Text(
                              oxygen.toString(),
                              style: kNumberTextStyle,
                            ),
                            Text(
                              "  %",
                              style: kLabelTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Glucose : ",
                              style: kNumberTextStyle,
                            ),
                            Text(
                              glucose.toString(),
                              style: kNumberTextStyle,
                            ),
                            Text(
                              "  mmol/L",
                              style: kLabelTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Magnessium : ",
                              style: kNumberTextStyle,
                            ),
                            Text(
                              magnessium.toString(),
                              style: kNumberTextStyle,
                            ),
                            Text(
                              "  mmol/L",
                              style: kLabelTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
