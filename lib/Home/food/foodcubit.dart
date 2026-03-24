import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Auth/token.dart';
import '../../Helper/api.dart';
import 'foodstate.dart';
import 'modelffod.dart';
class foodcubit extends Cubit<foodstate>
{
  final api api2;
  foodcubit(this.api2):super(foodInitial());
  Future<dynamic>food(int id)async
  {
    try {
      emit(foodloding());
      {
        final response = await api2.get(url: 'https://striking-sailfish-severely.ngrok-free.app/api/foods/$id');
        final List dataList1 = response['data'];

        final List<foodmodel> foods = dataList1.map((item1) =>
            foodmodel.fromjeson(item1)).toList();

        if (dataList1.isNotEmpty) {
          final firstFood = dataList1[0];
          final int id2 = firstFood['id'];


          await StorageHelper.save2Token(id2);

          print('تم حفظ ID للمأكول: $id2');
        } else {
          print('لا توجد بيانات طعام في الاستجابة');
        }
        emit(foodsuccess(foods));

      }
    }
    catch (e) {
      emit(foodfailer(e.toString()));
    }
  }
}