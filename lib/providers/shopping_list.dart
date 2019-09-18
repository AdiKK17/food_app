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
//    if(_itemsToBuy.length == 0){
//      nextIndex = 0;
//    }
    final nextIndex = _itemsToBuy.length == 0 ? 0 : _itemsToBuy[_itemsToBuy.length-1].id+1;
    _itemsToBuy.add(ShoppingListItem(id: nextIndex, description: item));
    DBHelper.insert("things_to_buy", {"id" : nextIndex , "item" : item});
//    notifyListeners();
   await fetchAndSet();
  }

  Future<void> fetchAndSet() async {
    final dataList = await DBHelper.getData("things_to_buy");
    print(dataList);
    print("hayabusa");
//    _itemsToBuy = dataList.map((item) => item["item"].toString()).toList();
    _itemsToBuy = dataList.map((item) => ShoppingListItem(id: item["id"], description: item["item"])).toList();
    if(_itemsToBuy.length == 0){
      print("initial length is zero");
      return;
    }
    notifyListeners();
  }


  void deleteItem(int id, int index) async {
    print(id);
    print(index);
    print("ninja");
    _itemsToBuy.removeAt(index);
  await DBHelper.delete("things_to_buy", id);
  fetchAndSet();

  }


  void updateItem(){



  }


}