import 'package:expense_manager/model/listitem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chartbar.dart';

class Chart extends StatelessWidget {
  final List<list_Item> recentTransaction;

  Chart(this.recentTransaction);
  List <Map<String,Object>> get groupedTransactionValue{
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum=0.0;
      for(var i=0;i<recentTransaction.length;i++){
        if(recentTransaction[i].dateTime.day==weekday.day &&
            recentTransaction[i].dateTime.month==weekday.month &&
            recentTransaction[i].dateTime.year ==weekday.year
        ) {
          totalSum += double.parse(recentTransaction[i].price.substring(1));
          print(totalSum);
        }
      }
      print('day');
     print(DateFormat.E().format(weekday));
      print('Sum');
      print(totalSum);
     return {'day':DateFormat.E().format(weekday),'amount':totalSum };
    }
      ).reversed.toList() ;
  }

  double get maxSpendingValue{
    return groupedTransactionValue.fold(0.0, (sum, item) {
      return sum+ ( item['amount'] as double );
    });
  }
  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValue);
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20),
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValue.map((element){
            return Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: chartbar(( element['day'] as String), (element['amount'] as double), maxSpendingValue == 0.0 ? 0.0 : (element['amount'] as double)/maxSpendingValue));
            }).toList()

        ),
      )

    );
  }
}
