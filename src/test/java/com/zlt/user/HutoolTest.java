package com.zlt.user;

import cn.hutool.crypto.SecureUtil;
import org.junit.Test;

/**
 * @author shushu
 * @date 2019-09-02-8:38
 */

public class HutoolTest {
    @Test
    public void m01(){
        String pwd= SecureUtil.md5("1");
        System.out.println(pwd);
    }
    @Test
    public void m02(){
        String key="us";
        char[] chars = key.toCharArray();
        String username="%";
        for (char c:chars){
            username+=c+"%";
        }
        System.out.println(username);
    }
    @Test
    public void m03(){

    }
}
