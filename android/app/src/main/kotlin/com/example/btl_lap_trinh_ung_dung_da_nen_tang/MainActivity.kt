package vn.io.catan.antifakebook

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "afb_app_retain").apply {
        setMethodCallHandler { method, result ->
            if (method.method == "sendToBackground") {
                moveTaskToBack(true)
            }
        }
    }
}
}
