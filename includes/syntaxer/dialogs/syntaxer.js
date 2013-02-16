(function() {
    var pluginName = 'syntaxer';
    var format=function( code ) {
		code=code.replace(/<br>/g,"\n");
		code=code.replace(/&amp;/g,"&");
		code=code.replace(/&lt;/g,"<");
		code=code.replace(/&gt;/g,">");
		code=code.replace(/&quot;/g,'"');
        code=code.replace(/&nbsp;/g,' ');
		return code;
	};
    CKEDITOR.dialog.add( pluginName, function ( editor ){
        var me = this,
            brushes=[ [ ' Select a brush', '' ]],
            themes=[ [ ' Select a theme', '' ]],
            savedThemes,
            savedBrushes;
        if( Syntaxer ) {
            // build list of saved brushes
            savedBrushes = Syntaxer.settings.brushes.split(',');
            if( savedBrushes.length ) {
                for( var i in savedBrushes ) {
                    var b = savedBrushes[ i ];
                    brushes.push( [ Syntaxer.brushes[ b ].label, b ] );
                }  
            }
            // build list of saved themes
            savedThemes = Syntaxer.settings.themes.split(',');
            if( savedThemes.length ) {
                for( var i in savedThemes ) {
                    var b = savedThemes[ i ];
                    themes.push( [ Syntaxer.themes[ b ].label, b ] );
                }  
            }
            brushes.sort();
            themes.sort();
        }  
    	return {
    		// Basic properties of the dialog window: title, minimum size.
    		title : 'Edit Syntaxer Snippet',
    		minWidth : 400,
    		minHeight : 100,
    		// Dialog window contents.
    		contents :[
    			{
    				// Definition of the Basic Settings dialog window tab (page) with its id, label and contents.
    				id : 'tab1',
    				label : 'Basic Settings',
    				elements : [
                        {
                            type: 'hbox',
                            children: [
                                {
            						type : 'text',
            						id : 'ID', 								
            						label : 'Element ID',
            						setup : function( element ) {
            							this.setValue( element.getAttribute( 'id' ) );
            						},
            						commit : function( element ) {
                                        if( this.getValue() ) {
                                           element.setAttribute( 'id', this.getValue() ); 
                                        }
            						}
            					},
                                {
            						type : 'select',
            						id : 'Type', 								
            						label : 'Element Type',
                                    items: [ [ 'pre' ], [ 'code' ] ],
                                    default: 'pre',
            						setup : function( element ) {
            							this.setValue( element.getName() );
            						}
            					}   
                            ]
                        },
                        {
                            type: 'hbox',
                            children: [
                                {
            						type : 'select',
            						id : 'Brush', 								
            						label : 'Syntax Brush',
                                    items: brushes,
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'brush' ) );
            						}
            					},
                                {
            						type : 'select',
            						id : 'Theme', 								
            						label : 'Syntax Theme',
                                    items: themes,
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'theme' ) );
            						}
            					}  
                            ]
                        },
    					{
    						type : 'textarea',
    						id : 'Code',    
                            rows: 20,								
    						label : 'Code Snippet',
    						validate : CKEDITOR.dialog.validate.notEmpty( "Code Snippet field cannot be empty" ),
    						setup : function( element ) {
    							this.setValue( format( element.getHtml() ) );
    						},
    						commit : function( element ) {
    							element.setText( this.getValue() );
    						}
    					}
    				]
    			},
                {
                    id : 'tab2',
    				label : 'Configuration',
    				elements : [
                        {
                            type: 'hbox',
                            children: [
                                {
            						type : 'radio',
            						id : 'AutoLinks', 								
            						label : 'Auto Link Detection?',
                                    items: [ [ 'Yes', 'true' ], [ 'No', 'false' ] ],
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'auto_links' ) );
            						}
            					},
                                {
            						type : 'radio',
            						label : 'Collapse Element?', 								
            						id : 'Collapse',
                                    items: [ [ 'Yes', 'true' ], [ 'No', 'false' ] ],
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'collapse' ) );
            						}
            					}
                            ]
                        },
                        {
                            type: 'hbox',
                            children: [
                                {
            						type : 'radio',
            						label : 'Show Gutter?', 								
            						id : 'Gutter',
                                    items: [ [ 'Yes', 'true' ], [ 'No', 'false' ] ],
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'gutter' ) );
            						}
            					},  
                                {
            						type : 'radio',
            						label : 'Highlight HTML Script?', 								
            						id : 'HTMLScript',
                                    items: [ [ 'Yes', 'true' ], [ 'No', 'false' ] ],
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'html_script' ) );
            						}
            					}
                            ]
                        },
                        {
                            type: 'hbox',
                            children: [
                                {
            						type : 'radio',
            						label : 'Enable Smart Tabs?', 								
            						id : 'SmartTabs',
                                    items: [ [ 'Yes', 'true' ], [ 'No', 'false' ] ],
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'smart_tabs' ) );
            						}
            					}, 
                                {
            						type : 'radio',
            						label : 'Show Toolbar?', 								
            						id : 'ToolBar',
                                    items: [ [ 'Yes', 'true' ], [ 'No', 'false' ] ],
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'toolbar' ) );
            						}
            					}
                            ]
                        },
                        {
                            type: 'hbox',
                            children: [
                                {
            						type : 'radio',
            						label : 'Pad Line Numbers?', 								
            						id : 'PadLineNumbers',
                                    items: [ [ 'Yes', 'true' ], [ 'No', 'false' ] ],
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'pad_line_numbers' ) );
            						}
            					}, 
                                {
            						type : 'radio',
            						label : 'Allow Quick Code?', 								
            						id : 'QuickCode',
                                    items: [ [ 'Yes', 'true' ], [ 'No', 'false' ] ],
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'quick_code' ) );
            						}
            					}
                            ]
                        },
                        {
                            type: 'hbox',
                            children: [
                                {
            						type : 'radio',
            						label : 'Allow Light Mode?', 								
            						id : 'Light',
                                    items: [ [ 'Yes', 'true' ], [ 'No', 'false' ] ],
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'light' ) );
            						}
            					}, 
                                {
            						type : 'radio',
            						label : 'Allow Unindent?', 								
            						id : 'Unindent',
                                    items: [ [ 'Yes', 'true' ], [ 'No', 'false' ] ],
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'unindent' ) );
            						}
            					}
                            ]
                        },
                        {
                            type: 'hbox',
                            children: [
                                {
            						type : 'text',
            						label : 'CSS Class Name', 								
            						id : 'ClassName',
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'class_name' ) );
            						}
            					},
                                {
            						type : 'text',
            						label : 'Starting Line Number', 								
            						id : 'FirstLine',
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'first_line' ) );
            						}
            					}    
                            ]
                        },
                        {
                            type: 'hbox',
                            children: [
                                {
            						type : 'text',
            						label : 'Highlight Line Numbers', 								
            						id : 'Highlight',
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'highlight' ) );
            						}
            					},
                                {
            						type : 'text',
            						label : 'Tab Size', 								
            						id : 'TabSize',
            						setup : function( element, dialogDef ) {
            							this.setValue( dialogDef.getSyntaxerProperty( element, 'tab_size' ) );
            						}
            					}  
                            ]
                        }
                    ]
                }
    		],
            // this method retrieves a value from the single attribute value of the <pre> or <code> definition
            getSyntaxerProperty: function( element, property ) {
                var me = this,
                    attributes = element.getAttribute( 'class' ) ? element.getAttribute( 'class' ).split( ';' ) : [],
                    key,value,node;
                // loop through properties to find value
                for( var i in attributes ) {
                    node = attributes[ i ];
                    key = node.split( ':' )[ 0 ];
                    value = node.split( ':' )[ 1 ];
                    if( key==property ) {
                        return value;
                    }
                }
                // if property isn't defined, look in defaults
                switch( property ) {
                    case 'brush':
                        if( Syntaxer.settings.defaultBrush ) {
                            return Syntaxer.settings.defaultBrush;
                        }
                        break;
                    case 'theme':
                        if( Syntaxer.settings.defaultTheme ) {
                            return Syntaxer.settings.defaultTheme;
                        }
                        break;
                    default:
                        if( Syntaxer.settings[ property ]!=undefined ) {
                            switch( Syntaxer.settings[ property ] ) {
                                case true: 
                                    return 'true';
                                    break;
                                case false: 
                                    return 'false';
                                    break;
                                default: 
                                    return Syntaxer.settings[ property ];
                                    break;    
                            }
                        }
                        break;
                }
            },
    		// This method is invoked once a dialog window is loaded. 
    		onShow : function() {
    			// Get the element selected in the editor.
    			var sel = editor.getSelection(),
    			// Assigning the element in which the selection starts to a variable.
    				element = sel.getStartElement();
    			
    			// Get the <pre> or <code> element closest to the selection.
    			if ( element ) {
    				element =   element.getAscendant( 'pre', true )!=null ? 
                                element.getAscendant( 'pre', true ) : 
                                element.getAscendant( 'code', true );
    			}
    			// Create a new <pre> element if it does not exist.
    			// For a new <pre> element set the insertMode flag to true.
    			if ( !element || ( element.getName() != 'pre' && element.getName() != 'code' ) || element.data( 'cke-realelement' ) )
    			{
                    // default: pre
    				element = editor.document.createElement( 'pre' );
    				this.insertMode = true;
    			}
    			// If an <pre> or <code> element already exists, set the insertMode flag to false.
    			else {
    				this.insertMode = false;
    			}
    			// Store the reference to the <pre> or <code> element in a variable.
    			this.element = element;
    			
    			// Invoke the setup functions of the element.
    			this.setupContent( this.element, this.definition );
    		},				
    		// This method is invoked once a user closes the dialog window, accepting the changes.
    		onOk : function() {
    			// A dialog window object.
    			var dialog = this,
                    tab1 = dialog._.contents.tab1,   
                    tab2 = dialog._.contents.tab2,           
    				code = dialog.element,
                    type = tab1.Type.getValue(),
                    fields = {
                        theme: tab1.Theme.getValue(),
                        brush: tab1.Brush.getValue(),
                        collapse: tab2.Collapse.getValue(),
                        auto_links: tab2.AutoLinks.getValue(),
                        class_name: tab2.ClassName.getValue(),
                        first_line: tab2.FirstLine.getValue(),
                        gutter: tab2.Gutter.getValue(),
                        highlight: tab2.Highlight.getValue(),
                        html_script: tab2.HTMLScript.getValue(),
                        smart_tabs: tab2.SmartTabs.getValue(),
                        tab_size: tab2.TabSize.getValue(),
                        toolbar: tab2.ToolBar.getValue(),
                        pad_line_numbers: tab2.PadLineNumbers.getValue(),
                        quick_code: tab2.QuickCode.getValue(),
                        light: tab2.Light.getValue(),
                        unindent: tab2.Unindent.getValue()
                    },
                    syntaxConfig='';
    			// rename node to selection
                code.renameNode( type );
                // build class attribute values
                for( var fld in fields ) {
                    if( fields[ fld ] != '' ) {
                        syntaxConfig += fld + ':' + fields[ fld ] + ';';
                    }
                }
                // set all syntaxer config properties to class attribute
                code.setAttribute( 'class', syntaxConfig );
    			// If we are not editing an existing fiddle element, insert a new one.
    			if ( this.insertMode )
    				editor.insertElement( code );
    			
    			// Populate the element with values entered by the user (invoke commit functions).
    			this.commitContent( code );
    		}
    	};
    });
})();
