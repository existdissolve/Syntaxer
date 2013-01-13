(function(){
    var pluginName = 'syntaxer';
   
	CKEDITOR.plugins.add(pluginName,{
		init:function( editor ){
            // add a custom stylesheet to the editor so we can style the <pre> and <code> tags
            if( typeof CKEDITOR.config.contentsCss=='object' ) {
                CKEDITOR.config.contentsCss.push( this.path + 'editor.css' );
            }  
            else {
                CKEDITOR.config.contentsCss = [ CKEDITOR.config.contentsCss, this.path + 'editor.css' ];
            }                             
            // add insert command
			editor.addCommand( pluginName, new CKEDITOR.dialogCommand( pluginName ) );
            // add button to toolbar
			editor.ui.addButton(pluginName,{
				label:'Insert Syntaxer Snippet',
				icon: this.path + 'brush.png',
				command:pluginName
			});
            // Define an editor command that allows modification of the element. 
		    editor.addCommand( pluginName, new CKEDITOR.dialogCommand( pluginName ) );
			// context menu
			if (editor.addMenuItem) {
				// Create a menu item
				editor.addMenuItem(pluginName, {
					label: 'Insert Syntaxer Snippet',
					command: pluginName,
					icon: this.path + 'brush.png',
					order: 5
				});
    			// Register a new context menu item for editing existing element.
    			editor.addMenuItem( 'item',
    			{
    				// Item label.
    				label : 'Edit Syntaxer Snippet',
    				// Item icon path using the variable defined above.
    				icon: this.path + 'brush.png',
    				// Reference to the plugin command name.
    				command : pluginName,
    				// Context menu group that this entry belongs to.
    				group : 'clipboard'
    			});
			}
            // handle context menu actions
			if (editor.contextMenu) {
                // listener for insert
				editor.contextMenu.addListener(function( element, selection ) {
					return { syntaxer: CKEDITOR.TRISTATE_ON };
				});
                // listener for right-click on <pre> or <code> element
    			editor.contextMenu.addListener( function( element ) {
    				// Get to the closest <pre> or <code> element that contains the selection.
    				if ( element ) {
                        element = element.getAscendant( 'pre', true );
                    }
    				// Return a context menu object in an enabled, but not active state.
    				if ( element && !element.isReadOnly() && !element.data( 'cke-realelement' ) )
    		 			return { item : CKEDITOR.TRISTATE_ON };
    				// Return nothing if the conditions are not met.
    		 		return null;
    			});
                editor.contextMenu.addListener( function( element ) {
    				// Get to the closest <pre> or <code> element that contains the selection.
    				if ( element ) {
                        element = element.getAscendant( pluginName, true );
                    }
    				// Return a context menu object in an enabled, but not active state.
    				if ( element && !element.isReadOnly() && !element.data( 'cke-realelement' ) )
    		 			return { item : CKEDITOR.TRISTATE_ON };
    				// Return nothing if the conditions are not met.
    		 		return null;
    			});
			}
            CKEDITOR.dialog.add( pluginName, this.path + "dialogs/" + pluginName + ".js")            
		}
	});
})();
