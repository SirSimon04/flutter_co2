import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'networking.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'constants.dart';
import 'reusable_card.dart';

class Co2Screen extends StatefulWidget {
  @override
  _Co2ScreenState createState() => _Co2ScreenState();
}

class _Co2ScreenState extends State<Co2Screen> {
  String tCo2 = '?';
  String tTemp = '?';
  String tScore = '?';

  double co0 = 0;
  double co1 = 0;
  double co2 = 0;
  double co3 = 0;
  double co4 = 0;

  int id0 = 0;
  int id1 = 0;
  int id2 = 0;
  int id3 = 0;
  int id4 = 0;

  List<ChartData> chartData = [];

  Future<void> getData() async {
    var decodedData =
        await NetworkHelper('https://co2.uber.space/statusNow/T').getData();
    print(decodedData);
    for (var item in decodedData) {
      print(item['ID']);
      setState(() {
        chartData.add(ChartData(item['ID'], item['co2'], kRedGew));
      });
      print(chartData);
    }
    for (int i = 0; i < 3; i++) {
      print(decodedData[i]['co2']);
    }
  }

  List<LineSeries<ChartData, num>> getLineSeries() {
    return <LineSeries<ChartData, num>>[
      LineSeries(
        animationDuration: 2500,
        dataSource: chartData,
        pointColorMapper: (ChartData chart, _) => chart.segmentColor,
        xValueMapper: (ChartData chart, _) => chart.x,
        yValueMapper: (ChartData chart, _) => chart.y,
        width: 2,
        name: 'Messwert',
        markerSettings: MarkerSettings(isVisible: true),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: ReusableCard(
            edgeInsets: EdgeInsets.fromLTRB(
                edgeInsetBig, edgeInsetBig, edgeInsetBig, edgeInsetSmall),
            color: kExpandedCardActiveColor,
            cardChild: SfCartesianChart(
              plotAreaBorderWidth: 0,
              title: ChartTitle(text: 'CO2-Messwerte'),
              primaryXAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                interval: 1,
                majorGridLines: MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                labelFormat: '{value}',
                axisLine: AxisLine(width: 0),
                majorTickLines: MajorTickLines(color: Colors.transparent),
              ),
              series: getLineSeries(),
              tooltipBehavior: TooltipBehavior(enable: true),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  edgeInsets: EdgeInsets.fromLTRB(edgeInsetBig, edgeInsetSmall,
                      edgeInsetSmall, edgeInsetSmall),
                  color: kExpandedCardActiveColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[Text('CO2: 990ppm'), Text('Temp: 29°C')],
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
                      Text('Feuchtigkeit: 30 g/m3'),
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
                      '72/100',
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
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.segmentColor);
  final int x;
  final double y;
  final Color segmentColor;
}
