function(doc, req){
	// !code lib/mustache.js
	var ddoc = this;
	
	return Mustache.to_html(ddoc.templates.list, {
		doc: doc,
		assets: "/docstore/_design/dashboard"
	});
}
