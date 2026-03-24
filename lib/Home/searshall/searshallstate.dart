

import '../Blocs/Bloc-categroy/categroy-model.dart';

abstract class SearshAllstate {}

class initialSearsh extends SearshAllstate {}

class lodingSearsh extends SearshAllstate {}

class lodedSearsh extends SearshAllstate {

 final List<categorymodel> category;

 lodedSearsh({required this.category});

}

class failSearsh extends SearshAllstate {
 final String message;
 failSearsh({required this.message});
}
