abstract class addFavoriteState {}
class SuccessAdd extends addFavoriteState{

}

class initialStateF extends addFavoriteState{}
class FailAdd extends addFavoriteState{

  String message;
  FailAdd({required this.message});
}