import 'package:flutter_test/flutter_test.dart';
import 'package:item_tracker/providers/item_provider.dart';

void main() {
  test('ItemProvider add, edit, remove item', () {
    final provider = ItemProvider();
    provider.addItem("Test", "Description");
    expect(provider.items.length, 1);

    provider.editItem(0, "Updated", "Updated Description");
    expect(provider.items[0].name, "Updated");

    provider.removeItem(0);
    expect(provider.items.isEmpty, true);
  });
}
