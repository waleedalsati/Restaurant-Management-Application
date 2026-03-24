import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectweather/Home/searshall/searshallstate.dart';


import '../../Helper/api.dart';
import '../Blocs/Bloc-categroy/categroy-model.dart';

class SearshAllcubit extends Cubit<SearshAllstate> {
  final api ap16;

  SearshAllcubit(this.ap16) : super(initialSearsh());

  Future<void> Searshall(String data) async {
    emit(lodingSearsh());



    final response = await ap16.get(
      url: 'https://striking-sailfish-severely.ngrok-free.app/api/categories/search?q=$data',
    );
    final List<categorymodel> category = (response['data'] as List)
        .map((cat) => categorymodel.fromJeson(cat))
        .toList();

    emit(lodedSearsh(category: category));
  }


}