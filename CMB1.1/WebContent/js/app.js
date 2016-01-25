
var LOADER_IMAGE = '<img src="images/loader.gif" class="ajax_loader1">';
var NO_RECORDS_YET = 'No records yet';
var POST = "POST";


var RESULT_DIV_JQ = '#result_div';
var OTHER_CHALLENGES_JQ = '#other_challenges';
var RECENT_CHALLENGES_LIST = '#recent_challenges_list';
var RECENT_CHALLENGE_PANEL_H3 = '#recent_challenges_panel h3';
var UPDATE_CHALLENGES_JQ = '#update_challenges';
var UPDATE_SAVE_CHALLENGES_JQ = '#update_save_challenges';
var UPDATE_CANCEL_CHALLENGES_JQ = '#update_cancel_challenges';

$(document).ready(function(e) {
	
	// when the activity button clicked
    $('#activity_button').click(function(e){
		e.preventDefault();
		$(RESULT_DIV_JQ).html(LOADER_IMAGE);
		var activity = $('#activity').val();
		
		//alert(activity);
		if(activity == '') {
			$('#activity').focus();
			$(RESULT_DIV_JQ).fadeOut();
		} else {
			$(RESULT_DIV_JQ).fadeIn();			
			//$(RESULT_DIV_JQ).hide();
			$.ajax({
				url : "ajax/activity_ajax.jsp",
				type: POST,
				data : { activity: activity },
				success: function(data, textStatus, jqXHR)
				{
					$(RESULT_DIV_JQ).html(data);
					//$(RESULT_DIV_JQ).fadeIn();
					$(RESULT_DIV_JQ).delay(1000).fadeOut(1000);
					
					loadRecentActivity();
					loadActivities();
				},
				error: function (jqXHR, textStatus, errorThrown)
				{
					$(RESULT_DIV_JQ).html(data);
					$(RESULT_DIV_JQ).fadeIn();
				}
			});			
		} //-if-else(activity == '')
	});
    
    /*
    // check_box_1 mouseover
    $("div[id^='check_box_']").hover(function(){
    	alert('ss');
    });
    */
	
	//Default Initialisation - do not change this
	setTimeout(function() {
        loadActivities();
		loadRecentActivity();
    }, 300);

});

var checkBoxFlag = false;
function toggleCheckBox(id){
	if(!checkBoxFlag){
		$("#check_span_"+id).addClass( "user_checked" );
		checkBoxFlag = true;
	} else {
		$("#check_span_"+id).removeClass( "user_checked" );
		checkBoxFlag = false;
	}
}

function checkChallenge(id){
	var formData = { entryId: id };        				   
	$.ajax({
		url : "ajax/check_it.jsp",
		type: "POST",
		data : formData,
		success: function(data, textStatus, jqXHR)
		{
	    	$(RESULT_DIV_JQ).html(data);
	    	$(RESULT_DIV_JQ).delay(1000).show();
	    	$(RESULT_DIV_JQ).delay(1000).fadeOut(1000);
	    	
	    	loadActivities();
		},
		error: function (jqXHR, textStatus, errorThrown)
		{
			alert('error[delete] : ');
		}
	});
}

//Acitivities
function loadActivities() {
	
	$(OTHER_CHALLENGES_JQ).html(LOADER_IMAGE);
	$(OTHER_CHALLENGES_JQ).fadeIn();
	
	var formData = { };        				   
	$.ajax({
		url : "ajax/get_activities_ajax.jsp",
		type: POST,
		data : formData,
		success: function(data, textStatus, jqXHR)
		{
			$(OTHER_CHALLENGES_JQ).hide();
			$(OTHER_CHALLENGES_JQ).html(data);
			$(OTHER_CHALLENGES_JQ).slideDown();
		},
		error: function (jqXHR, textStatus, errorThrown)
		{
			$(OTHER_CHALLENGES_JQ).html(NO_RECORDS_YET);
		}
	});
}


//Most Recent Activity
function loadRecentActivity() {	
	
	$(RECENT_CHALLENGES_LIST).html(LOADER_IMAGE);
	$(RECENT_CHALLENGES_LIST).fadeIn();
	var formData = { };        				   
	$.ajax({
		url : "ajax/get_recent_challenge_ajax.jsp",
		type: POST,
		data : formData,
		success: function(data, textStatus, jqXHR)
		{
			$(RECENT_CHALLENGES_LIST).hide();
			$(RECENT_CHALLENGES_LIST).html(data);
			$(RECENT_CHALLENGES_LIST).slideDown();
		},
		error: function (jqXHR, textStatus, errorThrown)
		{
			$(RECENT_CHALLENGES_LIST).html(NO_RECORDS_YET);
		}
	});
}

