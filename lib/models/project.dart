class ProjectModel {
  String? id;
  String? consumerId;
  String? title;
  String? description;
  String? projectType;
  List<dynamic> images;
  List<dynamic> videos;
  String? deadline;
  Map? address;
  Map? location;
  String? createdAt;
  double? distance;

  ProjectModel({
    required this.id,
    required this.consumerId,
    required this.address,
    required this.location,
    required this.projectType,
    required this.description,
    required this.images,
    required this.videos,
    required this.title,
    required this.createdAt,
    required this.deadline,
    required this.distance,
  });

  static convert(response) {
    List images = response['projectImages'];

    return ProjectModel(
      id: response['_id'] ??= null,
      consumerId: response['_consumerId'] ??= null,
      title: response['title'] ??= null,
      description: response['description'] ??= null,
      projectType: response['projectType'] ??= null,
      images:
          images.where((element) => element.split('.').last == 'jpg').toList(),
      videos:
          images.where((element) => element.split('.').last == 'mp4').toList(),
      deadline: response['deadline'] ??= null,
      distance: response['distance'] ??= null,
      createdAt: response['createdAt'] ??= null,
      address: response['address'] != null
          ? {
              'address': response['address']['address'] ??= null,
              'zip': response['address']['zip'] ??= null,
            }
          : null,
      location: response['location'] != null
          ? {
              'type': response['location']['point'] ??= null,
              'coordinates': response['location']['coordinates'] ??= null,
            }
          : null,
    );
  }
}
