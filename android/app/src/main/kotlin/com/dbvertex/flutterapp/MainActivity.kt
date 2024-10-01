package com.dbvertex.flutterapp

import android.os.Bundle
import com.facebook.FacebookSdk
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Initialize the Facebook SDK
        FacebookSdk.sdkInitialize(applicationContext)
    }
}
