//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import desktop_window
import package_info_plus_macos
import path_provider_macos
import sentry_flutter
import window_size

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  DesktopWindowPlugin.register(with: registry.registrar(forPlugin: "DesktopWindowPlugin"))
  FLTPackageInfoPlusPlugin.register(with: registry.registrar(forPlugin: "FLTPackageInfoPlusPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SentryFlutterPlugin.register(with: registry.registrar(forPlugin: "SentryFlutterPlugin"))
  WindowSizePlugin.register(with: registry.registrar(forPlugin: "WindowSizePlugin"))
}
