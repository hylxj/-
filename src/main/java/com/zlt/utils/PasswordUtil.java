package com.zlt.utils;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

/**
 * @author huangyu
 * @date 2019-09-05-23:20
 */

public class PasswordUtil {
    public static String getMd5Passwword(String credentials,String salt){
        String hashAlgorithName = "MD5";
        int hashIterations = 1024;
       return String.valueOf(new SimpleHash(hashAlgorithName, credentials, ByteSource.Util.bytes(salt), hashIterations));
    }

    public static void main(String[] args) {
        System.out.println(getMd5Passwword("123456","gx user"));
        System.out.println("43b9d50f0cf241aefebff60f4436d4b9".equals(getMd5Passwword("111111","user")));
    }
}