//Delete Activity
function delete_challenges(dataId) {
	closeChallengePanel();
	$(RESULT_DIV_JQ).html(LOADER_IMAGE);
	$(RESULT_DIV_JQ).fadeIn();
	
	var formData = { dataId:dataId };        				   
	$.ajax({
		url : "ajax/delete_challenge_ajax.jsp",
		type: POST,
		data : formData,
		success: function(data, textStatus, jqXHR)
		{
			$(RESULT_DIV_JQ).html(data);
			$(RESULT_DIV_JQ).delay(1000).fadeOut(1000);
			$(RECENT_CHALLENGES_LIST).slideUp('fast', function(){
				loadActivities();
				loadRecentActivity();
			});
		},
		error: function (jqXHR, textStatus, errorThrown)
		{
			$(RECENT_CHALLENGES_LIST).html(NO_RECORDS_YET);
		}
	});
}

//Update Activity
function update_challenges(dataId) {
	closeChallengePanel();
	$(RECENT_CHALLENGES_LIST).addClass('highlight_blue');
	$(RECENT_CHALLENGE_PANEL_H3).addClass('highlight_blue_text');
	$(UPDATE_CHALLENGES_JQ).hide();
	$(UPDATE_SAVE_CHALLENGES_JQ).fadeIn();
	$(UPDATE_CANCEL_CHALLENGES_JQ).fadeIn();
	$(RECENT_CHALLENGE_PANEL_H3).html('Updating Challenge');
	var htmlString = $('#recent_challenges_list .panel-title-header').html();
	$('#recent_challenges_list .panel-title-header').html('<input type="text" id="update_challenge_name" name="update_challenge_name" value="'+htmlString+'" class="form-control">');
}

//Update Challenges
function update_save_challenges(dataId) {
	closeChallengePanel();
	$(RECENT_CHALLENGES_LIST).removeClass('highlight_blue');
	$(RECENT_CHALLENGE_PANEL_H3).removeClass('highlight_blue_text');
	$(UPDATE_SAVE_CHALLENGES_JQ).hide();
	$(UPDATE_CANCEL_CHALLENGES_JQ).hide();
	$(UPDATE_CHALLENGES_JQ).fadeIn();
	$(RECENT_CHALLENGE_PANEL_H3).html('Recent Challenges');
	var htmlString = $('#update_challenge_name').val();
	$(RESULT_DIV_JQ).html(LOADER_IMAGE);
	$(RESULT_DIV_JQ).fadeIn();
	
	var formData = { dataId:dataId, dataText:htmlString };        				   
	$.ajax({
		url : "ajax/update_recent_challenges_ajax.jsp",
		type: POST,
		data : formData,
		success: function(data, textStatus, jqXHR)
		{
			$('#recent_challenges_list .panel-title-header').html(htmlString);
			$(RESULT_DIV_JQ).html(data);
			$(RECENT_CHALLENGES_LIST).focusout();
			$(RESULT_DIV_JQ).delay(1000).fadeOut(1000);
			loadRecentActivity();
			loadActivities();
		},
		error: function (jqXHR, textStatus, errorThrown)
		{
			$(RECENT_CHALLENGES_LIST).html(NO_RECORDS_YET);
		}
	});	
}

var previousTextOnChallenge = "";
function getFirstTimeFocusValue(){
	previousTextOnChallenge = $('#update_challenge_name').val();
}

//Cancel Challenges
function update_cancel_challenges(dataId) {
	closeChallengePanel();
	$(RECENT_CHALLENGES_LIST).removeClass('highlight_blue');
	$(RECENT_CHALLENGE_PANEL_H3).removeClass('highlight_blue_text');
	$(UPDATE_SAVE_CHALLENGES_JQ).hide();
	$(UPDATE_CANCEL_CHALLENGES_JQ).hide();
	$(UPDATE_CHALLENGES_JQ).fadeIn();
	$(RECENT_CHALLENGE_PANEL_H3).html('Recent Challenges');
	
	//$(RESULT_DIV_JQ).html("test");
	//$(RESULT_DIV_JQ).show();
	
	var htmlString = $('#update_challenge_name').val();
	$('#recent_challenges_list .panel-title-header').html(htmlString);
	loadRecentActivity();
}

