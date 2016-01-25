<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="csp.db.*, java.util.*, csp.pojo.chkdlib.*"
    pageEncoding="ISO-8859-1"%>
    
<%
session = request.getSession(false);
String XYZ = (String) session.getAttribute("XYZ");

if(XYZ == null){
	response.sendRedirect("index.jsp");
}
%>    
<%
String dataIdString = request.getParameter("dataId");
int dataId = -1;

if(dataIdString != null){
	dataId = Integer.parseInt(dataIdString);
}

DBCon dbCon = DBCon.getto();
int userid = Integer.parseInt((String) session.getAttribute("userid"));
List<HashMap<String, String>> dbEntryList = dbCon.getRecentEntriesWithoutCurrentEntryByUserId(userid, dataId);

for(int i=0,eLength = dbEntryList.size(); i<eLength;i++){	
	HashMap<String, String> localMap = dbEntryList.get(i);	
	String entryStartDate = localMap.get(DBC.ENTRY_START_DATE);
	String entryEndDate = localMap.get(DBC.ENTRY_END_DATE);
	String entryId = localMap.get(DBC.ENTRY_ID);
	String pastTimmer = Timmer.getPastTimeCustom(entryStartDate);
	String futureTimmer = Timmer.getFutureTimeCustom(entryEndDate);
	String entryName = localMap.get(DBC.ENTRY_NAME);
	String entryGroup = localMap.get(DBC.ENTRY_GROUP);
	int isFinished = Integer.parseInt(((String)localMap.get(DBC.IS_FINISHED)));
	String isFinishedString = "No";
	String checkClassString = "";
	if(isFinished == 1){
		isFinishedString = "Yes";
		checkClassString = "class=\"user_checked\"";
	}
%>
<!-- challenge(<%=i%>) -row -->
<div class="row"> 
	<div class="col1" data-id="<%=entryId%>" id="check_box_<%=entryId%>" onmouseover="toggleCheckBox(<%=entryId%>);" onmouseout="toggleCheckBox(<%=entryId%>);" onclick="checkChallenge(<%=entryId%>);">
		<span id="check_span_<%=entryId %>" <%=checkClassString %> ></span>
	</div>
	<div class="col2 other_challenges_rows" data-id="<%=entryId%>" onclick="loadChallenge(<%=entryId%>);" >
		<%=entryName %> 	
	</div> 
</div>
<!-- challenge(<%=i%>) -row -->
<%} %>



