part of 'swipe_bloc.dart';

enum ProjectStatus { initial, succes, failed, loading }

class SwipeState extends Equatable {
  final ProjectStatus status;
  final List<ProjectModel> projects;
  final bool hasReachedMax;
  final int currentIndex;
  final String? errorText;

  final List<double> position;
  final String type;
  final int maxDistance;

  const SwipeState({
    this.errorText,
    this.currentIndex = 0,
    this.maxDistance = 100000,
    this.position = const [],
    this.type = '',
    this.status = ProjectStatus.initial,
    this.hasReachedMax = false,
    this.projects = const [],
  });

  SwipeState copyWith({
    String? errorText,
    int? currentIndex,
    ProjectStatus? status,
    List<ProjectModel>? projects,
    bool? hasReachedMax,
    List<double>? position,
    String? type,
    int? maxDistance,
  }) {
    return SwipeState(
      errorText: errorText ?? this.errorText,
      currentIndex: currentIndex ?? this.currentIndex,
      maxDistance: maxDistance ?? this.maxDistance,
      type: type ?? this.type,
      position: position ?? this.position,
      status: status ?? this.status,
      projects: projects ?? this.projects,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props =>
      [status, projects, hasReachedMax, position, type, maxDistance];
}
