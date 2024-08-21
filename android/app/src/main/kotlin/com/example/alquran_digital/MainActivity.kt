package com.example.alquran_digital

import androidx.biometric.BiometricManager.Authenticators.BIOMETRIC_STRONG
import androidx.biometric.BiometricManager.Authenticators.DEVICE_CREDENTIAL
import androidx.biometric.BiometricPrompt
import androidx.biometric.BiometricPrompt.AUTHENTICATION_RESULT_TYPE_UNKNOWN
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterFragmentActivity() {
    private val channelName = "samples.invertase.io/biometrics"
    private lateinit var biometricsChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Initialize the method channel once the Flutter engine is attached.
        biometricsChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channelName
        )

        // Set a method call handler, whenever we invoke a method from Flutter
        // on "samples.invertase.io/biometrics" channel, this handler will be triggered.
        biometricsChannel.setMethodCallHandler { call, result ->
            if (call.method == "authenticateWithBiometrics") {
                authenticateWithBiometrics(result)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun authenticateWithBiometrics(result: MethodChannel.Result) {
    val biometricManager = androidx.biometric.BiometricManager.from(this)
    when (biometricManager.canAuthenticate(BIOMETRIC_STRONG or DEVICE_CREDENTIAL)) {
        androidx.biometric.BiometricManager.BIOMETRIC_SUCCESS -> {
            // Biometric authentication is available
            proceedWithBiometricAuthentication(result)
        }
        androidx.biometric.BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE ->
            result.error("NO_HARDWARE", "This device does not have biometric hardware.", null)
        androidx.biometric.BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE ->
            result.error("HW_UNAVAILABLE", "Biometric hardware is currently unavailable.", null)
        androidx.biometric.BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED ->
            result.error("AUTHFAILED", "No fingerprints enrolled.", null)
        else ->
            result.error("AUTHFAILED", "Biometric authentication is not available.", null)
    }
}

    private fun proceedWithBiometricAuthentication(result: MethodChannel.Result) {
        var resultSent = false
        val executor = ContextCompat.getMainExecutor(this)
        val biometricPrompt = BiometricPrompt(
            this, executor,
            object : BiometricPrompt.AuthenticationCallback() {
                override fun onAuthenticationError(
                    errorCode: Int,
                    errString: CharSequence
                ) {
                    super.onAuthenticationError(errorCode, errString)
                    if (errorCode != 10 && !resultSent) {
                        result.error("AUTHFAILED", errString.toString(), null)
                        resultSent = true
                    }
                }

                override fun onAuthenticationSucceeded(
                    authResult: BiometricPrompt.AuthenticationResult
                ) {
                    super.onAuthenticationSucceeded(authResult)
                    if (!resultSent) {
                        result.success(null)
                        resultSent = true
                    }
                    biometricsChannel.invokeMethod(
                        "authenticationResult",
                        authResult.authenticationType != AUTHENTICATION_RESULT_TYPE_UNKNOWN
                    )
                }

                override fun onAuthenticationFailed() {
                    super.onAuthenticationFailed()
                    if (!resultSent) {
                        result.error("AUTHFAILED", "Unknown", null)
                        resultSent = true
                    }
                }
            })

        val promptInfoBuilder = BiometricPrompt.PromptInfo.Builder()
            .setTitle("Biometric login")
            .setSubtitle("Log in using your biometric credential")
            .setConfirmationRequired(false)

        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.R) {
            promptInfoBuilder.setAllowedAuthenticators(BIOMETRIC_STRONG or DEVICE_CREDENTIAL)
        } else {
            promptInfoBuilder.setDeviceCredentialAllowed(true)
        }

        val promptInfo = promptInfoBuilder.build()

        biometricPrompt.authenticate(promptInfo)
    }
}
