import 'package:dio/dio.dart';

class FormDataInterceptor extends Interceptor {
  static const _filePath = 'FilePath:';

  @override
  Future onRequest(RequestOptions options) async {
    if (_requestContainsFile(options.data)) {
      final formData = await _convertToFormData(options.data);
      options.data = formData;
    }
  }

  Future<Map<String, dynamic>> _changeFileRecursively(
      Map<String, dynamic> data) async {
    final newData = <String, dynamic>{};
    for (final key in data.keys ?? []) {
      final value = data[key];
      if (value is Map) {
        newData[key] = await _changeFileRecursively(value);
      } else if (value is String && value.startsWith(_filePath)) {
        final path = value.toString().replaceAll(_filePath, '');
        final fileName = path.split('/').last;
        final formFile = await MultipartFile.fromFile(path, filename: fileName);
        newData[key] = formFile;
      } else {
        newData[key] = value;
      }
    }
    return newData;
  }

  Future<FormData> _convertToFormData(Map data) async {
    final formDataMap = await _changeFileRecursively(data);
    return FormData.fromMap(formDataMap);
  }

  bool _requestContainsFile(data) {
    if (data != null && data is Map) {
      for (final key in data.keys ?? []) {
        final value = data[key];
        if (value == null) {
          continue;
        } else if (value is Map) {
          if (_requestContainsFile(value)) {
            return true;
          }
        } else if (value is String && value.startsWith(_filePath)) {
          return true;
        }
      }
    }
    return false;
  }
}
