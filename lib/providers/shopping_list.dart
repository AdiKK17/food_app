import 'package:flutter/material.dart';

import '../helper/db_helper.dart';

class ShoppingIngredients with ChangeNotifier{

  List<String> _itemsToBuy = [];

  List<String> get itemsToBuy{
    return List.from(_itemsToBuy);
  }


  void addItem(String item,int index){

    _itemsToBuy.add(item);
//    notifyListeners();
    DBHelper.insert("things_to_buy", {"id" : index , "item" : item});
    notifyListeners();

  }

  Future<void> fetchAndSet() async {
    final dataList = await DBHelper.getData("things_to_buy");
    print(dataList);
    final _itemsToBuy = dataList.map((item) => item["item"].toString()).toList();
    print("data added.....as.dasdsds");
    print(_itemsToBuy);
    notifyListeners();
  }


  void deleteItem(int index){
  _itemsToBuy.removeAt(index);
  }


  void updateItem(){



  }


}