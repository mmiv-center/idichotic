// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:dichotic/data/exampledata.dart';
import 'package:dichotic/data/types.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ResultsChartLCons extends StatelessWidget{
  final List<Data> data;

  ResultsChartLCons(@required this.data);


  @override
  Widget build(BuildContext context) {
    int refactor = 0;
    
    var relevantData = data.where((element) => element.id != Types.homonymCorrect && element.id != Types.homonymIncorrect).toList();
    data.forEach((element) {refactor+=element.amount;});

    var rightCorrect = data.where((element) => element.id == Types.rightCorrect).toList();
    var leftCorrect = data.where((element) => element.id == Types.leftCorrect).toList();
    var leftIncorrect = data.where((element) => element.id == Types.leftIncorrect).toList();
    var rightIncorrect = data.where((element) => element.id == Types.rightIncorrect).toList();



    List<charts.Series<Data, String>> _dataLeft() {
      
      return [
      charts.Series<Data, String>(
          id: "Results",
          data: leftCorrect,
          domainFn: (Data result, _) => "Data",
          measureFn: (Data result, _) => (result.amount * 100) / refactor,
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          //colorFn: (ExampleData result, _) => result.barColor
      ),

    charts.Series<Data, String>(
          id: "Results",
          data: leftIncorrect,
          domainFn: (Data result, _) => "Data",
          measureFn: (Data result, _) => (result.amount * 100) / refactor,
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          //colorFn: (ExampleData result, _) => result.barColor
      )
      ];}

    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      height: 100,
      //padding: EdgeInsets.all(20),
        child: 
          Padding(
          padding: const EdgeInsets.all(9.0),
          child: 
           charts.BarChart(_dataLeft(),
            animate: false,
            vertical: false,
            primaryMeasureAxis: new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
            domainAxis: const charts.OrdinalAxisSpec(
            showAxisLine: false,
            renderSpec: charts.NoneRenderSpec()),
            defaultRenderer: charts.BarRendererConfig(
              groupingType: charts.BarGroupingType.stacked,
              maxBarWidthPx: 40,)
          )),
      );
  }
}