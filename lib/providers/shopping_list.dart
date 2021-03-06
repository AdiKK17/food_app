import 'package:flutter/material.dart';

import '../helper/db_helper.dart';
import '../models/shopping_list_item.dart';

class ShoppingIngredients with ChangeNotifier{

  List<ShoppingListItem> _itemsToBuy = [];

  List<ShoppingListItem> get itemsToShop{
    return List.from(_itemsToBuy);
  }


  Future<void> addItem(String item,int index) async {
    final nextIndex = _itemsToBuy.length == 0 ? 0 : _itemsToBuy[_itemsToBuy.length-1].id+1;
    _itemsToBuy.add(ShoppingListItem(id: nextIndex, description: item));
    DBHelper.insert("things_to_buy", {"id" : nextIndex , "item" : item});
   await fetchAndSet();
  }

  Future<void> fetchAndSet() async {
    final dataList = await DBHelper.getData("things_to_buy");
    _itemsToBuy = dataList.map((item) => ShoppingListItem(id: item["id"], description: item["item"])).toList();
    if(_itemsToBuy.length == 0){
      print("initial length is zero");
      return;
    }
    notifyListeners();
  }


  Future<void> deleteItem(int id, int index) async {
    _itemsToBuy.removeAt(index);
  await DBHelper.delete("things_to_buy", id);
  await fetchAndSet();
  }


  void updateItem(){



  }


}