package com.worldsoft.bkonek
import com.worldsoft.bkonek.FirebaseCloudMessagingPluginRegistrant
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry


class Application : FlutterApplication(), PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this)
    }

    override fun registerWith(registry: PluginRegistry) {
        FirebaseCloudMessagingPluginRegistrant.registerWith(registry)
    }
}
 