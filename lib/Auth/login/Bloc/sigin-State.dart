abstract class siginstate{}
class loading extends siginstate{}
class success extends siginstate
{
  String massage;
  success({required this.massage});
}
class failer extends siginstate{

  String massage;
  failer({required this.massage});
}