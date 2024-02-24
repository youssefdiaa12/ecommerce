import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class disk_storge extends ChangeNotifier {
   add_to_cart_quantity(String productId, int count) async {
    var hiev = await Hive.openBox("cart");
    // shampo : 3
    //gel :5
    final old_count = await hiev.get(productId);
    if (old_count != null) {
     await hiev.put(productId, old_count + count);
    } else {
    await  hiev.put(productId, count);
    }
  }

   clear_cart_product(String productId) async {
    var hiev = await Hive.openBox("cart");
    await hiev.delete(productId);
  }
  Future<num> get_cart_product(String productId) async {
    var hiev = await Hive.openBox("cart");
    return await hiev.get(productId) ?? 0;
  }
}
