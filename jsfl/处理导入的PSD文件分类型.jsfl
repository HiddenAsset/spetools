var lib = fl.getDocumentDOM().library;
init('robotLib')
function init(value){
	var libArr=fl.getDocumentDOM().library.getSelectedItems()
	//fl.trace('整理:'+libArr.length)
	var folders=[]
	for(i=0;i<libArr.length;i++){
		var item=libArr[i]
		//fl.trace(item.itemType)
		if(item.itemType=='folder'){
			//文件夹
			folders.push(item)
		}else if(item.itemType=='bitmap'){
			//图片
			var fileurl=value+'/img'
			moveToFolder(item,fileurl,value+'_img_')
		}else if(item.itemType=='movie clip'){
			//影片剪辑
			var fileurl=value+'/mc'
			moveToFolder(item,fileurl,value+'_mc_')
		}else if(item.itemType=='graphic'){
			//图形
			var fileurl=value+'/graphic'
			moveToFolder(item,fileurl,value+'_graphic_')
		}else if(item.itemType=='component'){
			//组件
			var fileurl=value+'/component'
			moveToFolder(item,fileurl,value+'_component_')
		}else if(item.itemType=='button'){
			//按钮
			var fileurl=value+'/btn';
			moveToFolder(item,fileurl,value+'_btn_')
		}else{
			var fileurl=value+'/other';
			moveToFolder(item,fileurl,value+'_other_')
		}
	}
	for(i=0;i<folders.length;i++){
		item=folders[i]
		fl.getDocumentDOM().library.deleteItem(item.name);
	}
}
/**
	移动到指定文件
		item  移动的对象
		fileurl 文件夹路径
		sequence 序列命名
*/
function moveToFolder(item,fileurl,sequence){
	//文件夹不存在的话
	//fl.trace(lib.itemExists(fileurl))
	if(!lib.itemExists(fileurl)){
		//fl.trace('文件夹不存在 创建一个')
		lib.newFolder(fileurl)
	}
	lib.selectItem(fileurl)
	var libArr=fl.getDocumentDOM().library.getSelectedItems()
	var fileNum=libArr.length
	//fl.trace(String(fileNum*0.00001).slice(2,7))
	//fileNum=String(fileNum*0.00001).slice(2,7)
	/*
	if(fileNum<10)fileNum='00000'+fileNum
	else if(fileNum<100)fileNum='0000'+fileNum
	else if(fileNum<1000)fileNum='000'+fileNum
	else if(fileNum<10000)fileNum='00'+fileNum
	else if(fileNum<100000)fileNum='0'+fileNum
	else fileNum=''+fileNum
	*/
	//fl.trace(lib.itemExists(fileurl+'/'+sequence+fileNum))
	while(lib.itemExists(fileurl+'/'+sequence+fileNum)){
		fileNum++
	}
	item.name=sequence+fileNum
	lib.moveToFolder(fileurl,item.name,false)
}