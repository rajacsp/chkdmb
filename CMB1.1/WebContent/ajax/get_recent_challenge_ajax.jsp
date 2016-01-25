<%
session = request.getSession(false);
String XYZ = (String) session.getAttribute("XYZ");

if(XYZ == null){
	response.sendRedirect("index.jsp");
}
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="csp.db.*, java.util.*, csp.pojo.chkdlib.*"
    pageEncoding="ISO-8859-1"%> 
<%
String dataIdString = request.getParameter("dataId");
int dataId = -1;

if(dataIdString != null){
	dataId = Integer.parseInt(dataIdString);
}

DBCon dbCon = DBCon.getto();
int userid = Integer.parseInt((String) session.getAttribute("userid"));
HashMap<String, String> dbEntryMap = null;
if(dataId != -1){ //data id is available 
	dbEntryMap = dbCon.getEntryDetailsByEntryId(dataId);	
}else{
	dbEntryMap = dbCon.getFristRecentEntryByUserId(userid);
}

HashMap<String, String> localMap = dbEntryMap;	
String entryStartDate = localMap.get(DBC.ENTRY_START_DATE);
String entryLastUpdatedDate = localMap.get(DBC.ENTRY_LAST_UPDATED_DATE);
String entryEndDate = localMap.get(DBC.ENTRY_END_DATE);
String entryId = localMap.get(DBC.ENTRY_ID);
String startedTimmer = Timmer.getPastTimeCustom(entryStartDate, "ago");
String lastUpdatedTimmer = Timmer.getPastTimeCustom(entryLastUpdatedDate, "ago");
String futureTimmer = Timmer.getFutureTimeCustom(entryEndDate, "in");
String entryName = localMap.get(DBC.ENTRY_NAME);
String entryGroup = localMap.get(DBC.ENTRY_GROUP);
int isFinished = Integer.parseInt(((String)localMap.get(DBC.IS_FINISHED)));
String isFinishedString = "No";
String checkClassString = "";
if(isFinished == 1){
	isFinishedString = "Yes";
	checkClassString = "class=\"user_checked\"";
}		

String addedOrUpdated = "Added";
boolean isUpdated = false;
if(Timmer.getTimeDiff(entryStartDate, entryLastUpdatedDate) > 0){
	isUpdated = true;
	addedOrUpdated = "Updated";
}
%>
<div class="panel-heading">
	<div class="row panel-title title-icons">
		<div class="col-lg-8 icons-left-col">
			<div class="panel-title-header"><%=entryName %></div>
			<div class="panel-title small" style="font-weight:100; font-style:italic; color:#94c5f0"><%=addedOrUpdated %> <%=lastUpdatedTimmer %></div>
			<div class="panel-title small" style="font-weight:100; font-style:italic; color:#94c5f0">Ending: <%=futureTimmer %></div>
		</div>
		<div class="col-lg-4 icons-right-col">
			<a id="delete_challenges" data-id="0" href="javascript:void(0);" onClick="delete_challenges(<%=entryId %>);" class="pull-right"><img src="images/delete_bin.png" class="glyphicon-size1"></a>
			<a id="update_challenges" data-id="0" href="javascript:void(0);" onClick="update_challenges(<%=entryId %>);" class="pull-right"><img src="images/pencil_icon.png" class="glyphicon-size1"></a>
			<a id="update_save_challenges" style="display:none" data-id="<%=entryId %>" href="javascript:void(0);" onClick="update_save_challenges(<%=entryId %>);" class="pull-right"><span class="glyphicon glyphicon-ok text-success glyphicon-size2"></span></a>
			<a id="update_cancel_challenges" style="display:none" data-id="<%=entryId %>" href="javascript:void(0);" onClick="update_cancel_challenges(<%=entryId %>);" class="pull-right"><span class="glyphicon glyphicon-ban-circle text-warning glyphicon-size2"></span></a>
		</div>
	</div>
	<div class="clearfix"></div>
</div>
<div class="panel-body">
	<!-- Load Icons Set for Recent Challenge -->
	<ul class="icons-holder">
		<li><a href="javascript:void(0);" id="challengePanelOne" class="" onClick="challengePanelOne(<%=entryId %>);" data-id="<%=entryId %>"><img src="images/panel-icon-01.png" alt="Timer" title="Timer"></a></li>
		<!-- <li><a href="javascript:void(0);" id="challengePanelTwo" class="" onClick="challengePanelTwo(<%=entryId %>);" data-id="<%=entryId %>"><img src="images/panel-icon-02.png" alt="P" title="P"></a></li>-->
		<li><a href="javascript:void(0);" id="challengePanelThree" class="" onClick="challengePanelThree(<%=entryId %>);" data-id="<%=entryId %>"><img src="images/panel-icon-03.png" alt="G" title="G"></a></li>
		<!-- <li><a href="javascript:void(0);" id="challengePanelFour" class="" onClick="challengePanelFour(<%=entryId %>);" data-id="<%=entryId %>"><img src="images/panel-icon-04.png" alt="Group" title="Group"><span class="number">3</span></a></li>-->
    </ul>
    <div class="clearfix"></div>
</div>