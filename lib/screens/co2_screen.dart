import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_co2/services/networking.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_co2/components/constants.dart';
import 'package:flutter_co2/components/reusable_card.dart';
import 'dart:developer';
import 'choose_room.dart';
import 'package:community_material_icon/community_material_icon.dart';

class Co2Screen extends StatefulWidget {
  Co2Screen({Key key}) : super(key: key);
  @override
  Co2ScreenState createState() => Co2ScreenState();
}

class Co2ScreenState extends State<Co2Screen> {
  double tCo2 = 0;
  double tTemp = 0;
  double tScore = 0;
  double tH2o = 0;

  String selectedRoom = 'A100';

  List<ChartData> chartData = [];

  Future<void> getData(String room) async {
    log("get data called");
    var decodedData =
        await NetworkHelper('https://co2.uber.space/app/statusNow/$room')
            .getData();
    setState(() {
      if (decodedData.length != 0) {
        for (var item in decodedData) {
          chartData.insert(0, ChartData(item["ID"], item['co2'], kRedGew));
        }
        if (decodedData[0]['Temp'] != null) {
          tTemp = decodedData[0]['Temp'];
        }
        if (decodedData[0]['co2'] != null) {
          tCo2 = decodedData[0]['co2'];
        }
        if (decodedData[0]['score'] != null) {
          tScore = decodedData[0]['score'];
        }
        if (decodedData[0]['h2o'] != null) {
          tH2o = decodedData[0]['h2o'];
        }
      }
    });
  }

  List<SplineSeries<ChartData, num>> getLineSeries() {
    return <SplineSeries<ChartData, num>>[
      SplineSeries(
        splineType: SplineType.natural,
        animationDuration: 2500,
        dataSource: chartData,
        pointColorMapper: (ChartData chart, _) => chart.segmentColor,
        xValueMapper: (ChartData chart, _) => chart.x,
        yValueMapper: (ChartData chart, _) => chart.y,
        width: 2,
        name: 'Messwert',
        markerSettings: MarkerSettings(isVisible: false),
      ),
    ];
  }

  @override
  void initState() {
    log("init state called");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kRedGew,
        title: Text('CO2-School'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.business,
              color: Colors.white,
            ),
            onPressed: () {
              //TODO Implementation of reload
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return RoomPickerWidget();
                }),
              );
            },
          ),
          IconButton(
              icon: Icon(
                CommunityMaterialIcons.reload,
                color: Colors.white,
              ),
              onPressed: () {
                getData(selectedRoom);
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: ReusableCard(
              edgeInsets: EdgeInsets.fromLTRB(
                  edgeInsetBig, edgeInsetBig, edgeInsetBig, edgeInsetSmall),
              color: kExpandedCardActiveColor,
              cardChild: SfCartesianChart(
                plotAreaBorderWidth: 0,
                title: ChartTitle(text: 'CO2-Messwerteee!'),
                primaryXAxis: CategoryAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  interval: 5,
                  majorGridLines: MajorGridLines(width: 0),
                  labelRotation: 60,
                ),
                primaryYAxis: NumericAxis(
                  labelFormat: '{value}',
                  axisLine: AxisLine(width: 0),
                  majorTickLines: MajorTickLines(color: Colors.transparent),
                ),
                series: getLineSeries(),
                tooltipBehavior:
                    TooltipBehavior(enable: true, canShowMarker: false),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReusableCard(
                    edgeInsets: EdgeInsets.fromLTRB(edgeInsetBig,
                        edgeInsetSmall, edgeInsetSmall, edgeInsetSmall),
                    color: kExpandedCardActiveColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('CO2: ${tCo2 /*.toStringAsFixed(0)*/}ppm'),
                        Text('Temp: $tTemp°C')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    edgeInsets: EdgeInsets.fromLTRB(edgeInsetSmall,
                        edgeInsetSmall, edgeInsetBig, edgeInsetSmall),
                    color: kExpandedCardActiveColor,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Feuchtigkeit: $tH2o g/m3'),
                        Text('Lautstärke: 80 dB')
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: ReusableCard(
                  edgeInsets: EdgeInsets.fromLTRB(
                      edgeInsetBig, edgeInsetSmall, edgeInsetBig, edgeInsetBig),
                  color: kExpandedCardActiveColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('Gesamtscore der Werte'),
                      Text(
                        '${tScore /*.toStringAsFixed(0)*/}/100',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.segmentColor);
  final int x;
  final double y;
  final Color segmentColor;
}
