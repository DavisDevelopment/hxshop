package shop.core;

import tannus.ds.*;
import tannus.io.*;
import tannus.html.*;
import tannus.async.*;

import shop.Globals.*;
import shop.storage.*;
import shop.storage.StorageArea;

import edis.storage.kv.Storage;

using Slambda;
using tannus.ds.ArrayTools;
using StringTools;
using tannus.ds.StringUtils;

@:native('sa.core.ass')
class ApplicationStorage {
    /* Constructor Function */
    public function new(app : Application):Void {
        this.app = app;
        
        var localArea = app.createPersistentStorageArea();
        var sessionArea = app.createTemporaryStorageArea();
        this.local = new Storage( localArea );
        this.session = new Storage( sessionArea );
    }

/* === Instance Methods === */

    /**
      * initialize [this]
      */
    public function initialize(done : VoidCb):Void {
        VoidAsyncs.series([local.initialize, session.initialize], done);
    }

/* === Instance Fields === */

    public var local : Storage;
    public var session : Storage;

    @:noCompletion
    private var app : Application;
}
