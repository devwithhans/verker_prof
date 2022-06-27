part of 'projects_cubit.dart';

enum ProjectsStatus { succes, initial, failed, loading }

class ProjectsState extends Equatable {
  final List<Outreach> projects;
  final ProjectsStatus status;
  const ProjectsState(
      {this.projects = const [], this.status = ProjectsStatus.initial});

  ProjectsState copyWith({
    List<Outreach>? projects,
    ProjectsStatus? status,
  }) {
    return ProjectsState(
        projects: projects ?? this.projects, status: status ?? this.status);
  }

  @override
  List<Object> get props => [projects, status];
}
