package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import cn.bmob.data_plugin.DataPlugin;
import io.flutter.plugins.deviceinfo.DeviceInfoPlugin;
import com.yangyxd.flutterpicker.FlutterPickerPlugin;
import com.baseflow.permissionhandler.PermissionHandlerPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    DataPlugin.registerWith(registry.registrarFor("cn.bmob.data_plugin.DataPlugin"));
    DeviceInfoPlugin.registerWith(registry.registrarFor("io.flutter.plugins.deviceinfo.DeviceInfoPlugin"));
    FlutterPickerPlugin.registerWith(registry.registrarFor("com.yangyxd.flutterpicker.FlutterPickerPlugin"));
    PermissionHandlerPlugin.registerWith(registry.registrarFor("com.baseflow.permissionhandler.PermissionHandlerPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
