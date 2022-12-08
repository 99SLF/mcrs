package com.zimax.cap.common.muo;

/**
 * @author 苏尚文
 * @date 2022/12/7 9:35
 */
public class CustomObjectProviderProvider {

    private static ICustomObjectProvider provider;

    public static ICustomObjectProvider getProvider() {
        if (provider == null) {
            provider = new DefaultCustomObjectProvider();
        }
        return provider;
    }

    public static void setProvider(ICustomObjectProvider newProvider) {
        provider = newProvider;
    }
}
