function init_search(facets) {
	VS.init({
     container  : $('.visual_search'),
     query      : '',
     unquotable : [],
     callbacks  : {
       search : function(query, searchCollection) {
				var obj = {};
				var queriedFacets = searchCollection.each(function(facet){
					obj[facet.get("category")] = facet.get("value");
				});
				var offerings = $.ajax({
				  type: 'POST',
				  url: '/offerings/search.json',
				  data: obj,
				  success: function(data) {
				    console.log(data)
				  },
				  dataType: 'json'
				});
        /* 
				var $query = $('#search_query');
				 console.log(searchCollection.facets());
         var count  = searchCollection.size();
         $query.stop().animate({opacity : 1}, {duration: 300, queue: false});
         $query.html('<span class="raquo">&raquo;</span> You searched for: ' +
                     '<b>' + (query || '<i>nothing</i>') + '</b>. ' +
                     '(' + count + ' facet' + (count==1 ? '' : 's') + ')');
         clearTimeout(window.queryHideDelay);
         window.queryHideDelay = setTimeout(function() {
           $query.animate({
             opacity : 0
           }, {
             duration: 1000,
             queue: false
           });
         }, 4000);
				var obj = {};
				var queriedFacets = searchCollection.each(function(facet){
					obj[facet.get("category")] = facet.get("value");
				});
				*/
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
$(document).ready(function() {
	var facets = $.ajax({
	  type: 'GET',
	  url: '/offerings/facets.json',
	  success: function(data) {
	    init_search(data)
	  },
	  dataType: 'json'
	});
   
 });