import 'package:expense_manager/model/listitem.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class savingCard extends StatefulWidget {
 //  savingCard({Key? key}) : super(key: key);
    final Function(String,String,DateTime) functions;
   savingCard(this.functions);

  @override
  State<savingCard> createState() => _savingCardState();
}

class _savingCardState extends State<savingCard> {
  final titleController = TextEditingController();
   DateTime selectedDate=DateTime(2017);
  final amountController = TextEditingController();
  void presentDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now() , firstDate: DateTime(2021), lastDate: DateTime.now()).then((value){
      if(value==null)return;
      setState(() {
        selectedDate=value;
      });

    });
  }
  @override
  Widget build(BuildContext context) {

    return Container(
        margin: const EdgeInsets.all(1.0),
        child: Card(
          elevation: 5,
          child: Column(

              children:[Container(
                margin:const EdgeInsets.fromLTRB(10, 4, 10, 2),
                child:  TextField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Title",
                      floatingLabelStyle: TextStyle(
                          color: Colors.green.shade800
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all( Radius.circular(10.0))
                      ),
                      enabledBorder:const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green, width: 2.0),
                          borderRadius: BorderRadius.all( Radius.circular(10.0))
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade800, width: 2.0),
                          borderRadius:const BorderRadius.all( Radius.circular(10.0))
                      )

                  ),
                ),
              ),
                Container(
                  margin:const EdgeInsets.fromLTRB(10, 7, 10, 2),
                  child:  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Amount",
                        floatingLabelStyle: TextStyle(
                            color: Colors.green.shade800
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border:const OutlineInputBorder(
                            borderRadius: BorderRadius.all( Radius.circular(10.0))
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green, width: 2.0),
                            borderRadius: BorderRadius.all( Radius.circular(10.0))
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green.shade800, width: 2.0),
                            borderRadius:const BorderRadius.all( Radius.circular(10.0))
                        )

                    ),
                  ),
                ),
                Container(
                  margin:const EdgeInsets.fromLTRB(10, 7, 10, 2),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Expanded(
                         child: Text(
                           "Selected date : ${
                      selectedDate == DateTime(2017)
                            ? "No date added yet"
                            : DateFormat.yMMMd().format(selectedDate)
                    }",style: TextStyle(fontSize: 15),
                      ),
                       ),
                      IconButton(onPressed: presentDatePicker, icon: Icon(Icons.calendar_today,color: Colors.green,))
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: TextButton(onPressed:(){
                    String amountText = "\$"+amountController.text;
                    widget.functions(titleController.text,amountText,selectedDate);
                  }, child: const Text(
                    "Add Transaction", style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                  ),
                  ),
                  ),
                )
              ]
          ),
        )
    );
  }
}
