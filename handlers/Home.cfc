/**
* A normal ColdBox Event Handler
*/
component{
	// DI
	property name="SettingService" inject="SettingService@cb";
	property name="cb" inject="cbHelper@cb";
	property name="Syntaxer" inject="Syntaxer@Syntaxer";
	
	public void function settings( required Any event, required Struct rc, required Struct prc ){
		// Exit handler
		prc.xehSave = cb.buildModuleLink( "Syntaxer", "home.saveSettings" );
		prc.tabModules_Syntaxer = true;
		// settings
		prc.settings = getModuleSettings( "Syntaxer" ).settings;
		prc.themes = Syntaxer.getThemes();
		prc.brushes= Syntaxer.getBrushes();
		// view
		event.setView( "home/index" );
	}
	
	public void function saveSettings( required Any event, required Struct rc, required Struct prc ){
		// Get module settings
		prc.settings = getModuleSettings( "Syntaxer" ).settings;
		// iterate over settings
		for( var key in prc.settings ){
			// save only sent in setting keys
			if( structKeyExists( rc, key ) ){
				prc.settings[ key ] = rc[ key ];
			}
		}
		// Save settings
		var setting = SettingService.findWhere(criteria={ name="sx_settings" } );
		setting.setValue( serializeJSON( prc.settings ) );
		SettingService.save( setting );
		// Messagebox
		getPlugin( "MessageBox" ).info( "Settings Saved & Updated!" );
		// Relocate via CB Helper
		cb.setNextModuleEvent( "Syntaxer", "home.settings" );
	}
}