<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<html>
<head>
    <title>Test Account</title>
</head>
<body>

    <h2>Session Information</h2>

    <c:if test="${not empty sessionScope.login_user_id}">
        <p>User ID: ${sessionScope.login_user_id}</p>
    </c:if>

    <c:if test="${not empty sessionScope.login_user_level}">
        <p>User Level: ${sessionScope.login_user_level}</p>
    </c:if>

    <c:if test="${not empty sessionScope.login_user_name}">
        <p>User Name: ${sessionScope.login_user_name}</p>
    </c:if>

    <c:if test="${not empty sessionScope.login_user_seq}">
        <p>User Seq: ${sessionScope.login_user_seq}</p>
    </c:if>

</body>
</html>
