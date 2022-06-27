import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:verker_prof/utils/config.dart';

class ProjectModel {
  String? id;
  String? consumerId;
  String? title;
  String? description;
  String? projectType;
  List<String> images;
  List<String> videos;
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
    List noUrlFiles = List<String>.from(response['projectImages']);
    List<String> urlFiles = [];
    noUrlFiles.forEach(((element) => urlFiles.add(imageUrl + element)));

    List<String> images =
        urlFiles.where((element) => element.split('.').last == 'jpg').toList();
    List<String> videos =
        urlFiles.where((element) => element.split('.').last == 'mp4').toList();

    return ProjectModel(
      id: response['_id'] ??= null,
      consumerId: response['_consumerId'] ??= null,
      title: response['title'] ??= null,
      description: response['description'] ??= null,
      projectType: response['projectType'] ??= null,
      images: images,
      videos: videos,
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
