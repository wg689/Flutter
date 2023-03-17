import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bili_app/db/hi_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test("测试Hicach", () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await HiCache.preInit();
    var key = 'testHiCache', value = 'hello';
    HiCache.getInstance().setString(key, value);
    expect(HiCache.getInstance(), value);
  });
}
