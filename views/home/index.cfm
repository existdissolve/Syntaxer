<cfoutput>
    #html.startForm( name="SyntaxerForm", action=prc.cbHelper.buildModuleLink( "Syntaxer", "home.saveSettings" ) )#
    	#html.anchor(name="top")#
        <!--============================Sidebar============================-->
        <div class="sidebar">        
        	<!--- Info Box --->
        	<div class="small_box expose">
        		<div class="header">
        			<img src="#prc.cbroot#/includes/images/info.png" alt="info" width="24" height="24" />About Syntaxer
        		</div>
        		<div class="body">
        			<p>
        				Syntaxer is a simple module that let's you configure settings for using <a href="http://alexgorbatchev.com/SyntaxHighlighter/">Syntax Highlighter</a>.
                        Once configured, you can insert Syntax Highlighter blocks into your views and layouts, or in your page and post content via the super-handy CKEditor plugin!
                    </p>
        		</div>
        	</div>
        
        </div>
        <!--End sidebar-->
        <!--============================Main Column============================-->
        <div class="main_column" id="main_column">
        	<div class="box">
        		<!--- Body Header --->
        		<div class="header">
        			<img src="#event.getModuleRoot( 'Syntaxer' )#/includes/images/brush.png" alt="sofa" width="30" height="30" />Syntaxer Settings
        		</div>
        		<!--- Body --->
        		<div class="body">
            		<!--- messageBox --->
            		#getPlugin( "MessageBox" ).renderit()#
            		<p>Control how the Syntax Highlighter operates and set global configuration information.</p>
            		<!--- Vertical Nav --->
            		<div class="body_vertical_nav clearfix">
            			<!--- Documentation Navigation Bar --->
            			<ul class="vertical_nav">
            				<li class="active"><a href="##general_options"><img src="#prc.cbRoot#/includes/images/layout.png" alt="" width="16" height="16" /> General Options</a></li>
							<li><a href="##brushes"><img src="#event.getModuleRoot( 'Syntaxer' )#/includes/images/paint-brush.png" alt="modifiers" width="16" height="16" /> Brushes</a></li>
            				<li><a href="##defaults_configuration"><img src="#prc.cbRoot#/includes/images/settings_black.png" alt="modifiers" width="16" height="16" /> Default Configuration</a></li>
                            <li><a href="##string_configuration"><img src="#prc.cbRoot#/includes/images/pen.png" alt="modifiers" width="16" height="16" /> Message Text</a></li>            
            			</ul>
            			<!--- Documentation Panes --->
            			<div class="main_column">
            				<!-- Content area that wil show the form and stuff -->
            				<div class="panes_vertical">
            					<div>
            						<fieldset>
            							<legend>
            							    <img src="#prc.cbRoot#/includes/images/layout.png" alt="" width="16" height="16" /> <strong>General Options</strong>
                                        </legend>
        								#html.label( field="stripBrs", content="Strip Break Tabs (&lt;br /&gt;)?")#
        								#html.radioButton( name="stripBrs", checked=prc.settings.stripBrs, value=true )# Yes
        								#html.radioButton( name="stripBrs", checked=not prc.settings.stripBrs, value=false )# No
        								<br /><br />
        								#html.label( field="theme", content="Content Editor Themes" )#
        								<p>These are the themes that will be available when inserting a Syntax Highlighter element in the content editor</p>
            							<cfset sortedThemes = structSort( prc.themes, "textnocase", "asc", "label" )>
            							<cfloop array="#sortedThemes#" index="theme">
            								<cfif listContains( prc.settings.themes, theme )>
            									<cfset checked = "true">
            								<cfelse>
            									<cfset checked = "false">
            								</cfif>
            								#html.checkbox( name="themes", value="#theme#", checked="#checked#" )#
            								#html.label( field="themes", content="#prc.themes[ theme ].label#", class="inline" )#<br/>
            							</cfloop>
            							<br />
                                        #html.label( field="defaultTheme", content="Default Theme" )#
                                        <select name="defaultTheme" class="textfield">
                                            <option value="">Select a default theme</option>
                                            <cfloop array="#sortedThemes#" index="theme">
												<option value="#theme#" <cfif prc.settings.defaultTheme eq theme>selected=true</cfif>>#prc.themes[ theme ].label#</option>
                							</cfloop>
                                        </select>
            						</fieldset>
            					</div>
                                <div>
            						<fieldset>
            							<legend>
            							    <img src="#event.getModuleRoot( 'Syntaxer' )#/includes/images/paint-brush.png" alt="" width="16" height="16" /> <strong>Brush Configuration</strong>
                                        </legend>
                                        #html.label( field="bushes", content="Content Editor Brushes" )#
                                        <p>These are the brushes that will be available when inserting a Syntax Highlighter element in the content editor</p>
                                        <table>
                							<cfset sortedBrushes = structSort( prc.brushes, "textnocase", "asc", "label" )>
											<cfset counter = 1>
                                            <cfloop array="#sortedBrushes#" index="brush">
												<cfif counter eq 1 or counter mod 5 eq 1>
													<tr>
												</cfif>
                								<cfif listContains( prc.settings.brushes, brush )>
                									<cfset checked = "true">
                								<cfelse>
                									<cfset checked = "false">
                								</cfif>
                								<td <cfif counter eq arrayLen( sortedBrushes )>colspan="#counter mod 5#"</cfif>>
                									#html.checkbox( name="brushes", value="#brush#", checked="#checked#" )#
                									#html.label( field="brushes", content="#prc.brushes[ brush ].label#", class="inline" )#
                								</td>
                                                <cfif counter mod 5 eq 0 or counter eq arrayLen( sortedBrushes )>
													</tr>
												</cfif>
                                                <cfset counter++>
                							</cfloop>
            							</table>
                                        <br />
                                        #html.label( field="defaultBrush", content="Default Brush" )#
                                        <select name="defaultBrush" class="textfield">
                                            <option value="">Select a default brush</option>
                                            <cfloop array="#sortedBrushes#" index="brush">
												<option value="#brush#" <cfif prc.settings.defaultBrush eq brush>selected=true</cfif>>#prc.brushes[ brush ].label#</option>
                							</cfloop>
                                        </select>
            						</fieldset>
            					</div>
            					<div>
            						<fieldset>
            							<legend>
            							    <img src="#prc.cbRoot#/includes/images/settings_black.png" alt="" width="16" height="16" /> <strong>Default Configuration</strong>
                                        </legend>
                                        <p>The following configurations will be applied, by default, to all instances of Syntax Highlighter. However, you can easily override them instance by instance if needed.</p>
                                        <table>
                                            <tr>
                                                <td>
                                                    #html.label( field="auto_links", content="Auto Link Detection?" )#
                        							#html.radioButton( name="auto_links", checked=prc.settings.auto_links, value=true )# Yes
                        							#html.radioButton( name="auto_links", checked=not prc.settings.auto_links, value=false )# No    
                                                </td>
                                                <td>
                                                    #html.label( field="gutter", content="Show Gutter?")#
                    								#html.radioButton( name="gutter", checked=prc.settings.gutter, value=true )# Yes
                    								#html.radioButton( name="gutter", checked=not prc.settings.gutter, value=false )# No        
                                                </td>
                                            </tr>
											<tr>
                                                <td>
                                                   	#html.label( field="collpase", content="Collapse Element?")#
                    								#html.radioButton( name="collapse", checked=prc.settings.collapse, value=true )# Yes
                    								#html.radioButton( name="collapse", checked=not prc.settings.collapse, value=false )# No         
                                                </td>
                                                <td>
                                                   	#html.label( field="html_script", content="Highlight HTML Script?")#
                    								#html.radioButton( name="html_script", checked=prc.settings.html_script, value=true )# Yes
                    								#html.radioButton( name="html_script", checked=not prc.settings.html_script, value=false )# No         
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    #html.label( field="smart_tabs", content="Enable Smart Tabs?")#
                        							#html.radioButton( name="smart_tabs", checked=prc.settings.smart_tabs, value=true )# Yes
                        							#html.radioButton( name="smart_tabs", checked=not prc.settings.smart_tabs, value=false )# No
                                                </td>
                                                <td>
                                                    #html.label( field="toolbar", content="Show Toolbar?")#
                        							#html.radioButton( name="toolbar", checked=prc.settings.toolbar, value=true )# Yes
                        							#html.radioButton( name="toolbar", checked=not prc.settings.toolbar, value=false )# No
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    #html.label( field="pad_line_numbers", content="Pad Line Numbers?")#
                        							#html.radioButton( name="pad_line_numbers", checked=prc.settings.pad_line_numbers, value=true )# Yes
                        							#html.radioButton( name="pad_line_numbers", checked=not prc.settings.pad_line_numbers, value=false )# No
                                                </td>
                                                <td>
                                                    #html.label( field="quick_code", content="Allow Quick Code Copy?")#
                        							#html.radioButton( name="quick_code", checked=prc.settings.quick_code, value=true )# Yes
                        							#html.radioButton( name="quick_code", checked=not prc.settings.quick_code, value=false )# No
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    #html.label( field="light", content="Run in Light Mode (No gutter or toolbar)?")#
                        							#html.radioButton( name="light", checked=prc.settings.light, value=true )# Yes
                        							#html.radioButton( name="light", checked=not prc.settings.light, value=false )# No
                                                </td>
                                                <td>
                                                    #html.label( field="unindent", content="Allow Unindent?")#
                        							#html.radioButton( name="unindent", checked=prc.settings.unindent, value=true )# Yes
                        							#html.radioButton( name="unindent", checked=not prc.settings.unindent, value=false )# No
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    #html.textField( name="class_name", label="CSS Class Name", value=prc.settings.class_name, class="textfield", size="60" )#
                                                </td>
                                                <td>
                                                    #html.textField( name="first_line", label="Starting Line Number", value=prc.settings.first_line, class="textfield", size="60" )#
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    #html.textField( name="tab_size", label="Tab Size", value=prc.settings.tab_size, class="textfield", size="60" )#
                                                </td>
                                                <td>
                                                    #html.textField(name="highlight", label="Highlight Line Numbers", value=prc.settings.highlight, class="textfield", size="60" )#
                                                </td>
                                            </tr>
                                        </table>
            						</fieldset>
            					</div>
                                <div>
            						<fieldset>
            							<legend>
            							    <img src="#prc.cbRoot#/includes/images/pen.png" alt="modifiers" width="16" height="16" /> <strong>Message Text</strong>
                                        </legend>
                                        <table>
                                            <tr>
                                                <td>
                                                    #html.textField( name="expandSource", label="Expand Source Text", value=prc.settings.expandSource, class="textfield", size="60" )#
                                                </td>
                                                <td>
                                                    #html.textField( name="help", label="Help Text", value=prc.settings.help, class="textfield", size="60" )#
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    #html.textField( name="alert", label="Alert Text", value=prc.settings.alert, class="textfield", size="60" )#
                                                </td>
                                                <td>
                                                    #html.textField( name="noBrush", label="Brush Not Found Text", value=prc.settings.noBrush, class="textfield", size="60" )#
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    #html.textField( name="brushNotHtmlScript", label="Non_HTML-Script Compatibility Text", value=prc.settings.brushNotHtmlScript, class="textfield", size="60" )#
                                                </td>
                                                <td>
                                                    #html.textField( name="viewSource", label="View Source Text", value=prc.settings.viewSource, class="textfield", size="60" )#
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    #html.textField( name="copyToClipboard", label="Copy To Clipboard Text", value=prc.settings.copyToClipboard, class="textfield", size="60" )#
                                                </td>
                                                <td>
                                                    #html.textField( name="copyToClipboardConfirmation", label="Copy To Clipboard Confirmation Text", value=prc.settings.copyToClipboardConfirmation, class="textfield", size="60" )#
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    #html.textField( name="print", label="Print Text", value=prc.settings.print, class="textfield", size="60" )# 
                                                </td>
                                                <td></td>
                                            </tr>
                                        </table>
            						</fieldset>
            					</div>
            				</div>
                            #html.submitButton( value="Save Settings", class="buttonred", title="Save the comment settings" )#
            				<!--- end panes_vertical --->
            			</div>
            			<!--- end main_column --->
            		</div>
        			<!--- end vertical nav --->
        		</div>
        	</div>
        </div>
    #html.endForm()#
</cfoutput>
