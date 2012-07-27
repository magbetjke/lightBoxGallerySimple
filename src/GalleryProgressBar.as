package {
import flash.display.Bitmap;
import flash.display.DisplayObjectContainer;
import flash.display.Shape;
import flash.display.Sprite;

import mx.core.UIComponent;

//Singleton Class

public class GalleryProgressBar extends Sprite {

    //-------------Singleton Start--------------//

    private static var _instance:GalleryProgressBar;

    public static function get instance():GalleryProgressBar {
        if (!_instance) _instance = new GalleryProgressBar(new SingletonData());
        return _instance;
    }

    //--------------Singleton End---------------//

    [Embed(source="/assets/progress.png")]
    private var ProgressBMP:Class;

    private var _progressBar:Bitmap;

    private var _preloaderWidth:uint = 200;
    private var _preloaderHeight:uint = 30;

    private var _mask:Shape;

    private var _parent:DisplayObjectContainer;

    public function GalleryProgressBar(singletonData:SingletonData):void {
        init();
    }

    private function init():void {
        _progressBar = new ProgressBMP;

        _progressBar.scaleX = scaleY = _preloaderWidth / _progressBar.width;

        _mask = new Shape();
        _mask.graphics.clear();
        _mask.graphics.beginFill(0x00FF00);
        _mask.graphics.drawRect(0, 0, _progressBar.width, _progressBar.height);
        _mask.graphics.endFill();

        _mask.cacheAsBitmap = true;
        addChild(_mask);

        _progressBar.cacheAsBitmap = true;
        addChild(_progressBar);

        _progressBar.mask = _mask;
    }

    public function open(parent:DisplayObjectContainer):void {
        _parent = parent;
        x = (_parent.width - width) >> 1;
        y = (_parent.height - height) >> 1;
        _parent.mouseEnabled = false;
        _parent.addChild(this);
        _mask.width = 1;
    }

    public function progress(value:Number):void {
        _mask.width = _progressBar.width * value;
    }

    public function close():void {
        if (!_parent || !_parent.contains(this)) return;

        _parent.removeChild(this);
        _parent.mouseEnabled = true;
    }
}
}

//Private Singleton class

class SingletonData {
    public function SingletonData():void {
        //private class constructor
    }
}