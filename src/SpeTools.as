package 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * windowSwf load panel
	 * @author spe email:md9yue@@q.com
	 */
	public class SpeTools extends Sprite 
	{
		private var loader:Loader=new Loader()
		public function SpeTools():void 
		{
			if (stage) init();
			//MovieClip().buttonMode=true
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			SimpleTracer.setStage(stage)
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadend)
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function():void {
				SimpleTracer.add('Error : Main load Panel Error !')
			})
			loader.load(new URLRequest('SpeToolsPanel.swf'))
		}
		
		private function loadend(e:Event):void 
		{
			stage.addChild(loader.content)
		}
		
	}
	
}