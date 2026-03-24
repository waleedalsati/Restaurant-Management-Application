
import 'categroy-model.dart';

abstract class CategoryState {}
class CategoryInitial extends CategoryState {}
class CategoryLoading extends CategoryState {}
class CategorySuccess extends CategoryState {
  final List<categorymodel> categories;
  CategorySuccess(this.categories);
}
class CategoryFailer extends CategoryState {
  final String message;
  CategoryFailer(this.message);
}
