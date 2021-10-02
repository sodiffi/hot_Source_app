import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hot_source_app/sizing.dart';
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
              numbers(mode: 'temperature', value: 85.555),
              numbers(mode: 'heatwaveForecast', value: 50)
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
          '建議',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ).padding(bottom: 5),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    ].toRow();
  }

  Widget _buildUserStats() {
    return <Widget>[
      _buildUserStatsItem('建議文字'),
    ]
        .toRow(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(vertical: 10);
  }

  Widget _buildUserStatsItem(String value) => <Widget>[
        Text(value).fontSize(20).textColor(Colors.white).padding(bottom: 5)
      ].toColumn();

  @override
  Widget build(BuildContext context) {
    return <Widget>[_buildUserRow(), _buildUserStats()]
        .toColumn(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(horizontal: 20, vertical: 10)
        .decorated(
            color: Color(0xff3977ff), borderRadius: BorderRadius.circular(20))
        .elevation(
          5,
          shadowColor: Color(0xff3977ff),
          borderRadius: BorderRadius.circular(20),
        )
        .height(175)
        .alignment(Alignment.center);
  }
}

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
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
        minX: 0,
        maxX: 14,
        maxY: 4,
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
              case 1:
                return '1m';
              case 2:
                return '2m';
              case 3:
                return '3m';
              case 4:
                return '5m';
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
            case 2:
              return 'SEPT';
            case 7:
              return 'OCT';
            case 12:
              return 'DEC';
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
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );
}
