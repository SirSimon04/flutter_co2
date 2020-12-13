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

  Future<void> getData() async {
    var decodedData =
        await NetworkHelper('https://co2.uber.space/statusNow/T').getData();
    for (int i = 0; i < 3; i++) {
      print(decodedData[i]['co2']);
    }
    setState(() {
      co0 = decodedData[0]['co2'];
      co1 = decodedData[1]['co2'];
      co2 = decodedData[2]['co2'];
      co3 = decodedData[3]['co2'];
      co4 = decodedData[4]['co2'];

      id0 = decodedData[0]['ID'];
      id1 = decodedData[1]['ID'];
      id2 = decodedData[2]['ID'];
      id3 = decodedData[3]['ID'];
      id4 = decodedData[4]['ID'];
    });
  }

  List<LineSeries<ChartData, num>> getLineSeries() {
    final List<ChartData> chartData = <ChartData>[
      ChartData(id0, co0, kRedGew),
      ChartData(id1, co1, kRedGew),
      ChartData(id2, co2, kRedGew),
      ChartData(id3, co3, kRedGew),
      ChartData(id4, co4, kRedGew),
    ];
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
    // TODO: implement initState
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
                  color: kExpandedCardActiveColor,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[Text('CO2: 990ppm'), Text('Temp: 29°C')],
                  ),
                ),
              ),
              Expanded(
                child: ReusableCard(
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
