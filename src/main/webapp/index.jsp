<%@page pageEncoding="UTF-8"%>
<%
	String url = request.getContextPath() + "/coframe/dict/dict_manager.jsp";


%>
<script>
	if (window.parent) {
		window.parent.location = "<%=url %>";
	} else {
		window.location = "<%=url %>";
	}
</script>