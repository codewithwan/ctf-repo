package los.illuminados;

import android.content.Context;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/* JADX INFO: loaded from: classes.dex */
public class IlluminadosDecoder {
    public static byte[] decryptBundle(byte[] bArr, byte[] bArr2) {
        int length = bArr.length;
        byte[] bArr3 = new byte[length];
        int i = 0;
        int length2 = length - 1;
        while (i < length2) {
            int i2 = i + 1;
            bArr3[i] = bArr[i2];
            bArr3[i2] = bArr[i];
            i += 2;
            length2 = bArr.length - 1;
        }
        int length3 = bArr.length;
        if (length3 % 2 != 0) {
            int i3 = length3 - 1;
            bArr3[i3] = bArr[i3];
        }
        int length4 = bArr3.length;
        for (int i4 = 0; i4 < length4; i4++) {
            bArr3[i4] = (byte) (bArr2[i4 % bArr2.length] ^ bArr3[i4]);
        }
        return bArr3;
    }

    public static byte[] deriveKey(Context context) throws NoSuchAlgorithmException, InvalidKeyException {
        String strConcat = context.getPackageName().concat("|Illuminados").concat("Receiver");
        String strConcat2 = "com.los.".concat("illuminados.").concat("RECEIVE");
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(new SecretKeySpec(strConcat2.getBytes(), "HmacSHA256"));
        return mac.doFinal(strConcat.getBytes());
    }
}
