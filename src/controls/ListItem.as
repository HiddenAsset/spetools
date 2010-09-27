package controls 
{

	import flash.display.*;
	import fl.core.UIComponent
	import fl.controls.listClasses.ICellRenderer;
	import fl.controls.listClasses.ListData;
	import fl.core.InvalidationType;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import lib.ListItemSkin;
	import adobe.utils.MMExecute
	import com.ixiyou.utils.display.MFilters
	/**
	 * ...
	 * @author spe email:md9yue@@q.com
	 */
	public class ListItem  extends UIComponent implements ICellRenderer
	{
		protected var _data:Object;
		protected var _listData:ListData; 
		protected var _selected:Boolean;
		protected var skin:ListItemSkin
		private var label:TextField
		private var oldrect:Rectangle = new Rectangle()
		private var loader:Loader=new Loader()
		public function ListItem() 
		{
			skin = new ListItemSkin()
			skin.addChild(loader)
			loader.x = skin.icomask.x
			loader.y = skin.icomask.y
			loader.mask = skin.icomask
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,function():void{trace('item ico load Error!')})
			label = skin.label
			label.text=''
			oldrect.x = skin.width - skin.btn.x
			oldrect.width = skin.width - skin.label.width
			oldrect.y=skin.width - skin.addBtn.x
			addChild(skin)
			skin.btn.addEventListener(MouseEvent.CLICK, click)
			skin.addBtn.addEventListener(MouseEvent.CLICK,addFun)
		}
		
		private function addFun(e:MouseEvent):void 
		{
			
		}
		/**
		 * 
		 * @param	e
		 */
		private function click(e:MouseEvent):void 
		{
			if (swf != '') {
				//trace(swf)
				SpeToolsPanel(root).showJSFLPanel(data.name,swf,jsfl)
				return
			}
			if (jsfl != '') {
				//fl.runScript(fileURI [, funcName [, arg1, arg2, ...]])
				trace(jsfl)
				MMExecute('fl.runScript(fl.configURI+"WindowSWF/'+jsfl+'","init","")')
				return
			}else {
				MMExecute('fl.trace("'+data.name+'方法 '+'没有可执行的JSFL!!!");')
			}
			
		}
		private var swf:String
		private var jsfl:String
		public function get data():Object {   return _data;        } 
		public function set data(value:Object):void { 
			_data = value; 
			label.text = data.name
			if (data.ico != '') loader.load(new URLRequest(data.ico))
			swf = data.swf
			jsfl=data.jsfl
		}
		
		public function get listData():ListData { 
			return _listData;
		}
		public function set listData(value:ListData):void {
            _listData = value;
			if (listData.index % 2 == 0) {
				skin.bg0.visible=false
				skin.bg1.visible=true
			}else {
				skin.bg0.visible=true
				skin.bg1.visible=false
			}
		}
		public function get selected():Boolean {            return _selected;        } 
	    public function set selected(value:Boolean):void {
            _selected = value;
			//if(_selected)trace(listData.index)
			upDraw()
		} 
		public function setMouseState(state:String):void {  
			
		}
		override public function setSize (param0:Number, param1:Number) : void {
			super.setSize(param0,param1)
			upDraw()
		}
		public function upDraw():void {
			if (!skin) return
			//addChild(skin)
			if (selected) {
				skin.bg0.filters = [MFilters.brightness(20)]
				skin.bg1.filters=[MFilters.brightness(20)]
			}
			else {
				skin.bg0.filters = []
				skin.bg1.filters=[]
			}	
			skin.bg1.width = skin.bg0.width = width
			label.width = width - oldrect.width
			skin.btn.x = width - oldrect.x
			skin.addBtn.x=width-oldrect.y
		}
	}

}