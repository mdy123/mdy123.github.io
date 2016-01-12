	$(window).load(function(){
		//var linkAddr=[['http://mdy123.github.io/project.0/project.0.html','yes'],['./project.1.html','yes'],['./images/codeimg.html','no']];
		var linkAddr=[['http://mdy123.github.io/project.0/project.0.html','yes'],['http://mdy123.github.io/project.1/project.1.html','yes'],['./images/codeimg.html','no']];
		$('.colorBoxParent').click(function (e) {
			$(this)[0].childNodes[1].innerText=$(this)[0].id;
	 	})
	
		$('.imgButton').click(function (e) {
			$('iframe')[0].src=linkAddr[$(this)[0].id][0];
			$('iframe')[0].scrolling=linkAddr[$(this)[0].id][1];
	 	})
		
	})	

