// SPDX-FileCopyrightText: 2022 iDichotic+ Authors <https://dichotic.app>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dichotic/data/exampledata.dart';
import 'package:dichotic/data/types.dart';
import 'package:flutter/material.dart';

class ResultsChart extends StatelessWidget{
  final List<Data> data;

  ResultsChart(@required this.data);


  @override
  Widget build(BuildContext context) {
    int refactor = 0;
    
    var relevantData = data.where((element) => element.id != Types.homonymCorrect && element.id != Types.homonymIncorrect).toList();
    data.forEach((element) {refactor+=element.amount;});

    var rightCorrect = data.where((element) => element.id == Types.rightCorrect).toList();
    var leftCorrect = data.where((element) => element.id == Types.leftCorrect).toList();
    var error = data.where((element) => element.id == Types.incorrect).toList();


    List<charts.Series<Data, String>> _createSampleData() {

    return [
      charts.Series<Data, String>(
          id: "Results",
          data: leftCorrect,
          domainFn: (Data result, _) => "Data",
          measureFn: (Data result, _) => (result.amount * 100) / refactor,
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault
          //colorFn: (ExampleData result, _) => result.barColor
      ),

    charts.Series<Data, String>(
          id: "Results",
          data: error,
          domainFn: (Data result, _) => "Data",
          measureFn: (Data result, _) => (result.amount * 100) / refactor,
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault
          //colorFn: (ExampleData result, _) => result.barColor
      ),
      
      charts.Series<Data, String>(
          id: "Results",
          data: rightCorrect,
          domainFn: (Data result, _) => "Data",
          measureFn: (Data result, _) => (result.amount * 100) / refactor,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          displayName: " ",
          //colorFn: (ExampleData result, _) => result.barColor
      ),
      
      ];}


    return Container(
      //decoration: BoxDecoration(color: Colors.transparent),
      //height: 200,
      //padding: EdgeInsets.all(20),
        child:
          Padding(
          padding: const EdgeInsets.all(0.0),
          child: 
           charts.BarChart(_createSampleData(),
            animate: false,
            vertical: false,
            primaryMeasureAxis: new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
            domainAxis: const charts.OrdinalAxisSpec(
            showAxisLine: false,
            renderSpec: charts.NoneRenderSpec()),
            defaultRenderer: charts.BarRendererConfig(
              groupingType: charts.BarGroupingType.stacked,
              maxBarWidthPx: 40,)
              )
          ),
      );
  }
}