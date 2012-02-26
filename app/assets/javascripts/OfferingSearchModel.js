OfferingSearchModel = Backbone.Model.extend({
	
	initialize: function() {
		
	},
	
	loadFacets: function() {
		var context = this;
		var facets = $.ajax({
		  type: 'GET',
		  url: '/offerings/facets.json',
		  success: function(data) {
				context.set(data, {silent: true});
		    context.trigger("facetsLoaded");
		  },
		  dataType: 'json'
		});
	}
});