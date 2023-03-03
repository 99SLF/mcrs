package com.zimax.license;

import de.schlichtherle.license.LicenseParam;

/**
 * de.schlichtherle.license.LicenseManager的单例
 */
public class LicenseManagerHolder {

    private static volatile CustomLicenseManager CUSTOMLICENSEMANAGER;

    public static CustomLicenseManager getInstance(LicenseParam param){
        if(CUSTOMLICENSEMANAGER == null){
            synchronized (LicenseManagerHolder.class){
                if(CUSTOMLICENSEMANAGER == null){
                    CUSTOMLICENSEMANAGER = new CustomLicenseManager(param);
                }
            }
        }
        return CUSTOMLICENSEMANAGER;
    }

}
