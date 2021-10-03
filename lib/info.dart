import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hot_source_app/sizing.dart';
import 'package:localstorage/localstorage.dart';
import 'package:styled_widget/styled_widget.dart';

class InfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InfoState();
  }
}

class InfoState extends State<InfoPage> {
  String advice = "";
  double temp = 0;
  double hotWave = 0;
  late bool isShowingMainData;
  LocalStorage storage = LocalStorage('hot');

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    Sizing _size = Sizing(context: context);
    

    TextStyle numberStyle = TextStyle(
        fontFamily: 'Numbers',
        color: Colors.teal,
        fontSize: _size.height(percent: 5));
    TextStyle upperStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: _size.height(percent: 12));
    TextStyle numberTitleStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: _size.height(percent: 1.5));

    numbers({String mode = 'temperature', double value = 0}) {
      double titlePadding = _size.height(percent: 3);
      String _titleUpper = '';
      String _title = '';
      String _display = value.toStringAsFixed(1);
      if (mode == 'temperature') {
        titlePadding = _size.height(percent: 5.5);

        _titleUpper = 'T';
        _title = 'emperature';
        _display = '$_display°C';
      } else if (mode == 'heatwaveForecast') {
        titlePadding = _size.height(percent: 3.5);

        _titleUpper = 'H';
        _title = 'eatwave\nForecast';
        _display = '$_display %';
      }
      return Container(
        height: _size.height(percent: 15),
        width: _size.width(percent: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _titleUpper,
              style: upperStyle,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.only(top: titlePadding),
              child: Column(
                children: [
                  Text(
                    _title,
                    style: numberTitleStyle,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    _display,
                    style: numberStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return (Container(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              numbers(mode: 'temperature', value: 34),
              numbers(mode: 'heatwaveForecast', value: storage.getItem('percent'))
            ],
          ),
          Container(
            height: _size.height(percent: 37),
            width: _size.width(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  _size.width(percent: 1),
                  _size.height(percent: 2),
                  _size.height(percent: 2),
                  _size.width(percent: 2)),
              child: _LineChart(isShowingMainData: isShowingMainData),
            ),
          ),
          Container(
              padding: EdgeInsets.all(_size.width(percent: 2)),
              child: UserCard()),
        ],
      ),
    ));
  }
}

class UserCard extends StatelessWidget {
  Widget _buildUserRow() {
    return <Widget>[
      <Widget>[
        Text(
          'Suggestion',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 28,
          ),
        ).padding(bottom: 5),
      ].toColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max),
    ].toRow();
  }

  Widget _buildUserStats(Sizing size) {
    return <Widget>[
      LayoutBuilder(
        builder: (context, constraints) => Container(
          width: size.width(percent: 80),
          child: _buildUserStatsItem(
              'You should cool off immediately if you have the following symptoms: headaches, feeling dizzy, loss of appetite, nausea, excessive sweating, cramps, fast breathing and intense thirst.\nIf your body\'s temperature hits 40C (104F), heatstroke can set in, which requires urgent medical help. Danger signs include sweat stopping - the person may feel hot, but dry - and breathing difficulties.'),
        ),
      ),
    ]
        .toRow(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(vertical: 10);
  }

  Widget _buildUserStatsItem(String value) => <Widget>[
        Text(value).fontSize(20).textColor(Colors.blueGrey).padding(bottom: 5)
      ].toColumn();

  @override
  Widget build(BuildContext context) {
    return <Widget>[_buildUserRow(), _buildUserStats(Sizing(context: context))]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        )
        .padding(horizontal: 20, vertical: 10)
        .decorated(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(20))
        .elevation(
          5,
          shadowColor: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(20),
        )
        .alignment(Alignment.center);
  }
}

class _LineChart extends StatelessWidget {
   _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;
  LocalStorage storage = LocalStorage('hot');
  List<String> days =[];
  List<double> temps = [];

  @override
  Widget build(BuildContext context) {
    days = storage.getItem('days');
    temps = storage.getItem('temps');
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 1,
        maxX: 7,
        maxY: 50,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: bottomTitles,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        leftTitles: leftTitles(
          getTitles: (value) {
            switch (value.toInt()) {
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
              case 40:
                return '40';
              case 50:
                return '50';
            }
            return '';
          },
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
      ];

  SideTitles leftTitles({required GetTitleFunction getTitles}) => SideTitles(
        getTitles: getTitles,
        showTitles: true,
        margin: 8,
        interval: 1,
        reservedSize: 40,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff75729e),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      );

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 22,
        margin: 10,
        interval: 1,
        getTextStyles: (context, value) => const TextStyle(
          color: Color(0xff72719b),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 1:
              return days[days.length-1];
            case 2:
              return days[days.length-2];
            case 3:
              return days[days.length-3];
            case 4:
              return days[days.length-4];
            case 5:
              return days[days.length-5];
            case 6:
              return days[days.length-6];
            case 7:
              return days[days.length-7];
          }
          return '';
        },
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        colors: [const Color(0xff4af699)],
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          FlSpot(1, temps[temps.length-1]-273.15),
          FlSpot(2, temps[temps.length-2]-273.15),
          FlSpot(3, temps[temps.length-3]-273.15),
          FlSpot(4, temps[temps.length-4]-273.15),
          FlSpot(5, temps[temps.length-5]-273.15),
          FlSpot(6, temps[temps.length-6]-273.15),
          FlSpot(7, temps[temps.length-7]-273.15),
        ],
      );
}
