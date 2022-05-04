part of 'swipe_bloc.dart';

abstract class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object> get props => [];
}

class FetchProjects extends SwipeEvent {
  final ProjectSearchFilter? projectSearchFilter;
  final int currentIndex;

  const FetchProjects({this.projectSearchFilter, this.currentIndex = 0});
}

class RemoveProject extends SwipeEvent {
  String id;

  RemoveProject(this.id);
}

class GetLocation extends SwipeEvent {}
