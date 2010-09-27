package  
{
	/**
	 * ...
	 * @author spe email:md9yue@@q.com
	 */
	
	public class WindowData
	{
		static private var _instance:WindowData;
		public static function get instance() : WindowData {
			if (_instance == null)_instance = new WindowData();
			return _instance;
		}
		public var jsfl:String = ''
		public var itmeName:String = ''
		public function WindowData() 
		{
			
		}
		
	}

}