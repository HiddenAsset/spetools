package controls 
{
	import flash.display.*
	import fl.controls.List;
	import fl.data.DataProvider;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import lib.ListItemSkin;
	[Event(name="clickItem", type="flash.events.Event")]
	/**
	 * 设置list 皮肤
	 * @author spe email:md9yue@@q.com
	 */
	public class SetListSkin extends EventDispatcher
	{
		private var _list:List
		private var _data:DataProvider=new DataProvider()
		public function SetListSkin(value:List) 
		{
			_list = value
			list.dataProvider = data
			//设置显示选项
			list.labelField = 'name'
			//设置选项
			//list.c  = ListItem;
			
			list.setStyle("cellRenderer", ListItem);
			list.rowHeight=new ListItemSkin().height

		}
		public function loadXml(value:String):void {
			var loader:URLLoader = new URLLoader()
			loader.addEventListener(IOErrorEvent.IO_ERROR, error)
			loader.addEventListener(Event.COMPLETE, xmlLoadend)
			loader.load(new URLRequest(value))
		}
		private var _xml:XML
		private function xmlLoadend(e:Event):void 
		{
			var loader:URLLoader = e.target as URLLoader
			_xml = XML(loader.data)
			var obj:Object
			for (var i:int = 0; i <xml.tool.length() ; i++) 
			{
				obj = new Object()
				obj.xml = xml.tool[i];
				obj.name = xml.tool[i].@name.toString();
				obj.type = xml.tool[i].@type.toString();
				obj.ico = xml.tool[i].@ico.toString()
				obj.swf = xml.tool[i].swf.toString()
				obj.jsfl = xml.tool[i].jsfl.toString()
				data.addItem(obj)
				//trace(obj.swf)
			}
		}
		
		private function error(e:IOErrorEvent):void 
		{
			
		}
		/**
		 * 发送事件
		 * @param	value
		 */
		private function sendEvent(value:String):void {
			dispatchEvent(new Event(value))
		}
		/**
		 * 列表
		 */
		public function get list():List { return _list; }
		/**
		 * 数据
		 */
		public function get data():DataProvider { return _data; }
		/**
		 * 工具XML数据
		 */
		public function get xml():XML { return _xml; }
		
	}

}