(function(){
    var pluginName = 'syntaxer';
	CKEDITOR.plugins.add(pluginName,{
		init:function( editor ){
            var me = this;
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
                    if( element ) {
                        element =   element.getAscendant( 'pre', true )!=null ? 
                                    element.getAscendant( 'pre', true ) : 
                                    element.getAscendant( 'code', true );
                    }
                    // Return a context menu object in an enabled, but not active state.
    				if ( element && !element.isReadOnly() && !element.data( 'cke-realelement' ) )
    		 			return { item : CKEDITOR.TRISTATE_ON };
    				// Return nothing if the conditions are not met.
    		 		return null;
                });
			}
            // add double-click handler
            editor.on( 'doubleclick', function( evt ) {
                // get element from event
                var element = evt.data.element;
                // if on a pre or code element...
                if( ( element.is( 'pre' ) || element.is( 'code' ) ) && !element.data( 'cke-realelement' ) ) {
                    // set the dialog
                    evt.data.dialog= pluginName;
                    console.log( evt )
                    // stop event so it doesn't keep bubbling
                    evt.cancel();
                }
            });
            // add listener for the editor's dom being created
            editor.on( 'contentDom', function( evt ){
                // add mouseover listener; we'll use this to add a fancy hoverable link for editing pre and code tags
                evt.editor.document.on( 'mouseover', function( evt ){
                    var element = evt.data.getTarget();
                    if( ( element.is( 'pre' ) || element.is( 'code' ) ) && !element.data( 'cke-realelement' ) ) {
                        // cleanup any existing helper divs
                        $( '#syntaxer-help' ).remove();
                        // editor position on page
                        var editorDom = $( '.cke_contents');
                        var editorPos = editorDom.position();
                        var windowPos = CKEDITOR.instances.content.window.getScrollPosition();
                        $( '.cke_top' ).css( { position:'relative', zIndex:2 } );
                        // get element position in editor
                        var elementPos= element.getDocumentPosition();
                        // add positions together to get insert locations
                        var pos = {
                            x: editorPos.left + elementPos.x,
                            y: ( editorPos.top + elementPos.y ) - windowPos.y
                        }
                        var helper = [
                            '<div id="syntaxer-help" style="z-index:0;cursor:pointer;border-bottom-right-radius:4px;color:#fafafa;font-size:10px;font-weight:bold;padding:1px 15px 1px 9px;background-color:#333;position:absolute;top:' + pos.y + 'px;left:' + pos.x + 'px;">',
                                '<img src="' + me.path + 'brush.png" style="margin-right:5px;" />Edit Snippet',
                            '</div>'
                        ];
                        $( '.cke_contents' ).append( helper.join('') ).children( '#syntaxer-help' ).click(function( event ) {
                            // get range from document
                            var range = new CKEDITOR.dom.range( editor.document );
                            // move caret to start of currently hovered element
                                range.moveToElementEditablePosition( element, false );
                            // select the range to move the caret
                            editor.getSelection().selectRanges([range]);
                            // execute dialog open command
                            CKEDITOR.instances.content.execCommand( pluginName, element );
                            evt.cancel();
                        });
                        $( '#syntaxer-help' ).delay( 1200 ).fadeOut( 400, function(){
                            $(this).remove();
                        });
                        
                    }
                    else {
                        $( '#syntaxer-help' ).remove();
                    }
                }) 
                evt.editor.document.on( 'scroll', function( evt ){
                    $( '#syntaxer-help' ).remove();
                })
            });
            CKEDITOR.dialog.add( pluginName, this.path + "dialogs/" + pluginName + ".js")            
		}
	});
})();
