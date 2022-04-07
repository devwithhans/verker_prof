// This model is used for managing the parameters for the swipe-browse filter

class ProjectSearchFilter {
  final List<double> position;
  final String type;
  final int maxDistance;

  ProjectSearchFilter(
      {this.position = const [], this.maxDistance = 100000, this.type = ''});

  ProjectSearchFilter copyWith({
    final List<double>? position,
    final String? type,
    final int? maxDistance,
  }) {
    return ProjectSearchFilter(
      position: position ?? this.position,
      maxDistance: maxDistance ?? this.maxDistance,
      type: type ?? this.type,
    );
  }
}
