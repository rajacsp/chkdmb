<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="csp.db.*, java.util.*"
    pageEncoding="ISO-8859-1"%>

<%
	int entryId = Integer.parseInt(request.getParameter("dataId"));

	DBCon dbCon = DBCon.getto();
	HashMap<String, String> localMap = dbCon.getEntryDetailsByEntryId(entryId);
	String entryTag = localMap.get(DBC.ENTRY_GROUP);
%>

<div class="panel-body">
	<div id="message_holder">		
		<%=entryTag %>
	</div>
	<ul class="group_list">
<%
	/*
	 * Tags:
	 *	Personal
	 *  Financial
	 *  Educational
	 *  Funny/Relax 
	 *  Weird
	 *  Research
	 *  Exploring
	 *  Career
	 *  Dirty
	 *  Humanity
	 *  Physical/Health
	 *  Misc
	 */	 

	String[] tagArray = new String[]{"Personal", "Financial", "Educational", "Funny/Relax", "Weird", "Research", "Exploring", "Career", "Dirty", "Humanity", "Physical/Health", "Misc"};
	for(int i=0, tagLength=tagArray.length;i<tagLength;i++){
		String currentGroup = tagArray[i];
		if(entryTag.equalsIgnoreCase(currentGroup)){
			%>
			<li onClick="activatePanelTag(this);" id="subsection_group_list_<%=i%>" data-challenge-id="<%=entryId %>" data-tag-name="<%=tagArray[i] %>" class="active" >
				<%=tagArray[i] %>
				<span class=""></span>
			</li>
			<%		
		} else{
			%>	
			<li onClick="activatePanelTag(this);" id="subsection_group_list_<%=i%>" data-challenge-id="<%=entryId %>" data-tag-name="<%=tagArray[i] %>" >
				<%=tagArray[i] %>
				<span class=""></span>
			</li>
			<%
		}
	} %>
	</ul>
	<div class="btn btn-info btn-sm pull-right pointer" onClick="closeChallengePanel();">
		<span class="glyphicon glyphicon-asterisk"></span> Close
	</div>
</div>


		
	
