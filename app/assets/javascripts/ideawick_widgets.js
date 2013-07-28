/*
 *= require_self
 */
(function()
{
	loadDependencies(createAndBindWidget)
}());

function createAndBindWidget()
{
	jQuery(document).ready(function(){
		var height = $(window).height() * .9;
		var width = $(window).width() * .9;
		jQuery(".widget_link").each(function(){
			var url = jQuery(this).attr('href');
			var dialog = jQuery('<div/>', { url: url, style: 'width:' + width + 'px;height:' + height + 'px;overflow-y:auto;-webkit-overflow-scrolling: touch;' }).appendTo('body');
			jQuery('<iframe/>', { src: url, style: 'width:' + width + 'px;height:' + height + 'px;border-style:none;' }).appendTo(dialog);
			dialog.dialog({ autoOpen: false, height: height, width: width })			
		});
		
		jQuery(".widget_link").click(function(){
			var url = jQuery(this).attr('href');
			jQuery('[url="' + url + '"]').dialog('open');
			return false;	
		});
	});
}

function loadDependencies(callback)
{
	loadScript("http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js", function(){
		loadScript("http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/jquery-ui.min.js", function(){
			setStyles();
			callback();
		});
	});
}

function setStyles()
{
	jQuery('head').append('<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.23/themes/start/jquery-ui.css">');	
	jQuery('head').append('<style>.ui-dialog .ui-dialog-content{ padding:0; }</style>')
}

function loadScript(url, callback)
{
   var head = document.getElementsByTagName('head')[0];
   var script = document.createElement('script');
   script.type = 'text/javascript';
   script.src = url;
   script.onreadystatechange = callback;
   script.onload = callback;
   head.appendChild(script);
}