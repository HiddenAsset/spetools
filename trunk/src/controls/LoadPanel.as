package controls 
{
	import com.ixiyou.speUI.collections.MSprite;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import lib.LoadPanelSkin;
	import caurina.transitions.Tweener
	/**
	 * ...
	 * @author spe email:md9yue@@q.com
	 */
	public class LoadPanel extends MSprite
	{
		private var skin:LoadPanelSkin = new LoadPanelSkin()
		private var loader:Loader=new Loader()
		public function LoadPanel() 
		{
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, error)
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadend)
			addChild(skin)
			skin.addChildAt(loader,1)
			skin.closeBtn.addEventListener(MouseEvent.CLICK, close)
			this.autoSize = true
	
		}
		
		private function close(e:MouseEvent):void 
		{
			hit()
		}
		private var now:DisplayObject
		private function loadend(e:Event):void 
		{
			if(now&&now.parent)now.parent.removeChild(now)
			now = loader.content
			skin.addChildAt(now, 1)
			
			
		}
		
		private function error(e:IOErrorEvent):void 
		{
			if (now && now.parent) now.parent.removeChild(now)
			skin.label.text='Error:'+WindowData.instance.itmeName+' 加载Error!'
		}
		
	
		public function show(itmeName:String, value:String, jsfl:String):void {
			WindowData.instance.jsfl = jsfl
			WindowData.instance.itmeName = itmeName
			skin.label.text=WindowData.instance.itmeName
			loader.load(new URLRequest(value))
		}
		public function hit():void {
			if(now&&now.parent)now.parent.removeChild(now)
			Tweener.addTween(this, { time:.5, alpha:0, onComplete:function():void {
				if (this.parent) this.parent.removeChild(this)
				if (loader.content) loader.unloadAndStop()
				
			}})
		}
		override public function upSize():void {
			if (!skin) return
			skin.bg.width = width
			skin.bg.height = height
			skin.closeBtn.x = width - skin.closeBtn.width
			skin.label.width=width-skin.closeBtn.width-skin.label.x
		}
	}

}