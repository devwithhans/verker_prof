import 'package:equatable/equatable.dart';
import 'package:verker_prof/features/projects/models/project.dart';

abstract class BrowseProjectState extends Equatable {
  const BrowseProjectState();

  @override
  List<Object> get props => [];
}

class BrowsingInitial extends BrowseProjectState {}

class BrowsingLoading extends BrowseProjectState {}

class BrowsingFailed extends BrowseProjectState {}

class BrowsingSucces extends BrowseProjectState {
  final List<ProjectModel> projects;
  const BrowsingSucces(this.projects);
}
