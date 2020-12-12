import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'networking.dart';

class Co2Screen extends StatefulWidget {
  @override
  _Co2ScreenState createState() => _Co2ScreenState();
}

class _Co2ScreenState extends State<Co2Screen> {
  String tCo2 = '0';
  String tTemp = '0';
  String tScore = '0';

  Future<void> updateUI() async {
    var decodedData =
        await NetworkHelper('https://co2.uber.space/statusNow/A100').getData();
    double co2 = decodedData[0]['co2'];
    double temp = decodedData[0]['Temp'];
    double score = decodedData[0]['score'];
    print(co2);
    setState(() {
      tCo2 = co2.toString();
      tTemp = temp.toString();
      tScore = score.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(tCo2)),
          Center(child: Text(tTemp)),
          Center(child: Text(tScore)),
        ],
      ),
    );
  }
}
