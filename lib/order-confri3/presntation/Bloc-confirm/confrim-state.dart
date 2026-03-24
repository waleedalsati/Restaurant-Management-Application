abstract class confrim{}
 class inationalconfrim extends confrim{}
class loadingconfrim extends confrim{}
class successconfrim extends confrim{
  final String massage;
  successconfrim(this.massage);
}
class faliarconfrim extends confrim
{
  final String massage;
  faliarconfrim(this.massage);

}