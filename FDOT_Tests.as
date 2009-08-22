package
{
	import flash.display.Sprite;
	import f.tests.*;


	public class FDOT_Tests extends Sprite
	{
		public function FDOT_Tests()
		{
			addChild( new f_data_ObjectStore() );
			addChild( new f_net_Load_binary() );
			addChild( new f_net_Load_binary_instance() );
			addChild( new f_net_Load_e4x() );
			addChild( new f_net_Load_e4x_instance() );
			addChild( new f_net_Load_image() );
			addChild( new f_net_Load_image_instance() );
			addChild( new f_net_Load_json() );
			addChild( new f_net_Load_json_instance() );
			addChild( new f_net_Load_querystring() );
			addChild( new f_net_Load_querystring_instance() );
			addChild( new f_net_Load_stream() );
			addChild( new f_net_Load_stream_instance() );
			addChild( new f_net_Load_swf() );
			addChild( new f_net_Load_swf_instance() );
			addChild( new f_net_Load_text() );
			addChild( new f_net_Load_text_instance() );
			addChild( new f_net_Load_xmldoc() );
			addChild( new f_net_Load_xmldoc_instance() );
		}
		
	}
}