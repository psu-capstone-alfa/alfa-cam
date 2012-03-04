// ------------------------------------------------------------
// Sort content and objectives
// ------------------------------------------------------------
function forceHelper(e,ui) {
	$(".ui-state-highlight").html("<td colspan='100%'>&nbsp;</td>");
}

function makeContentAndObjectivesSortable() {
	var container = $('#objectives_container, #content_container');
	if(container.length < 1) {
		return;
	}
	container.each(function(index, element){
	  $('tbody tr', element).addClass("draggable");
	  $('tbody', element).sortable({
	    axis: 'y',
	    items: 'tr',
	    placeholder: 'ui-state-highlight',
            opacity: 0.4,
	    scroll: true,
	    change: function(e, ui) {
      	      forceHelper(e,ui);
            }
	  });
	});
	
      $('.offering-content-groups').submit(function(){
        $(".offering-content-groups input.position").each(function(index) {
          $(this).val(index);
        });
        return true;
      });
}

// ------------------------------------------------------------
// Search Offerings
// ------------------------------------------------------------

function loadFacets() {
	var searchContainer = $('#search');
	if(searchContainer.length < 1) {
		return;
	}
	var baseUrl = $('#search').data('baseurl');
	var resultsSelector = $('#search').data('results-selector');
	$.ajax({
		type: 'GET',
		url: baseUrl + "/facets",
		dataType: 'json',
		success: function(facets, textStatus, jqXHR) {
			initializeSearch(facets, searchContainer, baseUrl, resultsSelector);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.log(textStatus);
		}
	});
}

function initializeSearch(facets, searchContainer, baseUrl, resultsSelector) {
	facetCategories = [];
	for (var propertyName in facets) {
	  if (facets.hasOwnProperty(propertyName)) {
	    facetCategories.push(propertyName.charAt(0).toUpperCase() + propertyName.slice(1));
	  }
	}
	VS.init({
		container  : searchContainer,
		query      : '',
		unquotable : [],
		callbacks  : {
			search : function(query, searchCollection) {
				var data = { partial: true };
				var queriedFacets = searchCollection.each(function(facet){
					data[facet.get("category").toLowerCase()] = facet.get("value");
				});
				var offerings = $.ajax({
					type: 'GET',
				  url: baseUrl + '/search', 
				  data: data,
				  dataType: "html",
				  success: function(newTable, textStatus, jqXHR) {
						$(resultsSelector).replaceWith(newTable);
				  },
				});
       },
       facetMatches : function(callback) {
        callback(facetCategories);
       },
       valueMatches : function(facet, searchTerm, callback) {
         callback(facets[facet]);
       }
     }
   });
  searchContainer.append("<div id='search_help'>Possible search terms are: " + facetCategories.join(", "));
}


// ------------------------------------------------------------
// When the page finishes loading...
// ------------------------------------------------------------
$(document).ready(function(){
	makeContentAndObjectivesSortable();
	loadFacets();
});
