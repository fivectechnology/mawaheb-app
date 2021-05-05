import 'package:flutter_test/flutter_test.dart';

void main() {
  test('adsad', () {
    const str = 'attachment; filename="e1.mp4"';
    print(
      str.substring(str.lastIndexOf('=') + 2, str.length - 1),
    );
  });
}
