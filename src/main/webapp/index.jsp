<%@page pageEncoding="UTF-8"%>
<%
	String url = request.getContextPath() + "/coframe/auth/login.jsp";
%>
<script>
	if (window.parent) {
		window.parent.location = "<%=url %>";
	} else {
		window.location = "<%=url %>";
	}
</script>