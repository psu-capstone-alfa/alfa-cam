function initializeSearch(facets) {
	VS.init({
     container  : $('.visual_search'),
     query      : '',
     unquotable : [],
     callbacks  : {
       search : function(query, searchCollection) {
				var data = {partial: true};
				var queriedFacets = searchCollection.each(function(facet){
					data[facet.get("category")] = facet.get("value");
				});
				var offerings = $.ajax({
				  type: 'GET',
				  url: '/offerings/search',
				  data: data,
				  success: function(newTable) {
						$("#offeringsList").replaceWith(newTable);
				  },
				});
       },
       facetMatches : function(callback) {
         callback(['term', 'crn', 'instructor']);
       },
			valueMatches : function(facet, searchTerm, callback) {
				switch (facet) {
					case 'term':
						callback(facets.terms);
						break;
					case 'crn':
						callback(facets.crns);
						break;
					case 'instructor':
						callback(facets.instructors);
						break;
				}
			}
     }
   });
}
$(document).ready(function(){
	// Load facets
	$.ajax({
		type: 'GET',
		url: '/offerings/facets.json',
		success: function(data) {
			initializeSearch(data);
		},
		dataType: 'json'
	});
});
