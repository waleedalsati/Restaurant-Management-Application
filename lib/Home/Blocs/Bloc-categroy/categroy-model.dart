class categorymodel
{
  final String name;
  final String des;
  final String photo;
  final int  id;
  categorymodel
      ({
    required this.des,
    required this.photo,
    required this.name
    ,required this.id
      });
  factory categorymodel.fromJeson(Map<String,dynamic>jeson)
  {
    return categorymodel(
      id: jeson['id'],
        des: jeson['description']??'',
        photo:jeson['category_photo']??'' ,
        name:jeson['category_name']??'' );
  }

}
