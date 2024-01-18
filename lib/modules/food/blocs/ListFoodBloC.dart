
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/FoodListModel.dart';
import '../repos/FoodListRepo.dart';

class ListFoodBloC extends Bloc<String, ListFoodState>{
  //ListFoodBloC(super.initialState);
  ListFoodBloC() : super(ListFoodState()){
    on<String>((event, emit) async{
      switch(event){
        case 'getAllFoodListByUserId':
          try{
              final res = await FoodListRepo().TakeAllFoodListByUserId();
              print(res);
              if(res != null){
                emit(ListFoodState(foodlist: res));
              }
          }catch(e){
                emit(ListFoodState(error: e));
          }
        break;
      }
    });
  }
}
class ListFoodState{
  final Object? error;
  final List<Data>? foodlist;
  ListFoodState({ this.error, this.foodlist});
}