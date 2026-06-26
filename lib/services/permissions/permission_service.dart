import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestMediaPermissions() async {
    final audioStatus = await Permission.audio.request();
    final videoStatus = await Permission.videos.request();

    return audioStatus.isGranted || videoStatus.isGranted;
  }
}