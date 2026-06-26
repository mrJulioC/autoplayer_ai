import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../services/media/media_query_service.dart';
import '../../services/permissions/permission_service.dart';

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService();
});

final mediaQueryServiceProvider = Provider<MediaQueryService>((ref) {
  return MediaQueryService();
});

final songLibraryProvider = FutureProvider<List<SongModel>>((ref) async {
  final permissionService = ref.read(permissionServiceProvider);
  final mediaService = ref.read(mediaQueryServiceProvider);

  final hasPermission = await permissionService.requestMediaPermissions();

  if (!hasPermission) {
    return [];
  }

  return mediaService.getSongs();
});