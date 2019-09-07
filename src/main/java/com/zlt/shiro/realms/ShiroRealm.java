package com.zlt.shiro.realms;

import com.zlt.pojo.User;
import com.zlt.service.UserService;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;
import java.util.Set;

/**
 * @author shushu
 * @date 2019-09-02-23:17
 */

public class ShiroRealm extends AuthorizingRealm {
    @Autowired
    UserService userService;
    //用于认证的方法
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        System.out.println("doGetAuthenticationInfo：" + token);
        //1.把AuthenticationToken 转换为UsernamePasswordToken
        UsernamePasswordToken upToken = (UsernamePasswordToken) token;
        //2.从UsernamePasswordToken 中未获取username
        String username = upToken.getUsername();
        //3.调用数据库的方法，从数据库中查询 username对应的用户记录
        User user = userService.findByUsername(username);
        //4.若用户不存在，则可以抛出UnknownAccountException 异常
        if (user==null) {
            throw new UnknownAccountException("用户不存在");
        }
        //5.根据用户信息的情况，决定是否需要抛出其他的AuthenticationException 异常。
        if (user.getLocked()==0) {
            throw new LockedAccountException("用户被锁定");
        }
        //6.根据用户的情况，来构建AuthenticationInfo 对象并返回。通常使用的实现类为：simpleAuthenticationInfo
        //以下信息是从数据库中获取的。
        //1）.principal：认证的实体信息。可以是username，也可以是数据表对应的用户的实体类对象。
        Object principal = user;
        //2）.credentials：密码。
        Object credentials = user.getPassword();

        //3）.realmName：当前realm对象的name.调用父类的getName（）方法即可
        String realmName = getName();
        //4）.盐值.
        ByteSource credentialsSalt = ByteSource.Util.bytes(user.getSalt());

        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(principal, credentials, credentialsSalt, realmName);
        return info;
    }

    //用于授权的方法。授权会被shiro回调的方法
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        //1.从Principalcollection中来获取登录用户的信息
        User principal = (User) principals.getPrimaryPrincipal();

        //2.利用登录的用户的信息来用户当前用户的角色或权限（可能需要查询数据库）
        Set<String> roles = new HashSet<>();
        roles.add("user");
        if ("admin".equals(principal.getUsername())){
            roles.add("admin");
        }

        //3.创建simpleAuthorizationInfo，并设留其roles 属性。
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roles);

        //4.返回simpleAuthorizationInfo 对象.
        return info;
    }
}
