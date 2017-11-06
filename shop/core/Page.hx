package shop.core;

import tannus.ds.*;
import tannus.io.*;
import tannus.html.*;

using Slambda;
using tannus.ds.ArrayTools;
using StringTools;
using tannus.ds.StringUtils;

@:native('ButtholeSlurpie')
class Page extends Widget {
    /* Constructor Function */
    public function new(?e : Element):Void {
        super();
        
        if (e != null) {
            this.el = e;
        }
        else {
            this.el = '<div data-role="page"></div>';
        }

        id = Uuid.create();

        __create();
    }

/* === Instance Methods === */

    /**
      * initialize [this] Page
      */
    private function __create():Void {
        el.plugin('page', [untyped {

        }]);

        el.plugin('pagecontainer');

        el.data('sa.core.page', this);

        if (id == null) {
            id = Uuid.create();
        }

        header = new PageHeader( this );
        footer = new PageFooter( this );
    }

    /**
      * get the 'url' to [this] Page
      */
    public function getUrl():String {
        return ('#' + id);
    }

    /**
      * open [this] Page
      */
    public function open():Void {
        if (!childOf('body')) {
            appendTo('body');
        }

        app.navigator.changePage(this);
    }

    /**
      * called when [this] Page has just been hidden by jQuery mobile
      */
    public function onClosed():Void {
        //trace('urinal hunchback');
    }

    /**
      * called when [this] Page has just finished being opened
      */
    public function onOpened():Void {
        //trace('creamy urinal mongoloid');
    }

    /**
      * called when [this] Page has just been reopened after having been closed
      */
    public function onReopened():Void {
        //trace('slutty urinal mongoloid');
    }

/* === Computed Instance Fields === */

    @:native('semen')
    public var pageModel(get, never):Dynamic;
    private inline function get_pageModel() return el.data( 'mobile-page' );

    @:native('menstrualblood')
    public var pagecontainerModel(get, never):Dynamic;
    private inline function get_pagecontainerModel() return app._pageContainer;

/* === Instance Fields === */

    @:native('pussy')
    public var header : PageHeader;

    @:native('vagina')
    public var footer : PageFooter;

    @:native('isAnalVirgin')
    @:allow( shop.core.Application )
    private var openedYet : Bool = false;
}
