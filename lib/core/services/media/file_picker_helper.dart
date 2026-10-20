import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mustore/core/services/permissions/permission_helper.dart';

enum FileTypeGroup {
  image,
  video,
  pdf,
}

class FilePickerHelper {
  static const Map<FileTypeGroup, List<String>> _allowedExtensionsMap = {
    FileTypeGroup.image: ['jpg', 'jpeg', 'png', 'gif', 'webp'],
    FileTypeGroup.video: ['mp4', 'mov', 'avi', 'mkv'],
    FileTypeGroup.pdf: ['pdf'],
  };

  static List<String> _getAllowedExtensions(FileTypeGroup group) {
    return _allowedExtensionsMap[group] ?? [];
  }

  static List<String> _getExtensionsForGroups(List<FileTypeGroup> groups) {
    return groups.expand((g) => _getAllowedExtensions(g)).toList();
  }

  static bool _isMixedTypes(List<PlatformFile> files) {
    final extensions =
    files.map((f) => f.extension?.toLowerCase()).whereType<String>().toSet();

    final matchedGroups = _allowedExtensionsMap.entries
        .where((entry) =>
        extensions.any((ext) => entry.value.contains(ext)))
        .length;

    return matchedGroups > 1;
  }

  static Future<void> pickFiles({
    required BuildContext context,
    required List<FileTypeGroup> fileTypeGroups,
    required int maxFiles,
    required int maxFileSizeInMB,
    required ValueChanged<List<PlatformFile>> onFilesSelected,
    required ValueChanged<String> onError,
    bool allowMixedTypes = false,
  }) async {
    await PermissionHelper.request(AppPermission.storage);

    final List<PlatformFile> files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: _getExtensionsForGroups(fileTypeGroups),
    );

    if (files.isEmpty) return;

    if (files.length > maxFiles) {
      onError("You can only select up to $maxFiles files.");
      return;
    }

    for (final file in files) {
      final bytes = file.lengthSync() ?? await file.length() ?? 0;
      final sizeInMB = bytes / (1024 * 1024);
      if (sizeInMB > maxFileSizeInMB) {
        onError("The file exceeds ${maxFileSizeInMB}MB.");
        return;
      }
    }

    if (!allowMixedTypes && _isMixedTypes(files)) {
      onError("Cannot upload mixed file types together.");
      return;
    }

    onFilesSelected(files);
  }
}