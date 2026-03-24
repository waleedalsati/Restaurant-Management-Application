abstract class statetable{}
 class inationaltable extends statetable{}
class loadingtable extends statetable{}
class successtable extends statetable
{
  final String massage;

  successtable({required this.massage});
}
class failertable extends statetable
{
  final String massage;
  failertable({required this.massage});


}