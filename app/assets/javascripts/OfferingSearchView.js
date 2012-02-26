var OfferingSearchView = Backbone.View.extend({

	el: "#offeringsList",
	
	template: "<tr><th>Course</th><th>Term</th><th>Section</th><th>Crn</th><th>Location</th><th></th><th></th><th></th></tr>{{#offerings}}<tr><td>{{course_id}}</td><td>{{term_id}}</td><td>{{section}}</td><td>{{crn}}</td><td>{{location}}</td><td><a href='/offerings/{{id}}'>Show</a></td><td><a href='/offerings/{{id}}/details/edit/'>Edit</a></td><td><a href='/offerings/{{id}}' data-confirm='Are you sure?' data-method='delete' rel='nofollow'>Delete</a></td></tr>{{/offerings}}",
	
	initialize: function() {
		this.model.bind('change', this.render, this);
		this.model.bind('facetsLoaded', this.initializeSearch, this);
		$(this.el).on("searchComplete", $.proxy(function(evt){
			this.model.clear({silent: true});
			this.model.set({offerings: evt.offerings});
		}, this));
	},

  render: function() {
		var html = Mustache.to_html(this.template, this.model.toJSON());
		$(this.el).html(html);
  },

	initializeSearch: function() {
		$(".visual_search").after("<div id='search_help'>Possible search terms: Term, Instructor, Crn</div>");
		var facets = $.extend(true, [], this.model.attributes);
		VS.init({
	     container  : $('.visual_search'),
	     query      : '',
	     unquotable : [],
	     callbacks  : {
	       search : function(query, searchCollection) {
					var data = {};
					var queriedFacets = searchCollection.each(function(facet){
						data[facet.get("category")] = facet.get("value");
					});
					var offerings = $.ajax({
					  type: 'GET',
					  url: '/offerings/search.json',
					  data: data,
					  success: function(data) {
							var evt = jQuery.Event("searchComplete");
							evt.offerings = data;
					    $("#offeringsList").trigger(evt);
					  },
					  dataType: 'json'
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

});