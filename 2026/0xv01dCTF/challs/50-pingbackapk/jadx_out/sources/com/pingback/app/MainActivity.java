package com.pingback.app;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

/* JADX INFO: loaded from: classes.dex */
public class MainActivity extends Activity {
    @Override // android.app.Activity
    protected void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        TextView textView = new TextView(this);
        textView.setText("PingBack Network Monitor v2.0\n\nListening for unlock signals...");
        setContentView(textView);
    }
}
