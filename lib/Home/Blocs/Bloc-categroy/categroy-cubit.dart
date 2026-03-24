import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Helper/api.dart';
import 'category-state.dart';
import 'categroy-model.dart';
class categroycubit extends Cubit<CategoryState>
{
  final api pi1;
  categroycubit(this.pi1):super(CategoryInitial());

  Future<dynamic>categroy()async
  {
    try {
      emit(CategoryLoading());

      final response = await pi1.get(
          url: 'https://striking-sailfish-severely.ngrok-free.app/api/categories');

      final List<categorymodel> categories  = (response as List)
          .map((item) => categorymodel.fromJeson(item))
          .toList();
      emit(CategorySuccess(categories ));
    }
    catch (e) {
      emit(CategoryFailer(e.toString()));
    }
  }
}