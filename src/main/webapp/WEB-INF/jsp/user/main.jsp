<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
欢迎<shiro:principal/>

<shiro:hasRole name="admin">
    你有admin的角色
</shiro:hasRole>

<shiro:hasPermission name="/user/add">
    你有/user/add的权限
</shiro:hasPermission>
</body>
</html>
