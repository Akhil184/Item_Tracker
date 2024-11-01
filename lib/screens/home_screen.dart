import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import '../widgets/item_card.dart';
import 'item_form_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Item Tracker",
          textAlign: TextAlign.center, // Center the title text
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        centerTitle: true, // Center the title within the AppBar
      ),

      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, _) => ListView.builder(
          itemCount: itemProvider.items.length,
          itemBuilder: (context, index) => ItemCard(index: index),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItemFormScreen()),
          );
        },
        child: Container(
          height: 60, // Custom height and width for a larger FAB
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blueAccent], // Gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.4), // Soft shadow
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),

    );
  }
}
