init()
function init(){
	//fl.trace("..\\src")
	var packageBool=false
	var tempArr=fl.as3PackagePaths.split(';')
	for(var i=0;i<tempArr.length;i++){
		var temp=String(tempArr[i])
		//fl.trace(temp.toString()=='..\src')
		if(temp=="..\\src"){
			fl.trace(temp);
			packageBool=true
			break
		}
	}
	//fl.trace(packageBool)
	if(!packageBool)fl.as3PackagePaths+=';../\src'
	fl.trace(fl.as3PackagePaths)
}
