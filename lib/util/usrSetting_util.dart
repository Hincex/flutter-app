import 'package:shared_preferences/shared_preferences.dart';
import '../global_config.dart' show GlobalConfig;
import '../data/userData.dart';

class UsrSettingUtil {
  static Future<int> getUsrSetting() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    int themeIndex = pref.getInt("localTheme");
    if (pref.getString('user_name') != null)
      UsrData.usrName = pref.getString('user_name');
    if (pref.getString('user_job') != null)
      UsrData.usrJob = pref.getString('user_job');
    if (pref.getString('user_id') != null)
      UsrData.usrId = pref.getString('user_id');
    if (pref.getBool('isGrid') != null) UsrData.isGrid = pref.getBool('isGrid');
    // print(themeIndex);
    if (themeIndex != null) {
      GlobalConfig.themeData = GlobalConfig.themes[themeIndex];
      GlobalConfig.tempThemeData = GlobalConfig.themes[themeIndex];
      return themeIndex;
    } else {
      GlobalConfig.themeData = GlobalConfig.themes[1];
    }
    return 0;
  }
}
