abstract class deletecartstate{}
class intionaideletecart extends deletecartstate{}
class loadingdeletecart extends deletecartstate{}
class successdeletecart extends deletecartstate

{
 final String massage ;
  successdeletecart(this.massage);

}
class failerdeletlcart extends deletecartstate

{
 final String massage ;
 failerdeletlcart(this.massage);

}