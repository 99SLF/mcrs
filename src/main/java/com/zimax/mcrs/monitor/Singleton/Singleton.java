package com.zimax.mcrs.monitor.Singleton;

/**
 * @author 李伟杰
 * @date 2023/2/23 9:29
 */
public class Singleton {
    String name = null;

    private Singleton() {
    }

    private static volatile Singleton instance = null;

    public static Singleton getInstance() {
        if (instance == null) {
            synchronized (Singleton.class) {
                if (instance == null) {
                    instance = new Singleton();
                }
            }
        }
        return instance;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void printInfo() {
        System.out.println("the name is " + name);
    }

}