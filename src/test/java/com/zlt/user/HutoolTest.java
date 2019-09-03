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
}
