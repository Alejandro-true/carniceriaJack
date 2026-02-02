package com.unu.poowebmodalga.utilitarios;

import java.util.List;

public class UtilsJson {

    // Escapa los caracteres especiales mínimos para JSON
    public static String jsonEscape(String s) {
        if (s == null) return "";
        StringBuilder sb = new StringBuilder(s.length() + 16);
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '\"': sb.append("\\\""); break;
                case '\\': sb.append("\\\\"); break;
                case '\b': sb.append("\\b"); break;
                case '\f': sb.append("\\f"); break;
                case '\n': sb.append("\\n"); break;
                case '\r': sb.append("\\r"); break;
                case '\t': sb.append("\\t"); break;
                default:
                    // caracteres de control Unicode
                    if (c < 0x20) {
                        sb.append(String.format("\\u%04x", (int)c));
                    } else {
                        sb.append(c);
                    }
            }
        }
        return sb.toString();
    }

    // Genera un array JSON de cadenas: ["Perú","Chile","México"]
    public static String jsonArrayStrings(List<String> items) {
        StringBuilder sb = new StringBuilder();
        sb.append('[');
        if (items != null) {
            for (int i = 0; i < items.size(); i++) {
                if (i > 0) sb.append(',');
                sb.append('\"').append(jsonEscape(items.get(i))).append('\"');
            }
        }
        sb.append(']');
        return sb.toString();
    }

    // Genera un array JSON de enteros: [5,3,1]
    public static String jsonArrayInts(List<Integer> items) {
        StringBuilder sb = new StringBuilder();
        sb.append('[');
        if (items != null) {
            for (int i = 0; i < items.size(); i++) {
                if (i > 0) sb.append(',');
                Integer v = items.get(i);
                sb.append(v == null ? 0 : v);
            }
        }
        sb.append(']');
        return sb.toString();
    }

    // (Opcional) Si luego tienes totales tipo long
    public static String jsonArrayLongs(List<Long> items) {
        StringBuilder sb = new StringBuilder();
        sb.append('[');
        if (items != null) {
            for (int i = 0; i < items.size(); i++) {
                if (i > 0) sb.append(',');
                Long v = items.get(i);
                sb.append(v == null ? 0 : v);
            }
        }
        sb.append(']');
        return sb.toString();
    }
}

