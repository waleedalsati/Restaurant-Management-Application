
abstract class DeleteFavouriteState  {

}

class DeleteFavouriteInitial extends DeleteFavouriteState {}

class DeleteFavouriteLoading extends DeleteFavouriteState {}

class DeleteFavouriteSuccess extends DeleteFavouriteState {
 final int deletedId;
 DeleteFavouriteSuccess(this.deletedId);

 @override
 List<Object?> get props => [deletedId];
}

class DeleteFavouriteFailure extends DeleteFavouriteState {
 final String error;
 DeleteFavouriteFailure(this.error);

 @override
 List<Object?> get props => [error];
}
