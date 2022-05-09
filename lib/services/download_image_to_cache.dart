import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';

Future<void> downloadImagesToCache(List listOfImageUrls) async {
  /// We iterate the list for downloading each image from the image url
  await Future.forEach(listOfImageUrls as List<String>, (String item) async {
    /// We first have to check if the file is already present in the cache or not
    FileInfo? fileInfo =
        await GetIt.instance.get<BaseCacheManager>().getFileFromCache(item);
    bool fileExists = false;

    /// if file exists then var fileExists is set to true , else false
    if (fileInfo != null) {
      fileExists = await fileInfo.file.exists();
    }

    /// if the file does not exists , then we download it in the cache
    if (!fileExists) {
      try {
        await GetIt.instance.get<BaseCacheManager>().downloadFile(item);
      } catch (e) {
        /// if file url is incorrect or corrupted then we move on to next url
        print('Error in downloading image $e');
      }
    }
  }).timeout(const Duration(seconds: 10));
}
