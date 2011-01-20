function(doc){
	var newdoc = {};
	
	newdoc._attachments = doc._attachments;
	newdoc.tags			= doc.tag;
	newdoc.filename		= doc.filename;
	newdoc.comment		= (doc.comment)?doc.comment:"there is no comment."
	
	// convert date time
	var d = new Date();
	d.setTime(doc.unix_time*1000); // ajust to JST +0900 ,millisec
	var key = [d.getFullYear(),(d.getMonth()+1),d.getDate()];
	
	newdoc.ctime = doc.unix_time*1000; // for javascript Date function

	emit(key, newdoc);
}