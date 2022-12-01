<%@page pageEncoding="UTF-8"%>
<%
	String url = request.getContextPath() + "/coframe/rights/role/role_manager.jsp";
%>
<script>
	if (window.parent) {
		window.parent.location = "<%=url %>";
	} else {
		window.location = "<%=url %>";
	}
</script>