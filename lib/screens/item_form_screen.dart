import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';

class ItemFormScreen extends StatefulWidget {
  final int? index;

  const ItemFormScreen({Key? key, this.index}) : super(key: key);

  @override
  _ItemFormScreenState createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // If index is provided, pre-fill the text fields with existing item data
    if (widget.index != null) {
      final itemProvider = Provider.of<ItemProvider>(context, listen: false);
      final item = itemProvider.items[widget.index!];
      _nameController.text = item.name; // Set the name from the item
      _descriptionController.text = item.description; // Set the description from the item
    }
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed from the widget tree
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.index == null ? "Add Item" : "Edit Item",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name TextField
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Description TextField
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Add/Edit Button
              ElevatedButton(
                onPressed: () {
                  if (widget.index == null) {
                    itemProvider.addItem(
                      _nameController.text,
                      _descriptionController.text,
                    );
                  } else {
                    itemProvider.editItem(
                      widget.index!,
                      _nameController.text,
                      _descriptionController.text,
                    );
                  }
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text(widget.index == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
