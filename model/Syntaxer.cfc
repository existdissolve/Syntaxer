component accessors="true" singleton {
	property name="settings" inject="coldbox:moduleSettings:Syntaxer";
	property name="SettingService" 	inject="settingService@cb";
	property name="brushes" type="struct";
	property name="themes" type="struct"; 

	// Constructor
	function init(){
		themes = {
    		"default" = {
            	"label" = "Default",
                "stylesheet" = "shThemeDefault.css"
            },
    		"django" = {
            	"label" = "Django",
                "stylesheet" = "shThemeDjango.css"
            },
    		"eclipse" = {
            	"label" = "Eclipse",
                "stylesheet" = "shThemeEclipse.css"
            },
    		"emacs" = {
            	"label" = "Emacs",
                "stylesheet" = "shThemeEmacs.css"
            },
    		"fadetogrey" = {
            	"label" = "Fade to Grey",
                "stylesheet" = "shThemeFadeToGrey.css"
            },
    		"midnight" = {
            	"label" = "Midnight",
                "stylesheet" = "shThemeMidnight.css"
            },
    		"rdark" = {
            	"label" = "RDark",
                "stylesheet" = "shThemeRDark.css"
            }
    	};
    	brushes = {
    		"actionscript3" = {
            	"label" = "ActionScript 3",
            	"js" = "shBrushAS3.js"
            },
    		"bash_shell" = {
            	"label" = "Bash Shell",
            	"js" = "shBrushBash.js"
            },
    		"coldfusion" = {
            	"label" = "ColdFusion",
            	"js" = "shBrushColdFusion.js"
            },
    		"csharp" = {
            	"label" = "C##",
            	"js" = "shBrushCSharp.js"
            },
    		"cpp" = {
            	"label" = "CPP",
            	"js" = "shBrushCpp.js"
            },
    		"css" = {
            	"label" = "CSS",
            	"js" = "shBrushCss.js"
            },
    		"delphi" = {
            	"label" = "Delphi",
            	"js" = "shBrushDelphi.js"
            },
    		"diff" = {
            	"label" = "Diff",
            	"js" = "shBrushDiff.js"
            },
    		"erlang" = {
            	"label" = "Erlang",
            	"js" = "shBrushErlang.js"
            },
    		"groovy" = {
            	"label" = "Groovy",
            	"js" = "shBrushGroovy.js"
            },
    		"javascript" = {
            	"label" = "JavaScript",
            	"js" = "shBrushJScript.js"
            },
    		"java" = {
            	"label" = "Java",
            	"js" = "shBrushJava.js"
            },
    		"javafx" = {
            	"label" = "JavaFX",
            	"js" = "shBrushJavaFX.js"
            },
    		"perl" = {
            	"label" = "Perl",
            	"js" = "shBrushPerl.js"
            },
    		"php" = {
            	"label" = "PHP",
            	"js" = "shBrushPhp.js"
            },
    		"plain_text" = {
            	"label" = "Plain Text",
            	"js" = "shBrushPlain.js"
            },
    		"powershell" = {
            	"label" = "Power Shell",
            	"js" = "shBrushPowerShell.js"
            },
    		"python" = {
            	"label" = "Python",
            	"js" = "shBrushPython.js"
            },
    		"ruby" = {
            	"label" = "Ruby",
            	"js" = "shBrushRuby.js"
            },
    		"scala" = {
            	"label" = "Scala",
            	"js" = "shBrushScala.js"
            },
    		"sql" = {
            	"label" = "SQL",
            	"js" = "shBrushSQL.js"
            },
    		"visual_basic" = {
            	"label" = "Visual Basic",
            	"js" = "shBrushVb.js"
            },
    		"xml" = {
            	"label" = "XML",
            	"js" = "shBrushXml.js"
            }
    	};
		return this;
	}
}