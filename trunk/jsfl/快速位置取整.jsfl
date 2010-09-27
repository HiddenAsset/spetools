//init()
function init(){
	var selectObjArray = fl.getDocumentDOM().selection;
	for(var i=0;i<selectObjArray.length;i++){
		//fl.trace("fl.getDocumentDOM().selection["+i+"] = " + selectObjArray[i]);
		var el=selectObjArray[i]
		el.x=Math.round(el.x)
		el.y=Math.round(el.y)
		
	} 

}