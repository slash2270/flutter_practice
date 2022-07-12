package io.flutter.plugins

import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

import android.content.BroadcastReceiver
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES;
import io.flutter.plugin.common.EventChannel.StreamHandler
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry


/** BatteryPlugin  */
class BatteryPlugin internal constructor(registrar: PluginRegistry.Registrar) : MethodCallHandler, StreamHandler {
    private val registrar: PluginRegistry.Registrar
    private var chargingStateChangeReceiver: BroadcastReceiver? = null
    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method.equals("getBatteryLevel")) {
            val batteryLevel = batteryLevel
            if (batteryLevel != -1) {
                result.success(batteryLevel)
            } else {
                result.error("UNAVAILABLE", "Battery level not available.", null)
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onListen(arguments: Any?, events: EventSink) {
        chargingStateChangeReceiver = createChargingStateChangeReceiver(events)
        registrar
            .context()
            .registerReceiver(
                chargingStateChangeReceiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
    }

    override fun onCancel(arguments: Any?) {
        registrar.context().unregisterReceiver(chargingStateChangeReceiver)
        chargingStateChangeReceiver = null
    }

    private val batteryLevel: Int
        get() {
            var batteryLevel = -1
            val registrarContext: Context = registrar.context()
            batteryLevel = if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
                val batteryManager: BatteryManager = registrarContext.getSystemService(Context.BATTERY_SERVICE) as BatteryManager
                batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
            } else {
                val intent: Intent? = ContextWrapper(registrarContext)
                    .registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
                ((intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)?.times(100) ?: 0) /
                        intent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1)!!)
            }
            return batteryLevel
        }

    private fun createChargingStateChangeReceiver(events: EventSink): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent) {
                when (intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1)) {
                    BatteryManager.BATTERY_STATUS_CHARGING -> events.success("charging")
                    BatteryManager.BATTERY_STATUS_FULL -> events.success("full")
                    BatteryManager.BATTERY_STATUS_DISCHARGING -> events.success("discharging")
                    else -> events.error("UNAVAILABLE", "Charging status unavailable", null)
                }
            }
        }
    }

    companion object {
        /** Plugin registration.  */
        fun registerWith(registrar: PluginRegistry.Registrar) {
            val methodChannel = MethodChannel(registrar.messenger(), "plugins.flutter.io/battery")
            val eventChannel = EventChannel(registrar.messenger(), "plugins.flutter.io/charging")
            val instance = BatteryPlugin(registrar)
            eventChannel.setStreamHandler(instance)
            methodChannel.setMethodCallHandler(instance)
        }
    }

    init {
        this.registrar = registrar
    }
}