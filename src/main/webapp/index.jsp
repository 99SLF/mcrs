<%@page pageEncoding="UTF-8"%>
<%
	String url = request.getContextPath() + "/std/index.jsp";
%>
<script>
	if (window.parent) {
		window.parent.location = "<%=url %>";
	} else {
		window.location = "<%=url %>";
	}
</script>