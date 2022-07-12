package com.example.flutter_practice

import android.os.Bundle
import io.flutter.app.FlutterActivity
import io.flutter.plugins.BatteryPlugin

class EmbeddedActivity2 : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        BatteryPlugin.registerWith(registrarFor("io.flutter.plugins.battery.BatteryPlugin"))
    }
}