abstract class myprofilestate {}
class successmyprofile extends myprofilestate{
  String message;
  successmyprofile({required this.message});
}
class loadingmyprofile extends myprofilestate{}

class failurmyprofile extends myprofilestate{
  String message;
  failurmyprofile({required this.message});
}