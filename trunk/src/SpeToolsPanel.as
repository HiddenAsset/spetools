package  
{
	import com.ixiyou.events.SelectEvent;
	import com.ixiyou.speUI.collections.MSprite;
	import com.ixiyou.speUI.controls.MButton;
	import controls.LoadPanel;
	import controls.ToolListPanel;
	import flash.display.*;
	import flash.events.*;
	import flash.net.*
	import lib.BtnSkin;
	import lib.ListItemSkin;
	import lib.MainSkin;
	import fl.controls.List
	import controls.SetListSkin;
	import com.ixiyou.speUI.mcontrols.MovieToCheck2
	import com.ixiyou.managers.CheckManager
	import caurina.transitions.Tweener
	/**
	 * jsfl 工具面板
	 * @author spe email:md9yue@@q.com
	 */
	public class SpeToolsPanel extends MSprite
	{
		private var skin:MainSkin = new MainSkin()
		private var loadPanel:LoadPanel = new LoadPanel()
		private var box:MSprite = new MSprite()
		private var frequentlyList:ToolListPanel
		private var typeer:CheckManager
		private var btnBox2:Sprite = new Sprite()
		private var btnBox:Sprite = new Sprite()
		private var btnMask:Shape=new Shape()
		public function SpeToolsPanel() 
		{
			addChild(skin)
			addChild(box)
			frequentlyList = new ToolListPanel()
			addChild(btnBox2)
			btnBox2.addChild(btnBox)
			addChild(btnMask)
			btnBox2.mask = btnMask
			btnMask.graphics.clear()
			btnMask.graphics.beginFill(0x0,.1)
			btnMask.graphics.drawRect(0,0,10,10)
			//showPanel()
			typeer=new CheckManager(false)
			this.autoSize = true
			skin.pbtn.addEventListener(MouseEvent.CLICK, pFun)
			skin.nbtn.addEventListener(MouseEvent.CLICK,nFtn)
			super()
			loadXml('xml/tools.xml')
		}
		
		private function pFun(e:MouseEvent):void 
		{
			var _w:int = btnMask.width - btnBox.width
			
			if (_w>= 0) {
				btnBox.x=0
			}else {
				var _x:int = btnBox.x +30
				if (_x >=0) _x=0
			}
			Tweener.addTween(btnBox,{x:_x,time:.5})
		}
		
		private function nFtn(e:MouseEvent):void 
		{
			var _w:int = btnMask.width - btnBox.width
			if (_w>= 0) {
				btnBox.x=0
			}else {
				var _x:int = btnBox.x - 30
				if (_x <= _w) _x = _w
			}
			Tweener.addTween(btnBox,{x:_x,time:.5})
		}
		public function loadXml(value:String):void {
			var loader:URLLoader = new URLLoader()
			loader.addEventListener(IOErrorEvent.IO_ERROR, function():void{SimpleTracer.add('load xml error')})
			loader.addEventListener(Event.COMPLETE, xmlLoadend)
			loader.load(new URLRequest(value))
		}
		/**
		 * 工具XML数据
		 */
		public function get xml():XML { return _xml; }
		private var typeArr:Array
		private var allItmes:Array
		//=new Array()
		private var _xml:XML
		private function xmlLoadend(e:Event):void 
		{
			var loader:URLLoader = e.target as URLLoader
			_xml = XML(loader.data)
			var datatype:Object=new Object()
			var obj:Object
			typeArr = new Array()
			allItmes=new Array()
			for (var i:int = 0; i <xml.tool.length() ; i++) 
			{
				obj = new Object()
				obj.xml = xml.tool[i];
				obj.name = xml.tool[i].@name.toString();
				obj.type = xml.tool[i].@type.toString();
				obj.ico = xml.tool[i].@ico.toString()
				obj.swf = xml.tool[i].swf.toString()
				obj.jsfl = xml.tool[i].jsfl.toString()
				var typeobj:Object
				if (!datatype[obj.type]) {
					typeobj = new Object()
					typeobj.arr = new Array()
					typeobj.type=obj.type
					datatype[obj.type]=typeobj
					typeArr.push(typeobj)
					//trace(typeArr.length)
				}else {
					typeobj=datatype[obj.type]
				}
				typeobj.arr.push(obj)
				allItmes.push(obj)
			}
			createdItmesList()
		}
		private var itmesListArr:Array
		/**
		 * 创建类型列表
		 */
		private function createdItmesList():void {
			var btnArr:Array = new Array()
			itmesListArr = new Array()
			var list:ToolListPanel
			var btn:MovieToCheck2
			var tempMovie:BtnSkin = new BtnSkin()
			tempMovie.label.text = '常用'
			tempMovie.label.width = tempMovie.label.textWidth+10
			tempMovie.bg0.width=tempMovie.bg1.width=tempMovie.label.width+10
			btn = new MovieToCheck2(tempMovie)
			btn.data=frequentlyList
			btnBox.addChild(btn)
			btnArr.push(btn)
			//添加常用工具
			frequentlyList.addItems(allItmes)
			
			var obj:Object
			var oldx:int=btn.x+btn.width
			for ( var i:uint = 0; i < typeArr.length; i++) 
			{
				obj=typeArr[i]
				list = new ToolListPanel()
				list.addItems(obj.arr as Array)
				itmesListArr.push(list)
				
				
				tempMovie = new BtnSkin()
				tempMovie.label.text = obj.type
				tempMovie.label.width = tempMovie.label.textWidth+10
				tempMovie.bg0.width=tempMovie.bg1.width=tempMovie.label.width+10
				btn = new MovieToCheck2(tempMovie)
				btn.data=list
				btn.x = oldx
				oldx=btn.x+btn.width
				btnArr.push(btn)
				btnBox.addChild(btn)
			}
			typeer.addEventListener(SelectEvent.UPSELECT,upSelet)
			typeer.dataArr = btnArr
			btn = btnArr[0];
			btn.select=true
		}
		
		private function upSelet(e:SelectEvent):void 
		{
			var btn:MovieToCheck2 = typeer.selected as MovieToCheck2
			
			showPanel(btn.data as DisplayObject )
		}
		public function showPanel(value:DisplayObject=null):void {
			while (box.numChildren > 0) box.removeChildAt(0)
			if (value) box.addChild(value)
			else box.addChild(frequentlyList)
		}
		public function showJSFLPanel(name:String,value:String, jsfl:String):void {
			//trace('showJSFLPanel')
			loadPanel.show(name,value, jsfl)
			stage.addChild(loadPanel)
			loadPanel.alpha = 0
			Tweener.addTween(loadPanel,{time:.5,alpha:1})
		}
		public function hitJSFLPanel():void {
			loadPanel.hit()
			
		}
		override protected function init(e:Event = null):void {
			super.init()
			stage.scaleMode = StageScaleMode.NO_SCALE
			stage.align = StageAlign.TOP_LEFT
			
		}
		override public function upSize():void {
			skin.downPanel.width = skin.topPanel.width = width
			skin.downPanel.y=height-skin.downPanel.height
			skin.version.x = width - skin.version.width
			skin.nbtn.x=width-skin.nbtn.width
			box.y=skin.topPanel.height
			box.width = width
			box.height = height - skin.downPanel.height - skin.topPanel.height
			btnMask.width = width - skin.pbtn.width - skin.nbtn.width
			btnMask.height = skin.pbtn.height
			btnBox2.x=btnMask.x = skin.pbtn.width
			btnMask.y = btnBox2.y = skin.pbtn.y
			if (btnBox.width <= btnMask.width) {
				btnBox.x=0
			}
			//box.graphics.clear()
			//box.graphics.beginFill(0xffffff, .5)
			//box.graphics.drawRect(0,0,box.width,box.height)
		}
	}

}