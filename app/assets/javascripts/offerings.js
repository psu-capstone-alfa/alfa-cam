$(document).ready(function(){
  var osm = new OfferingSearchModel();
  var osv = new OfferingSearchView({model: osm});
	osm.loadFacets();
});
