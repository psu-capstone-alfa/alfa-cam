function forceHelper(e,ui) {
	$(".ui-state-highlight").html("<td colspan='100%'>&nbsp;</td>");
}

$(document).ready(function(){
	sortItems = $("#offeringsList tbody");
	sortItems.sortable({
		placeholder: "ui-state-highlight",
		change: function(e, ui) {
       forceHelper(e,ui);
    }
	});
	sortItems.disableSelection();
});