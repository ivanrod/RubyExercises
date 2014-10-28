document.getElementsByTagName('button')[0].addEventListener('click',getPost);

function getPost(){

	$.post( "/list2", document.getElementById('input2').value, function(){
		var response = $.getJSON( "/list2", function(data){
			createList(data);
		});
	});
	//document.getElementById('input1').value=response.responseText;
	//return response.responseText
}

function deleteList(){
	showList = document.getElementsByClassName('showList');
	
	while (showList.length > 0){
		showList[0].remove();
	};
}

function createList(newList){
	deleteList();

	for (i=0; i < newList.showList.length; i++){
		option = document.createElement('option');
		option.className = "showList";
		option.innerHTML = newList.showList[i][0];
		option.setAttribute('value', newList.showList[i][1]);
		document.getElementById('show').appendChild(option);
	}

}
