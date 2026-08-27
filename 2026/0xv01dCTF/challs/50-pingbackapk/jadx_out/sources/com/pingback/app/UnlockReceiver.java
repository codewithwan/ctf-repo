package com.pingback.app;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.security.MessageDigest;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

/* JADX INFO: loaded from: classes.dex */
public class UnlockReceiver extends BroadcastReceiver {
    private static final byte[] IV = {15, 30, 45, 60, 75, 90, 105, 120, -121, -106, -91, -76, -61, -46, -31, -16};

    private static String getExpectedAuth() {
        return "SYNC-2026".concat("-PING");
    }

    private static int getExpectedSeq() {
        return 12 - 1;
    }

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        String stringExtra = intent.getStringExtra("auth");
        int intExtra = intent.getIntExtra("seq", 0);
        if (!getExpectedAuth().equals(stringExtra) || intExtra != getExpectedSeq()) {
            Log.w("PingBack", "auth_denied");
            return;
        }
        try {
            byte[] bArr = new byte[16];
            System.arraycopy(MessageDigest.getInstance("SHA-1").digest((stringExtra + Integer.toString(intExtra)).getBytes()), 0, bArr, 0, 16);
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            cipher.init(2, new SecretKeySpec(bArr, "AES"), new IvParameterSpec(IV));
            InputStream inputStreamOpen = context.getAssets().open("signal.enc");
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            byte[] bArr2 = new byte[1024];
            while (true) {
                int i = inputStreamOpen.read(bArr2);
                if (i == -1) {
                    inputStreamOpen.close();
                    Log.d("PingBack", new String(cipher.doFinal(byteArrayOutputStream.toByteArray())));
                    return;
                }
                byteArrayOutputStream.write(bArr2, 0, i);
            }
        } catch (Exception unused) {
            Log.e("PingBack", "decrypt_failed");
        }
    }
}
