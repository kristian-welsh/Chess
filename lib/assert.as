package {
	public function assert(condition:Boolean, message:String):void {
		if (!condition)
			throw new Error(message);
	}
}