//Fresh Load Challenges
function loadChallenge(dataId) {
	
	closeChallengePanel();
	$(RECENT_CHALLENGES_LIST).html(LOADER_IMAGE);
	$(RECENT_CHALLENGES_LIST).fadeIn();
	
	var formData = { dataId:dataId };        				   
	$.ajax({
		url : "ajax/get_recent_challenge_ajax.jsp",
		type: POST,
		data : formData,
		success: function(data, textStatus, jqXHR)
		{
			$(RECENT_CHALLENGES_LIST).slideUp();
			$(RECENT_CHALLENGES_LIST).html(data);
			$(RECENT_CHALLENGES_LIST).slideDown();
		},
		error: function (jqXHR, textStatus, errorThrown)
		{
			$(RECENT_CHALLENGES_LIST).html(NO_RECORDS_YET);
		}
	});
	
	var formData = { dataId:dataId };        				   
	$.ajax({
		url : "ajax/get_activities_ajax.jsp",
		type: POST,
		data : formData,
		success: function(data, textStatus, jqXHR)
		{
			$(OTHER_CHALLENGES_JQ).slideUp();
			$(OTHER_CHALLENGES_JQ).html(data);
			$(OTHER_CHALLENGES_JQ).slideDown();
		},
		error: function (jqXHR, textStatus, errorThrown)
		{
			$(OTHER_CHALLENGES_JQ).html(NO_RECORDS_YET);
		}
	});
}

//Challenge Menu One
function challengePanelOne(dataid) {
	if($('#challengePanelOne').hasClass('active')) {
		closeChallengePanel();
	} else {
		resetChallengePanels();
		$('#challengePanelOne').addClass('active');
		$('#subsection_panel_content').html('');
		var htmlString = '<div class="panel-body">';
		htmlString += '<input type="text" id="datepicker_activity" name="activity_date" />';
		htmlString += '<input type="button" value="Update Date" id="datepicker_button" onClick="updateDeadline('+dataid+');" />';
		htmlString += '<div class="btn btn-info btn-sm pull-right pointer" onClick="closeChallengePanel();"><span class="glyphicon glyphicon-asterisk"></span> Close</div>';
		htmlString += '</div>';
		$('#subsection_panel_content').html(htmlString);
		$('#recent_challenges_subsection_panel').fadeIn('slow');
		$('#subsection_panel_content').slideDown('slow', function(){
			$('#datepicker_activity').datetimepicker({
				inline:true,
				//timepicker:false,
				format:'d/m/Y',
				formatDate:'Y/m/d'
			});		
			$('#recent_challenges_subsection_panel').addClass('active');
		});
	}
}

function updateDeadline(dataid){
	var selectedDate = $('#datepicker_activity').val();	
	var formData = { entryId:dataid, selectedDate:selectedDate };
	$.ajax({
		url : "ajax/update_deadline_ajax.jsp",
		type: POST,
		data : formData,
		success: function(data, textStatus, jqXHR)
		{
			$(RESULT_DIV_JQ).html(data);
			$(RESULT_DIV_JQ).show();
			$(RESULT_DIV_JQ).delay(1000).fadeOut(1000);
			
			loadRecentActivity();
		},
		error: function (jqXHR, textStatus, errorThrown)
		{
			$('#subsection_panel_content').html('error:circle error');
		}
	});
}

//Challenge Menu Two
function challengePanelTwo(dataid) {
	
	if($('#challengePanelTwo').hasClass('active')) {
		closeChallengePanel();
	} else {
		resetChallengePanels();
		$('#challengePanelTwo').addClass('active');
		$('#subsection_panel_content').html('');
		
		
		//circle_categories_ajax.jsp
		var formData = { dataId:dataid };
		$.ajax({
			url : "ajax/circle_categories_ajax.jsp",
			type: POST,
			data : formData,
			success: function(data, textStatus, jqXHR)
			{
				$('#subsection_panel_content').html(data);				
			},
			error: function (jqXHR, textStatus, errorThrown)
			{
				$('#subsection_panel_content').html('error:circle error');
			}
		});
		
		$('#recent_challenges_subsection_panel').fadeIn('slow');
		$('#subsection_panel_content').slideDown('slow', function(){
			$('#recent_challenges_subsection_panel').addClass('active');
		});
	}
}

//Challenge Menu Three
function challengePanelThree(dataid) {
	
	if($('#challengePanelThree').hasClass('active')) {
		closeChallengePanel();
	} else {
		resetChallengePanels();
		$('#challengePanelThree').addClass('active');
		$('#subsection_panel_content').html('');
		
		//circle_categories_ajax.jsp
		var formData = { dataId:dataid };
		$.ajax({
			url : "ajax/tag_categories_ajax.jsp",
			type: POST,
			data : formData,
			success: function(data, textStatus, jqXHR)
			{
				$('#subsection_panel_content').html(data);				
			},
			error: function (jqXHR, textStatus, errorThrown)
			{
				$('#subsection_panel_content').html('error:tag error');
			}
		});
		$('#recent_challenges_subsection_panel').fadeIn('slow');
		$('#subsection_panel_content').slideDown('slow', function(){
			$('#recent_challenges_subsection_panel').addClass('active');
		});
	}
}

