component {
	
	// Module Properties
	this.title 				= "Syntaxer";
	this.author 			= "Joel Watson";
	this.webURL 			= "http://existdissolve.com";
	this.description 		= "A simple module for inserting syntax-highlighted content into your posts and pages.";
	this.version			= "1.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "Syntaxer";
	
	function configure(){
		
		// parent settings
		parentSettings = {
		
		};
	
		// module settings - stored in modules.name.settings
		settings = {
			"expandSource" = "+ expand source",
			"help" = "?",
			"alert" = "SyntaxHighlighter",
			"noBrush" = "Cannot find brush for:",
			"brushNotHtmlScript" = "Brush was not made for html-script option:",
			"viewSource" = "view source",
			"copyToClipboard" = "copy to clipboard",
			"copyToClipboardConfirmation" = "The code is in your clipboard now",
			"print" = "print",
			"stripBrs" = "false",
			"tagName" = "pre",
			"brushes" =  "",
			"defaultBrush" = "",
			"themes" = "",
			"defaultTheme" = "shThemeDefault.css",
			"smart_tabs" = "1",
			"toolbar" = "1",
			"tab_size" = "4",
			"html_script" = "0",
			"highlight" = "",
			"gutter" = "1",
			"first_line" = 1,
			"collapse" = "0",
			"class_name" = "",
			"auto_links" = "1",
			"pad_line_numbers" = "0",
			"quick_code" = "1",
			"light" = "0",
			"unindent" = "1"
		};
		
		// Layout Settings
		layoutSettings = {
			defaultLayout = ""
		};
		
		// datasources
		datasources = {
		
		};
		
		// web services
		webservices = {
		
		};
		
		// SES Routes
		routes = [
			//{pattern="/api-docs", handler="api",action="index"}		
		];		
		
		// Custom Declared Points
		interceptorSettings = {
			customInterceptionPoints = ""
		};
		
		// Custom Declared Interceptors
		interceptors = [
			{ class="#moduleMapping#.interceptors.Syntaxer", name="Syntaxer" }
		];
		
		binder.map( "Syntaxer@Syntaxer" ).to( "#moduleMapping#.model.Syntaxer" );
	}
	
	/**
	* Fired when the module is registered and activated.
	*/
	public void function onLoad(){
		// ContentBox loading
		if( structKeyExists( controller.getSetting( "modules" ), "contentbox" ) ){
    		// Let's add ourselves to the main menu in the Modules section
    		var menuService = controller.getWireBox().getInstance( "AdminMenuService@cb" );
    		// Add Menu Contribution
    		menuService.addSubMenu( 
    			topMenu=menuService.MODULES, 
    			name="Syntaxer", 
    			label="Syntaxer", 
    			href="#menuService.buildModuleLink( 'Syntaxer', 'home.settings')#"
    		);
    		// Override settings?
			var SettingService = controller.getWireBox().getInstance( "SettingService@cb" );
			var criteria = { name="sx_settings" };
			var setting = SettingService.findWhere( criteria=criteria );
			if( !isNull( setting ) ){
				// override settings from contentbox custom setting
				controller.getSetting( "modules" ).Syntaxer.settings = deserializeJSON( setting.getvalue() );
			}
    	}
	}
	
	/**
	 * Fired when the module is activated
	 */
	public void function onActivate() {
		var SettingService = controller.getWireBox().getInstance( "SettingService@cb" );
		// store default settings
		var criteria = { name="sx_settings" };
		var setting = SettingService.findWhere( criteria=criteria );
		if( isNull( setting ) ){
			var args = { name="sx_settings", value=serializeJSON( settings ) };
			var settings = SettingService.new( properties=args );
			SettingService.save( settings );
		}
	}
	
	/**
	 * Fired when the module is deactivated
	 */
	public void function onDeactivate() {
		var SettingService = controller.getWireBox().getInstance( "SettingService@cb" );
		var criteria = { name="sx_settings" };
		var setting = SettingService.findWhere( criteria=criteria );
		if( !isNull( setting ) ) {
			SettingService.delete( setting );
		}
	}
	
	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		// Let's remove ourselves to the main menu in the Modules section
		var menuService = controller.getWireBox().getInstance( "AdminMenuService@cb" );
		// Remove Menu Contribution
		menuService.removeSubMenu( topMenu=menuService.MODULES,name="Syntaxer" );
	}	
}