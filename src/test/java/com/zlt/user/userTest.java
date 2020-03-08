package com.zlt.user;

import com.zlt.dao.UserDao;
import com.zlt.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.net.MalformedURLException;
import java.net.URL;

/**
 * @author shushu
 * @date 2019-08-30-16:33
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class userTest {
    @Resource
    private UserDao userDao;
    @Autowired
    private UserService userService;
    @Test
    public void m01(){
        try {
            URL url=new URL("www.baidu.com");
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }

    }
}
