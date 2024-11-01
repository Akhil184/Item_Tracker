import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/item_provider.dart';
import '../screens/item_form_screen.dart';
import '../utils/render_box_utils.dart';

class ItemCard extends StatefulWidget {
  final int index;

  ItemCard({required this.index});

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  Offset? floatingButtonPosition;

  void _updateFloatingButtonPosition(BuildContext context) {
    final renderBoxInfo = RenderBoxUtils.getRenderBoxInfo(context);
    final Offset position = renderBoxInfo['position'];

    setState(() {
      // Adjust position to display button near the card
      floatingButtonPosition = Offset(position.dx + 150, position.dy - 20);
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<ItemProvider>(context).items[widget.index];

    return GestureDetector(
      onTap: () {
        _updateFloatingButtonPosition(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemFormScreen(index: widget.index),
          ),
        );
      },
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          contentPadding: EdgeInsets.all(16),
          title: Text(
            item.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          subtitle: Text(
            item.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blueAccent),
                onPressed: () {
                  // Navigate to the item form screen for editing
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemFormScreen(index: widget.index),
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Deletion'),
                        content: Text('Are you sure you want to delete this item?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<ItemProvider>(context, listen: false)
                                  .removeItem(widget.index);
                              Navigator.of(context).pop();
                            },
                            child: Text('Delete', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
