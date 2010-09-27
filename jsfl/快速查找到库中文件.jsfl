//init()
function init(){
	var selectObjArray = fl.getDocumentDOM().selection;
	if(selectObjArray==null||selectObjArray.length<=0)return
	var el=selectObjArray[0]
	var lib=el.libraryItem
	if(lib==undefined)return
	/*
	var strm=lib.name.lastIndexOf('/')
	//fl.trace(strm)
	if(strm!=-1)strm=lib.name.substr(0,strm)
	else strm=''
	if(strm!=''){
		//fl.trace(strm)
		fl.getDocumentDOM().library.expandFolder(true, true, strm);
	}
	*/
	//var strm=lib.name.lastIndexOf('/')
	//if(strm!=-1)strm=lib.name.substr(0,strm)
	//else strm=''
	var arr=lib.name.split('/')
	if(arr.length>1){
		var file=''
		for(i=0;i<arr.length-1;i++){
			if(i==0)file+=arr[i]
			else file+=('/'+arr[i])
			//fl.trace(file)
			fl.getDocumentDOM().library.expandFolder(true,true,file);
		}
	}
	fl.getDocumentDOM().library.selectItem(lib.name);
}