//Challenge Menu Four
function challengePanelFour(dataid) {
	if($('#challengePanelFour').hasClass('active')) {
		closeChallengePanel();
	} else {
		resetChallengePanels();
		$('#challengePanelFour').addClass('active');
		$('#subsection_panel_content').html('');
		var htmlString = '<div class="panel-body">';
		htmlString += '<div class="title-info">3 Friends are watching your challenge</div>';
		htmlString += '<ul class="users_list">';
		htmlString += '<li><img src="images/users/user1.jpg">Vlad is watching since yesterday</li>';
		htmlString += '<li><img src="images/users/user2.jpg">Kathie started watch few mins ago</li>';
		htmlString += '<li><img src="images/users/user3.jpg">Steeve is watching since January</li>';
		htmlString += '</ul>';
		htmlString += '<div class="btn btn-info btn-sm pull-right pointer" onClick="closeChallengePanel();"><span class="glyphicon glyphicon-asterisk"></span> Close</div>';
		htmlString += '</div>';
		$('#subsection_panel_content').html(htmlString);
		$('#recent_challenges_subsection_panel').fadeIn('slow');
		$('#subsection_panel_content').slideDown('slow', function(){
			$('#recent_challenges_subsection_panel').addClass('active');
		});	
	}
}

//Challenge Menu Close
function closeChallengePanel() {
	$('#subsection_panel_content').slideUp('slow', function(){
		if($('.icons-holder > li > a').hasClass('active')) {
			$('.icons-holder > li > a').removeClass('active').addClass('');
		}
		$('#recent_challenges_subsection_panel').removeClass('active').addClass('');
		$('#recent_challenges_subsection_panel').hide();
		$('#subsection_panel_content').html('');
	});
}

//Challenge Menu Reset
function resetChallengePanels() {
	if($('.icons-holder > li > a').hasClass('active')) {
		$('.icons-holder > li > a').removeClass('active').addClass('');
	}
	if($('#recent_challenges_subsection_panel').hasClass('active')) {
		$('#recent_challenges_subsection_panel').removeClass('active').addClass('');
	}
}

//Challenge Menu - Category Activate
function activateTagCategory(varList) {
	var dataId = $(varList).attr('id');
	//alert(dataId);
	//var dataImg = $(varList).attr('data-img');
	$('.category_list > li').removeClass('active').addClass('');
	$('.category_list > li > span').removeClass('glyphicon glyphicon-ok text-success glyphicon-size1').addClass('');
	$('#'+dataId+'').addClass('active');
	$('#'+dataId+' > span').addClass('glyphicon glyphicon-ok text-success glyphicon-size1');
	//$('#challengePanelTwo > img').attr('src', 'images/'+dataImg+'');	
}

//Challenge Menu - Group Activate
function activatePanelTag(varList) {
	
	$('#subsection_panel_content .panel-body #message_holder').hide();
	
	var dataId = $(varList).attr('id');
	var entryId = $(varList).attr('data-challenge-id');
	var tagName = $(varList).attr('data-tag-name');
	$('.group_list > li').removeClass('active').addClass('');
	$('.group_list > li > span').removeClass('glyphicon glyphicon-ok text-success glyphicon-size1').addClass('');
	$('#'+dataId+'').addClass('active');
	$('#'+dataId+' > span').addClass('glyphicon glyphicon-ok text-success glyphicon-size1');	
	
	//circle_categories_ajax.jsp
	var formData = { entryId:entryId, tagName:tagName  };
	$.ajax({
		url : "ajax/update_tag_category_ajax.jsp",
		type: POST,
		data : formData,
		success: function(data, textStatus, jqXHR)
		{
			$('#subsection_panel_content .panel-body #message_holder').html(data);
			$('#subsection_panel_content .panel-body #message_holder').show();
			$('#subsection_panel_content .panel-body #message_holder').delay(1000).fadeOut(1000);
		},
		error: function (jqXHR, textStatus, errorThrown)
		{
			$('#subsection_panel_content .panel-body #message_holder').html('error:tag error');
			$('#subsection_panel_content .panel-body #message_holder').show();
		}
	});
}