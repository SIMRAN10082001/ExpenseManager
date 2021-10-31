import 'package:expense_manager/widget/chart.dart';
import 'package:expense_manager/widget/saving_widget.dart';
import 'package:flutter/material.dart';
import 'package:expense_manager/model/listitem.dart';
import 'package:expense_manager/widget/list_item_layout.dart';
import 'package:intl/intl.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
 MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {   
    final List<list_Item> transaction = [];
 //   final List<list_Item> transactionOld = [];
  void addTransaction(String title,String amount,DateTime date){

    if(title.isEmpty || amount.isEmpty || date==DateTime(2017))return;
    list_Item item =list_Item(title: title,details: "",price: amount,dateTime: date,id: date.toString() );
    setState(() {
      transaction.add(item);
    });
  }
    List<list_Item>get transactionOld{
    var item = transaction.where((element){
      return element.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    });
   return  item.toList();
}
   
  void showBottamSheetDialog(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (context) {
      return savingCard(addTransaction);
    }  );
  }

  void deleteItem(String id){
    setState(() {
      transaction.removeWhere((element) {
      return  element.id==id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'BalsamiqSans'

      ),
      home: Scaffold(
        appBar:PreferredSize(
          preferredSize:  const Size.fromHeight(50),
          child: Builder(
            builder:(context)=> AppBar(
            title: const Text("Main"),
            actions: [
              IconButton(onPressed: ()=> showModalBottomSheet<void>(context: context, builder:(BuildContext ctx) {
                return savingCard(addTransaction);
              }),
                icon: Icon(Icons.add,color: Colors.white,)
              )
            ],
            backgroundColor: Colors.green,
          ),
      ),
        ),
        body: Column(children:<Widget> [
          Chart(transactionOld),
          Expanded(
           child: transaction.isEmpty? Column(
             children:<Widget> [
               const Text("No transaction added yet", style: TextStyle(
                 fontFamily: 'Inter',
                 fontSize: 20
               )),
               Container(
               margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                 child: Image.asset('assets/images/emptyImg.jpg')
             ),]
           ): ListItemLayout(transaction,deleteItem),
         )
      ]
      ),
        floatingActionButton:Builder(
      builder:(context)=> FloatingActionButton(onPressed: () => showModalBottomSheet<void>(context: context, builder:(BuildContext ctx) {
                return savingCard(addTransaction);
              }),
        backgroundColor: Colors.white,
        focusColor: Colors.white54,
        child: const Icon(Icons.add,color: Colors.green),
        ),
        )
        )
      );
  }
}
