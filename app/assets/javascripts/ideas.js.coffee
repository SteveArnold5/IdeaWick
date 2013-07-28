# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.bindVoteLinks = () ->
	$(".vote_link").bind "ajax:success", (evt, data) ->
		if(data.message?)
			alert(data.message)
		else
	  		$("#vote_count_" + data.id).html data.voteCount
	
window.bindCommentLinks = () ->
	$(".comment_link").bind "click", ->
		commentPanelId = $(this).attr("id").replace("link", "post_panel")
		commentPanel = $("#" + commentPanelId);
		commentPanel.show();
		commentPanel.find("#comment_body").focus();
	
window.bindVoteLinks()
window.bindCommentLinks()

