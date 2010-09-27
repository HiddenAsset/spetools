
function init(){
	var timeline=fl.getDocumentDOM().getTimeline()
	timeline.insertFrames();
	
	//计算当前帧选择情况
	var theSelectedFrames = timeline.getSelectedFrames();
	//fl.trace('选择帧:'+theSelectedFrames+' 多少组图层:'+theSelectedFrames.length%3);
	var layers=theSelectedFrames.length%3+1
	var selectedFrames=new Array()
	var obj={}
	for(i=0;i<layers;i++){
		obj.num=i
		obj.layer=theSelectedFrames[i*3]
		obj.movieStart=theSelectedFrames[i*3+1]
		obj.movieEnd=theSelectedFrames[i*3+2]
		selectedFrames.push(obj)
		//trace('图层等级：'+obj.layer+' 动画开始帧:'+bj.movieStart+' 动画结束帧:'+obj.movieEnd)
	}

	
	
		
	//选定帧
	//timeline.setSelectedFrames(6,6);
	var selectObjArray = fl.getDocumentDOM().selection;
	//for(var i=0;i<selectObjArray.length;i++){fl.trace("fl.getDocumentDOM().selection["+i+"] = " + selectObjArray[i]);} 
	if(selectObjArray!=null&&selectObjArray.length>0){
		if(selectObjArray.length==1){
			//只有一个对象不是按钮或者影片时候需要转对象
			if(selectObjArray[0].instanceType!='symbol'){
				fl.getDocumentDOM().convertToSymbol('graphic', '', 'top left');
			}
		}else{
			fl.getDocumentDOM().convertToSymbol('graphic', '', 'top left');
		}
	}else{
		fl.trace('时间轴上无显示对象')
	}
	//添加动画
	timeline.createMotionTween();
	timeline.setFrameProperty('tweenEasing', 100);

	//插入关键帧
	timeline.insertKeyframe()

}