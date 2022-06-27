import 'package:equatable/equatable.dart';

abstract class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object> get props => [];
}

class FetchMyProjects extends ProjectsEvent {}

class ReloadMyProjects extends ProjectsEvent {}
