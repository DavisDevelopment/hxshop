package shop.core;

import tannus.ds.*;
import tannus.io.*;
import tannus.html.*;

import foundation.Widget as Wijit;

import Reflect.*;

using Slambda;
using tannus.ds.ArrayTools;
using StringTools;
using tannus.ds.StringUtils;

class Widget extends Wijit {
    /* Constructor Function */
    public function new():Void {
        super();

        _call = makeVarArgs(function(args : Array<Dynamic>) {
            if (args.length > 1 && el != null) {
                return callMethod(this.el, getProperty(this.el, Std.string(args.shift())), args);
            }
            else return null;
        });
    }

/* === Instance Methods === */

/* === Computed Instance Fields === */

    public var ebody(get, never):Element;
    private inline function get_ebody() return new Element('body');

    public var app(get, never):Application;
    private inline function get_app():Application return ebody.data('sa.core.application');

    public var id(get, set):Null<String>;
    private inline function get_id() return el['id'];
    private inline function set_id(v) return (el['id'] = v);

/* === Instance Fields === */

    public var _call : Dynamic;
}
