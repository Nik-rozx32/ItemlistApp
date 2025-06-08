import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import 'item_form.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
      ),
      body: ListView.builder(
          itemCount: itemProvider.items.length,
          itemBuilder: (_, index) {
            final item = itemProvider.items[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text("₹${item.price.toStringAsFixed(2)}"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ItemForm(item: item, index: index)));
              },
              trailing: IconButton(
                onPressed: () {
                  itemProvider.deleteItem(index);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ItemForm()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
