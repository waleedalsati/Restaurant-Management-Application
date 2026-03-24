abstract class deletetablestate{}
class intionaideletetable extends deletetablestate{}
class loadingdeletetable extends deletetablestate{}
class successdeletetable extends deletetablestate
{
  final String massage ;
  successdeletetable(this.massage);
}
class failerdeletltable extends deletetablestate
{
  final String massage ;
  failerdeletltable(this.massage);
}