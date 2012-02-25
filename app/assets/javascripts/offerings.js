$(document).ready(function() {
   var visualSearch = VS.init({
     container  : $('.visual_search'),
     query      : '',
     unquotable : [],
     callbacks  : {
       search : function(query, searchCollection) {
         var $query = $('#search_query');
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
         }, 2000);
       },
       facetMatches : function(callback) {
         callback(['term', 'crn', 'instructor']);
       },
       valueMatches : function(facet, searchTerm, callback) {
         switch (facet) {
         case 'term':
            callback([
							'Winter 2012',
							'Spring 2012',
							'Summer 2012',
							'Fall 2012'
             ]);
             break;
           case 'crn':
             callback([
							'60500',
							'60507',
							'60510'
							]);
             break;
           case 'instructor':
						callback([
							{label: 'Dr. Christopher Monsere', value: '1_monsere'},
							{label: 'Dr. Mike Gorji', value: '2_gorji'},
							{label: 'Dr. Bill Fish', value: '3_fish'}
						]);
             break;
         }
       }
     }
   });
 });