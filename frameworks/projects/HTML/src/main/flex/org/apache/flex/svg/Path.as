/**
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.flex.svg
{
    import org.apache.flex.graphics.IPath;
    import org.apache.flex.graphics.PathBuilder;

    COMPILE::SWF
    {
        import flash.display.GraphicsPath;
        import flash.geom.Point;
        import flash.geom.Rectangle;
        import org.apache.flex.graphics.utils.PathHelper;
    }
    COMPILE::JS
    {
        import org.apache.flex.core.WrappedHTMLElement;
    }


    public class Path extends GraphicShape implements IPath
    {

        private var _data:String;

        public function get data():String
        {
            return _data;
        }

        public function set data(value:String):void
        {
            _data = value;
            _pathCommands = null;
        }
        
        private var _pathCommands:PathBuilder;

        public function get pathCommands():PathBuilder
        {
            return _pathCommands;
        }

        public function set pathCommands(value:PathBuilder):void
        {
            _pathCommands = value;
            _data = _pathCommands.getPathString();
        }

        
        COMPILE::JS
        private var _path:WrappedHTMLElement;

        /**
         *  Draw the path.
         *  @param data A PathBuilder object containing a vector of drawing commands.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         *  @flexjsignorecoercion org.apache.flex.core.WrappedHTMLElement
         */
        public function drawPathCommands(xp:Number,yp:Number,data:PathBuilder):void
        {
            drawStringPath(xp,yp,data.getPathString());
        }

        /**
         *  Draw the path.
         *  @param data A string containing a compact represention of the path segments.
         *  The value is a space-delimited string describing each path segment. Each
         *  segment entry has a single character which denotes the segment type and
         *  two or more segment parameters.
         *
         *  If the segment command is upper-case, the parameters are absolute values.
         *  If the segment command is lower-case, the parameters are relative values.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         *  @flexjsignorecoercion org.apache.flex.core.WrappedHTMLElement
         */
        public function drawStringPath(xp:Number,yp:Number,data:String):void
        {
            COMPILE::SWF
            {
                $sprite.graphics.clear();
                applyStroke();
                var bounds:Rectangle = PathHelper.getBounds(data);
                this.width = bounds.width;
                this.height = bounds.height;
                beginFill(bounds,new Point(bounds.left + xp, bounds.top + yp) );
                var graphicsPath:GraphicsPath = PathHelper.getSegments(data,xp,yp);
                $sprite.graphics.drawPath(graphicsPath.commands, graphicsPath.data);
                endFill();
            }
            COMPILE::JS
            {
                if (data == null || data.length === 0) return;
                var style:String = getStyleStr();
                if (_path == null) {
                    _path = document.createElementNS('http://www.w3.org/2000/svg', 'path') as WrappedHTMLElement;
                    _path.flexjs_wrapper = this;
                    element.appendChild(_path);
                }
                _path.setAttribute('style', style);
                _path.setAttribute('d', data);

                resize(x, y, _path['getBBox']());

            }
        }

        override protected function drawImpl():void
        {
            drawStringPath(0, 0, data);
        }
    }
}
