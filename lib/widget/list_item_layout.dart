import 'package:expense_manager/model/listitem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class ListItemLayout extends StatelessWidget {
 final List<list_Item> transaction;
 Function deleteItem;
 ListItemLayout(this.transaction,this.deleteItem);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  ListView.builder(
        itemCount: transaction.length,
        itemBuilder: (context,index){
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8,horizontal:10),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding:const EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text(transaction[index].price.toString()),
                    ),
                  ),
                ),
                title: Text(transaction[index].title),
                subtitle: Text(DateFormat.yMMMd().format(transaction[index].dateTime)),
                trailing: IconButton(icon: const Icon(Icons.delete,color: Colors.grey),onPressed: ()=> deleteItem(transaction[index].id) ),
              ),
            ),
          );
        });
  }

}