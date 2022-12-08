package com.zimax.cap.utility;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.*;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:39
 */
public final class ServiceLoader<S> implements Iterable<S> {

    private static final String PREFIX = "META-INF/services/";

    private Class<S> service;

    private ClassLoader loader;

    private LinkedHashMap<String, S> providers = new LinkedHashMap();

    private Set<CompareObject> services = new TreeSet();

    private Set<String> namePool = new HashSet();

    public void reload() {
        this.providers.clear();
        try {
            String fullName = "META-INF/services/" + this.service.getName();
            Enumeration<URL> configs = this.loader.getResources(fullName);
            if (null != configs) {
                while (configs.hasMoreElements()) {
                    URL url = (URL) configs.nextElement();
                    parse(this.service, url);
                }
            }
        } catch (IOException x) {
            fail(this.service, "Error locating configuration files", x);
        }
    }

    private Iterator<String> parse(Class service, URL u)
            throws ServiceConfigurationError {
        InputStream in = null;
        BufferedReader r = null;
        List<String> names = new ArrayList<String>();
        try {
            in = u.openStream();
            r = new BufferedReader(new InputStreamReader(in, "utf-8"));
            int lc = 1;
            while ((lc = parseLine(service, u, r, lc)) >= 0) {
            }
            return names.iterator();
        } catch (IOException x) {
            fail(service, "Error reading configuration file", x);
        } finally {
            try {
                if (r != null) {
                    r.close();
                }
                if (in != null) {
                    in.close();
                }
            } catch (IOException y) {
                fail(service, "Error closing configuration file", y);
            }
        }
        return null;
    }

    private ServiceLoader(Class<S> svc, ClassLoader cl) {
        this.service = svc;
        this.loader = cl;
        reload();
    }

    public Iterator<S> iterator() {

        final Iterator iterator = this.services.iterator();

        return new Iterator() {
            public boolean hasNext() {
                return iterator.hasNext();
            }

            public S next() {
                ServiceLoader.CompareObject compareObject = (ServiceLoader.CompareObject) iterator
                        .next();
                try {
                    return ServiceLoader.this.service.cast(Class
                            .forName(compareObject.name, true,
                                    ServiceLoader.this.loader).newInstance());
                } catch (ClassNotFoundException x) {
                    ServiceLoader.fail(ServiceLoader.this.service, "Provider "
                            + compareObject.name + " not found");
                } catch (Throwable x) {
                    ServiceLoader.fail(ServiceLoader.this.service, "Provider "
                            + compareObject.name
                            + " could not be instantiated: " + x, x);
                }
                throw new Error();
            }

            public void remove() {
                throw new UnsupportedOperationException();
            }
        };
    }

    private static void fail(Class service, String msg, Throwable cause)
            throws ServiceConfigurationError {
        throw new ServiceConfigurationError(service.getName() + ": " + msg,
                cause);
    }

    private static void fail(Class service, String msg)
            throws ServiceConfigurationError {
        throw new ServiceConfigurationError(service.getName() + ": " + msg);
    }

    private static void fail(Class service, URL u, int line, String msg)
            throws ServiceConfigurationError {
        fail(service, u + ":" + line + ": " + msg);
    }

    private int parseLine(Class service, URL u, BufferedReader r, int lc)
            throws IOException, ServiceConfigurationError {
        String ln = r.readLine();
        if (ln == null) {
            return -1;
        }
        int ci = ln.indexOf('#');
        String property = StringUtil.substringAfter(ln, "#");
        int priority = 0;
        if (StringUtil.isNotEmpty(property)) {
            try {
                String[] entries = StringUtil.split(property, ',');
                for (int i = 0; i < entries.length; i++) {
                    String entry = entries[i];
                    String key = StringUtil.substringBefore(entry, "=");
                    if ("priority".equals(key)) {
                        String value = StringUtil.substringAfter(entry, "=");
                        priority = toInt(value);
                    }
                }
            } catch (Exception e) {
            }
        }
        if (ci >= 0) {
            ln = ln.substring(0, ci);
        }
        ln = ln.trim();
        int n = ln.length();
        if (n != 0) {
            if ((ln.indexOf(' ') >= 0) || (ln.indexOf('\t') >= 0)) {
                fail(service, u, lc, "Illegal configuration-file syntax");
            }
            int cp = ln.codePointAt(0);
            if (!Character.isJavaIdentifierStart(cp)) {
                fail(service, u, lc, "Illegal provider-class name: " + ln);
            }
            for (int i = Character.charCount(cp); i < n; i += Character
                    .charCount(cp)) {
                cp = ln.codePointAt(i);
                if ((!Character.isJavaIdentifierPart(cp)) && (cp != 46)) {
                    fail(service, u, lc, "Illegal provider-class name: " + ln);
                }
            }
            if ((!this.providers.containsKey(ln))
                    && (!this.namePool.contains(ln))) {
                this.namePool.add(ln);

                CompareObject compareObject = new CompareObject();
                compareObject.name = ln;
                compareObject.priority = priority;

                this.services.add(compareObject);
            }
        }
        return lc + 1;
    }

    public static <S> ServiceLoader<S> load(Class<S> service, ClassLoader loader) {
        return new ServiceLoader(service, loader);
    }

    public static <S> ServiceLoader<S> load(Class<S> service) {
        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        return load(service, cl);
    }

    public static <S> ServiceLoader<S> loadInstalled(Class<S> service) {
        ClassLoader cl = ClassLoader.getSystemClassLoader();
        ClassLoader prev = null;
        while (cl != null) {
            prev = cl;
            cl = cl.getParent();
        }
        return load(service, prev);
    }

    public String toString() {
        return "java.util.ServiceLoader[" + this.service.getName() + "]";
    }

    private static class CompareObject implements Comparable {
        int priority;
        String name;

        public int compareTo(Object o) {
            CompareObject compareObject = (CompareObject) o;

            int ret = compareObject.priority - this.priority;
            if (ret == 0) {
                return 1;
            }
            return ret;
        }
    }

    private int toInt(String str) {
        if (str == null) {
            return 0;
        }
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException nfe) {
        }
        return 0;
    }

}
