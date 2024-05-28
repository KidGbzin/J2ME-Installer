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

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result -> when (call.method) {
                "Install" -> {
                    val filePath = call.arguments as? String
                    if (filePath != null) {
                        install(filePath, result)
                    }
                    else {
                        result.error("INVALID_ARGUMENT", "A file path must be provided!", null)
                    }
                }
                "GitHub" -> {
                    web("https://github.com/nikita36078/J2ME-Loader", result)
                }
                "PlayStore" -> {
                    playStore("market://details?id=ru.playsoftware.j2meloader", result)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun install(filePath: String, result: MethodChannel.Result) {
        val file = File(filePath)
        val intent = Intent(Intent.ACTION_VIEW)
        val uri = FileProvider.getUriForFile(this, "${BuildConfig.APPLICATION_ID}.fileprovider", file)
        try {
            intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            intent.setClassName("ru.playsoftware.j2meloader", "ru.playsoftware.j2meloader.MainActivity")
            intent.setDataAndType(uri, "application/java-archive")
            startActivity(intent)
            result.success(null)
        }
        catch (error: ActivityNotFoundException) {
            result.error("ACTIVITY_NOT_FOUND", "The system was unable to find J2ME Loader activity!", error.message)
        }
        catch (error: Exception) {
            result.error("UNEXPECTED_ERROR", "An unexpected error occurred while opening the J2ME Loader activity!", error.message)
        }
    }

    private fun playStore(url: String, result: MethodChannel.Result) {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        try {
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
            result.success(null)
        }
        catch (error: ActivityNotFoundException) {
            result.error("ACTIVITY_NOT_FOUND", "This device does not have Play Store installed!", error.message)
        }
        catch (error: Exception) {
            result.error("UNEXPECTED_ERROR", "An unexpected error occurred while opening the Play Store activity!", error.message)
        }
    }

    private fun web(url: String, result: MethodChannel.Result) {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        try {
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
            result.success(null)
        }
        catch (error: ActivityNotFoundException) {
            result.error("ACTIVITY_NOT_FOUND", "The system was unable to find J2ME Loader activity!", error.message)
        }
        catch (error: Exception) {
            result.error("UNEXPECTED_ERROR", "An unexpected error occurred while opening the web activity!", error.message)
        }
    }
}