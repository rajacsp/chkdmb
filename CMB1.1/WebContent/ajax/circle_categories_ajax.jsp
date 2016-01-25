<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="csp.corejavatest.*"
    pageEncoding="ISO-8859-1"%>


<div class="panel-body">
	<ul class="category_list">
<%
	String[] circleArray = new String[]{"Friends", "Family", "Colleagues", "Gym"};
	for(int i=0, circlesLength=circleArray.length;i<circlesLength;i++){
		String classString = "class=\"active\"";
%>
	<li onClick="activateTagCategory(this);" id="subsection_group_list_<%=i %>" data-img="panel-icon-02.png" <%=classString %> >
		<%=circleArray[i] %>
		<span class=""></span>
	</li>	
<% } %>
	</ul>
	<div class="btn btn-info btn-sm pull-right pointer" onClick="closeChallengePanel();">
		<span class="glyphicon glyphicon-asterisk"></span>
		Close
	</div>
</div>