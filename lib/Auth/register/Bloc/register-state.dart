abstract class registerstate{}

class loadingregister extends registerstate{}
class successregister extends registerstate{
  String massage;
  successregister({required this.massage});
}
class failerregister extends registerstate{
  String massage ;
  failerregister({required this.massage});

}

