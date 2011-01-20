function(doc){
	// split tags by comma
	var tags = doc.tag; // which is string array.
	for(var i = 0;i < tags.length;i++){
		emit(tags[i], 1);
	}
}