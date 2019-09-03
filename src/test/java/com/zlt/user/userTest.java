package com.zlt.user;

import cn.hutool.crypto.SecureUtil;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

/**
 * @author shushu
 * @date 2019-08-30-16:33
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
@WebAppConfiguration
public class userTest {
    @Test
    public void m01(){
        String pwd= String.valueOf(SecureUtil.md5("1"));
        System.out.println(pwd);
    }
}
