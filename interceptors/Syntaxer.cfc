component extends="coldbox.system.Interceptor"{
	property name="SettingService" inject="SettingService@cb";
	property name="Syntaxer" inject="Syntaxer@Syntaxer";
	
	/**
	* CKEditor Integrations
	*/
	function cbadmin_ckeditorExtraPlugins( required any event, required struct interceptData ){
		arrayAppend( arguments.interceptData.extraPlugins, "syntaxer" );
	}

	/**
	* CKEditor Integrations
	*/
	function cbadmin_ckeditorToolbar( required any event, required struct interceptData ){
		var itemLen = arrayLen( arguments.interceptData.toolbar );
		for( var x =1; x lte itemLen; x++ ){
			if( isStruct( arguments.interceptData.toolbar[x] )
			    AND arguments.interceptData.toolbar[x].name eq "insert" ){
				arrayAppend( arguments.interceptData.toolbar[x].items, "syntaxer" );
				break;
			}
		}
	}
	
	public void function cbadmin_pageEditorInBody( required Any event, required Struct interceptData ) {
		var args = {
			"settings" = getModuleSettings( "Syntaxer" ).settings,
			"themes" = Syntaxer.getThemes(),
			"brushes" = Syntaxer.getBrushes()
		};
		appendToBuffer( 
			renderView( view='home/js', module="Syntaxer", args=args )
		);
	}
	
	public void function cbui_beforeHeadEnd( required Any event, required Struct interceptData ) {
		var content = "";
		var settings = getModuleSettings( "Syntaxer" ).settings;
		var root = event.getModuleRoot( 'Syntaxer' ) & "/includes/SyntaxHighlighter_3.0.83/";
		var assets = [
			root & 'styles/shCore.css',
			//root & 'styles/#shTheme#',
			root & 'scripts/shCore.js'
		];
		var brushes = Syntaxer.getBrushes();
		var themes = Syntaxer.getThemes();
		var configuredBrushes = settings.brushes;
		var configuredThemes = settings.themes;
		for ( var brush in listToArray( configuredBrushes ) ) {
			arrayAppend( assets, root & 'scripts/#brushes[ brush ].js#' );
		}
		for ( var theme in listToArray( configuredThemes ) ) {
			arrayAppend( assets, root & 'styles/#themes[ theme ].stylesheet#' );
		}
		savecontent variable="content" {
			//writeOutput( getBufferString() );
			writeOutput( addAsset( arrayToList( assets ), false ) );
		};
		appendToBuffer( content );
	}
	
	public void function cbui_beforeBodyEnd(event, interceptData) {
		var content = "";
		savecontent variable="content" {
    		writeOutput("
    			<script type='text/javascript'>
    				SyntaxHighlighter.all();
    			</script>"
    		);
    	}
		appendToBuffer( content );
	}
	
	/**
     * Intercepts on cb_onContentRendering to replace custom tag syntax
     */
	function cb_onContentRendering( required any event, required struct interceptData ) {
		// set regex
		//var regex = "(<(pre|code)[\t\r\n\s]*?(class=.*?brush)[^>]*>(.*?)</(pre|code)>)";
		var regex = "<(pre|code)[\t\r\n\s]*?(class=.*?brush)[^>]*>";
		// get string builder
		var builder = arguments.interceptData.builder;
		// find regex matches 
		var targets = reMatch( regex, builder.toString() );
		var newContent = '';
		var replacer = "";
		// loop over all matches
		for( var match in targets ) {
			replacer = match;
			var themeMatch = reMatch( '(class=.*?theme:[a-z]*;)', replacer );
			var classMatch = reMatch( '(class_name:[a-z]*;)', replacer );
			if( arrayLen( themeMatch ) ) {
				var theme = replaceNoCase( listGetAt( themeMatch[ 1 ], 2, ':' ), ';', '', 'all' );
				var classString = '';
				if( arrayLen( classMatch ) ) {
					replacer = replaceNoCase( replacer, 'class_name:', 'class_name:#theme# ', 'one' ); 
				}
				else {
					replacer = replaceNoCase( replacer, ';"', 'class_name:#theme#;"', 'one' ); ;
				}
			}
			replacer= reReplaceNoCase( replacer, "_", "-", "all" );
			replacer= replaceNoCase( replacer, ';"', 'tagName:code;"', 'one' );
			// find the match syntax position
			var pos = builder.indexOf( match );
			// get the length
			var len = len( match );
			while( pos gt -1 ){
				// Replace it
				builder.replace( javaCast( "int", pos ), JavaCast( "int", pos+len ), replacer );
				// look again
				pos = builder.indexOf( match, javaCast( "int", pos ) );
			}			
		}
	}
}