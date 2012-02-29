function initializeSearch(facets) {
	var searchContainer = $('#search');
	if(searchContainer.length < 1) {
		return;
	}
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
				  url: "/" + location.pathname.match(/^\/([^/]*)\/?/)[1] + '/search', 
				  data: data,
				  success: function(newTable) {
						$("#offeringsList").replaceWith(newTable);
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
$(document).ready(function(){
	// Load facets
	$.ajax({
		type: 'GET',
		url: "/" + location.pathname.match(/^\/([^/]*)\/?/)[1] + "/facets",
		dataType: 'json',
		success: function(data, textStatus, jqXHR) {
			initializeSearch(data);
		},
		error: function(jqXHR, textStatus, errorThrown) {
			console.log(textStatus);
		}
	});
});
