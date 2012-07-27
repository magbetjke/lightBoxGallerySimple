package {
import flash.display.Bitmap;

import mx.core.UIComponent;

public class GalleryImage extends UIComponent{

    [Embed(source="/assets/imageBorder.png")]
    private var _imgBorder:Class;

    private var _bitmap:Bitmap = new Bitmap();

    override protected function createChildren():void {
        super.createChildren();

        var border:Bitmap = new _imgBorder;

        border.height = height;
        border.width = width;

        addChild(border);

        _bitmap.x = 5;
        _bitmap.y = 5;

        addChild(_bitmap);
    }

    public function set source(bmp:Bitmap):void {
        if (_bitmap == bmp) return;

        if (_bitmap && contains(_bitmap))
            removeChild(_bitmap);

        _bitmap = bmp;

        if (_bitmap){
            _bitmap.x = 10;
            _bitmap.y = 10;
            _bitmap.width = width - 20;
            _bitmap.height = height - 20;
            addChild(_bitmap);
        }
    }



    public function GalleryImage():void {

    }
}
}