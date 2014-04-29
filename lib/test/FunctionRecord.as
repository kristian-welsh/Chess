package test {
	
	public class FunctionRecord {
		private var _name:String;
		private var _args:Array;
		
		public function FunctionRecord(name:String, args:Array = null):void {
			_name = name;
			_args = args || [];
		}
		
		public function get name():String {
			return _name;
		}
		
		public function getArgByPosition(argPosition:uint):Object {
			return _args[argPosition];
		}
	}
}