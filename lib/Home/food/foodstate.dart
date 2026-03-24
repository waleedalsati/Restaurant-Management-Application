
import 'modelffod.dart';

abstract class foodstate{}
class foodInitial extends foodstate{}
class foodloding extends foodstate{}
class foodsuccess extends foodstate{
  final List<foodmodel>food;
  foodsuccess(this.food);
}
class foodfailer extends foodstate
{
  final String massage;
  foodfailer(this.massage);
}