import 'package:flutter/material.dart';

import '../helper/db_helper.dart';
import '../models/shopping_list_item.dart';

class ShoppingIngredients with ChangeNotifier{

  List<ShoppingListItem> _itemsToBuy = [];

  List<ShoppingListItem> get itemsToShop{
    return List.from(_itemsToBuy);
  }


  void addItem(String item,int index) async {

    await fetchAndSet();
    _itemsToBuy.add(ShoppingListItem(id: index.toString(), description: item));
//    notifyListeners();
    DBHelper.insert("things_to_buy", {"id" : index , "item" : item});
    notifyListeners();

  }

  Future<void> fetchAndSet() async {
    final dataList = await DBHelper.getData("things_to_buy");
    print(dataList);
//    _itemsToBuy = dataList.map((item) => item["item"].toString()).toList();
    _itemsToBuy = dataList.map((item) => ShoppingListItem(id: item["id"], description: item["item"])).toList();
    print("data added.....as.dasdsds");
    print(_itemsToBuy);
    print("chalnikal");
    print(_itemsToBuy.length);
    notifyListeners();
  }


  void deleteItem(int id){
    _itemsToBuy.removeAt(id);
  DBHelper.delete("things_to_buy", id);
  }


  void updateItem(){



  }


}