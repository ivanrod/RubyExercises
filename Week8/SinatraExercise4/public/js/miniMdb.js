document.getElementsByTagName('button')[0].addEventListener('click',getPost);

function getPost(){

	$.post( "/list2", document.getElementById('input2').value );
	$.ajaxSetup({
		//PREGUNTAR seria correcto hacer async el post y sync el get?
	  async: false,
	});
	var response = $.get( "/list2");
	
	document.getElementById('input1').value=response.responseText;
	return response
}
