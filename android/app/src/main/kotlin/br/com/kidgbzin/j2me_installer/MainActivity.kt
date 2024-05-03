package br.com.kidgbzin.j2me_installer

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.util.Log
import androidx.core.content.FileProvider
import java.io.File
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "br.com.kidgbzin.j2me_loader/install"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "openJarFile" -> {
                    val filePath = call.arguments as String
                    openJarFile(filePath)
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun openJarFile(filePath: String) {
        val file = File(filePath)
        val uri = FileProvider.getUriForFile(this, "${BuildConfig.APPLICATION_ID}.fileprovider", file)
        val intent = Intent(Intent.ACTION_VIEW)
        
        intent.setDataAndType(uri, "application/java-archive")
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)

        try {
            intent.setClassName("ru.playsoftware.j2meloader", "ru.playsoftware.j2meloader.MainActivity")
            startActivity(intent)
        }

        catch (error: Exception) {
            Log.e("MainActivity", "The system was unable to find J2ME Loader activity!", error)

            openPlayStore("ru.playsoftware.j2meloader")
        }
    }

    private fun openPlayStore(packageName: String) {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=$packageName"))
        
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        
        try {
            startActivity(intent)
        }
        
        catch (error: ActivityNotFoundException) {
            Log.e("MainActivity", "This device doesn't have the PlayStore installed!", error)
        }
    }
}