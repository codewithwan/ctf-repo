package los.illuminados;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

/* JADX INFO: loaded from: classes.dex */
public class IlluminadosReceiver extends BroadcastReceiver {
    private static final String TAG = "LosIlluminados";

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) throws NoSuchAlgorithmException, InvalidKeyException, IOException {
        String action = intent.getAction();
        if (action == null || !action.equals("com.los.".concat("illuminados.").concat("RECEIVE"))) {
            return;
        }
        byte[] bArrDeriveKey = IlluminadosDecoder.deriveKey(context);
        InputStream inputStreamOpen = context.getAssets().open("illuminados_signal.bin");
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        byte[] bArr = new byte[1024];
        while (true) {
            int i = inputStreamOpen.read(bArr, 0, 1024);
            if (i <= 0) {
                break;
            } else {
                byteArrayOutputStream.write(bArr, 0, i);
            }
        }
        byte[] byteArray = byteArrayOutputStream.toByteArray();
        if (byteArray[5] == 1) {
            int length = byteArray.length - 7;
            byte[] bArr2 = new byte[length];
            System.arraycopy(byteArray, 7, bArr2, 0, length);
            Log.d(TAG, new String(IlluminadosDecoder.decryptBundle(bArr2, bArrDeriveKey)));
        }
    }
}
