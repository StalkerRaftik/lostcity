WCD.Colors 							= {};
WCD.Colors.frameBg 					= Color( 38, 38, 38 );
WCD.Colors.gradient					= Color( 0, 0, 0, 75 );
WCD.Colors.closeButton				= Color( 179, 20, 20 );
WCD.Colors.configureButton			= Color( 20, 104, 179 );
WCD.Colors.saveButton				= Color( 0, 128, 0 );
WCD.Colors.tooltipBg				= Color( 60, 60, 60, 220 );
WCD.Colors.selectButton				= Color( 0, 98, 0 );
WCD.Colors.editButton				= Color( 204, 102, 0 );

WCD.Colors.mainColor				= Color( 204, 102, 0 );
WCD.Colors.line						= Color( 204, 102, 0 );

WCD.Colors.menuButton				= { default = Vector( 38, 38, 38 ), hover = Vector( 204, 102, 0 ) };
WCD.Colors.actionButton				= { default = Vector( 58, 58, 58 ), hover = Vector( 204, 102, 0 ) };
WCD.Colors.starButton				= { default = Vector( 38, 38, 38 ), hover = Vector( 235, 219, 65 ) };

WCD.Colors.hud						= {
	bg = Color( 20, 20, 20, 90 ),
	border = Color( 0, 0, 0, 255 ),
	speedmeter = Color( 204, 102, 0, 210 ),
};

WCD.Colors.pump						= {
	bg = Color( 40, 40, 40, 255 ),
	bar = Color( 0, 168, 0, 220 ),
	barBg = Color( 60, 60, 60, 90 ),
	barBorder = Color( 0, 0, 0, 255 ),

	buttonAcceptBg = Color( 204, 102, 0 ),
	buttonBusyBg = Color( 168, 0, 0 ),
	buttonBorder = Color( 0, 0, 0 ),
};

WCD:Print( WCD:Translate( "loadedFile", WCD.Lang.fileNames.color or "color" ) );
