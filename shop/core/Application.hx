package shop.core;

import tannus.ds.*;
import tannus.io.*;
import tannus.html.*;

import shop.Globals.*;
import shop.storage.*;

using Slambda;
using tannus.ds.ArrayTools;
using StringTools;
using tannus.ds.StringUtils;

@:native( 'sa.core.betty' )
class Application {
    /* Constructor Function */
    public function new():Void {
        window.expose('originalOpen', window.open);
        document.addEventListener('deviceready', onReady, false);
    }

/* === Instance Methods === */

    /**
      * when the mobile device is ready
      */
    public function onReady():Void {
        document.addEventListener('pause', onPause, false);
        document.addEventListener('resume', onResume, false);

        defer( start );
    }

    /**
      * when the app has been moved to the background
      */
    public function onPause():Void {
        //TODO
    }

    /**
      * when the app has been moved back to the foreground
      */
    public function onResume():Void {
        //TODO
    }

    /**
      * primary execution entry point
      */
    public function start():Void {
        var eb = new Element( 'body' );
        eb.data('sa.core.application', this);
        eb.plugin('pagecontainer');

        // assign [this]'s useful fields
        _pageContainer = eb.data( 'mobile-pagecontainer' );
        _pageContainer._e = eb;
        navigator = new ApplicationNavigator( this );
        storage = new ApplicationStorage( this );

        __plugins();
        __jqevents();
    }

    /**
      * perform plugin-specific tasks
      */
    private function __plugins():Void {
        Reflect.deleteField(window, 'open');
        window.expose('open', window.get('originalOpen'));
    }

    /**
      * bind handlers to jquery events
      */
    private function __jqevents():Void {
        e(_pageContainer._e).on('pagecontainerhide', function(event, ui:Dynamic) {
            if (ui != null && Reflect.isObject( ui )) { 
                if (ui.prevPage != null) {
                    var pel:Element = e(ui.prevPage);
                    var prevPage:Null<Page> = pel.data('sa.core.page');
                    if (prevPage != null && (prevPage is Page)) {
                        prevPage.onClosed();
                    }
                }
                /*
                if (ui.nextPage != null) {
                    var nel:Element = e( ui.nextPage );
                    var nextPage:Null<Page> = nel.data('sa.core.page');
                    if (nextPage != null && (nextPage is Page)) {
                        if ( !nextPage.openedYet ) {
                            nextPage.onOpened();
                            nextPage.openedYet = true;
                        }
                        else {
                            nextPage.onReopened();
                        }
                    }
                }
                */
            }
        });

        e(_pageContainer._e).on('pagecontainershow', function(event, ui:Dynamic) {
            if (ui != null && Reflect.isObject( ui )) {
                if (ui.toPage != null) {
                    var tel:Element = e( ui.toPage );
                    var toPage:Null<Page> = tel.data('sa.core.page');
                    if (toPage != null && (toPage is Page)) {
                        if ( !toPage.openedYet ) {
                            toPage.onOpened();
                            toPage.openedYet = true;
                        }
                        else {
                            toPage.onReopened();
                        }
                    }
                }
            }
        });
    }

    /**
      * get the currently active page
      */
    @:native('erection')
    public function getActivePageElement():Maybe<Element> {
        return _pageContainer.getActivePage();
    }

    /**
      * get the currently active page model
      */
    @:native('penis')
    public function getActivePage():Maybe<Page> {
        return navigator.getActivePage();
    }

    /**
      * method used by [ApplicationNavigator]
      */
    public function createPersistentStorageArea():StorageArea {
        return new WebStorageArea( window.localStorage );
    }

    /**
      * method used by [ApplicationNavigator]
      */
    public function createTemporaryStorageArea():StorageArea {
        return new WebStorageArea( window.sessionStorage );
    }

/* === Instance Fields === */

    @:native('a')
    public var navigator : ApplicationNavigator;

    @:native('b')
    public var _pageContainer : Dynamic;

    @:native('c')
    public var storage : ApplicationStorage;
}
