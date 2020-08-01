package com.memtechnologies.kodi_kiganjani;

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
import android.os.Bundle


import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin

import io.flutter.view.FlutterMain

public class Application: FlutterApplication(), PluginRegistrantCallback {
  override fun onCreate() {
    super.onCreate()
    FlutterFirebaseMessagingService.setPluginRegistrant(this)
    FlutterMain.startInitialization(this)
  }

  override fun registerWith(registry: PluginRegistry) {
    if (!registry!!.hasPlugin("io.flutter.plugins.firebasemessaging")) {
            FirebaseMessagingPlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
        }
  }
}