package sa;

import tannus.ds.*;
import tannus.io.*;
import tannus.html.*;
import tannus.http.*;
import tannus.async.*;

import sa.core.CordovaPlatform;

using Slambda;
using tannus.ds.ArrayTools;
using StringTools;
using tannus.ds.StringUtils;

class Globals {
    /**
      * alias to jQuery
      */
    public static inline function e(sel : Dynamic):Element {
        return new Element( sel );
    }

    /**
      * defer a call to [action] to the next call stack
      */
    public static inline function defer(action:Void->Void):Void {
        window.requestAnimationFrame(untyped action);
    }

    /**
      * report an error
      */
    public static inline function report(error : Dynamic):Void {
        (untyped __js__('console.error'))( error );
    }

/* === Static AJAX Methods === */

    /**
      * request a file via AJAX
      */
    private static function _getreq<T>(method:String, url:String, loader:WebRequest->Cb<T>->Void, callback:Cb<T>, ?pre_reqf:WebRequest->Void):Void {
        var req:WebRequest = new WebRequest();
        req.open(method, url);
        if (pre_reqf != null) {
            pre_reqf( req );
        }
        loader(req, callback);
        req.send();
    }

    /**
      * GET as a String
      */
    public static function ajaxString(method:String, url:String, callback:Cb<String>, ?pre:WebRequest->Void):Void {
        _getreq(method, url, function(req, done) {
            req.loadAsText(done.yield());
            req.onError(untyped done.raise());
        }, callback, pre);
    }

    /**
      * GET as a ByteArray
      */
    public static function ajaxByteArray(method:String, url:String, callback:Cb<ByteArray>, ?pre:WebRequest->Void):Void {
        _getreq(method, url, function(req, done) {
            req.loadAsByteArray(done.yield());
            req.onError(untyped done.raise());
        }, callback, pre);
    }

    public static function ajaxObject(method:String, url:String, callback:Cb<Obj>, ?pre:WebRequest->Void):Void {
        _getreq(method, url, function(req, done) {
            req.loadAsObject(done.yield());
            req.onError(untyped done.raise());
        }, callback, pre);
    }

    public static function ajaxDocument(method:String, url:String, callback:Cb<js.html.Document>, ?pre:WebRequest->Void):Void {
        _getreq(method, url, function(req, done) {
            req.loadAsDocument(done.yield());
            req.onError(untyped done.raise());
        }, callback, pre);
    }

/* === Static Fields === */

    public static var window(get, never):Win;
    private static inline function get_window() return Win.current;

    public static var document(get, never):js.html.HTMLDocument;
    private static inline function get_document() return window.document;

    public static var platform(get, never):CordovaPlatform;
    private static inline function get_platform() return untyped __js__('device.platform');

    public static var us(get, never):Dynamic;
    private static inline function get_us() return _;

    public static var _ : Dynamic = {js.Lib.require('underscore');};
}
