<%
session = request.getSession(false);
String XYZ = (String) session.getAttribute("XYZ");

if(XYZ == null){
	response.sendRedirect("index.jsp");
}
%>
<%@ include file="header.jsp" %>
    <!-- container -->
    <div class="container">
    	<div class="col-lg-12" style="text-align:right;">
    		<a href="kill.jsp">
    			<img src="images/logout_icon_1.png" />
    		</a>
    	</div>    	

	  <!-- form -->
      <form method="post" enctype="multipart/form-data" class="form-signin" id="form1" role="form">
      	<div class="input-sub-button">
        <input type="text" name="activity" id="activity" class="form-control input-field-box" placeholder="Type your challenge..." autofocus>
        <img id="activity_button" class="input-field-box-button" src="images/plus-icon.png" width="25" height="25">
        </div>
      </form>
      <!-- /form -->
      
      <!-- result -->
      <div id="result_div" style="display:none;"></div>
      <!-- /result -->
      
      
      <div class="col-lg-12">
      	
        <!-- recent challenge panel -->
      	<section id="recent_challenges_panel" class="first_heading">
        	<h3>Recent Challenge</h3>
            <div id="recent_challenges_list" class="panel panel-default"></div>
        </section>
      	<!-- /recent challenge panel -->
        
        <!-- recent challenge sub panels sections -->
      	<section id="recent_challenges_subsection_panel" style="display:none;">
        	<div class="threads-line"><span class="pull-left"></span><span class="pull-right"></span></div>
            <div id="subsection_panel_content" class="panel panel-default">
            </div>
        </section>
        <!-- /recent challenge sub panels sections -->
        
        <!-- other challenges panel -->
        <section class="second_heading">
            <h3>Other Challenges</h3>
        	<div id="other_challenges" class="col-sm-12"></div>
        </section>
        <!-- /other challenges panel -->
        
      </div>

    </div>
    
    
    
    <!-- /container -->
<script src="js/app.js"></script>
<%@ include file="footer.jsp" %>