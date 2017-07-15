////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.utils
{
	COMPILE::SWF
	{
		import flash.display.DisplayObject;
		import flash.events.Event;
	}

	COMPILE::JS
	{
		import org.apache.flex.core.WrappedHTMLElement;
	}

	import org.apache.flex.core.IBead;
	import org.apache.flex.core.ILayoutChild;
	import org.apache.flex.core.ILayoutHost;
	import org.apache.flex.core.ILayoutView;
	import org.apache.flex.core.ILayoutParent;
	import org.apache.flex.core.IParent;
	import org.apache.flex.core.IParentIUIBase;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.events.IEventDispatcher;

	public class MockLayoutParent implements ILayoutParent, ILayoutHost, IStrand, ILayoutChild
	{
		private var _layoutHost:ILayoutHost;
		private var _source:ILayoutParent;
		public function MockLayoutParent(source:ILayoutParent)
		{
			_layoutHost = new MockLayoutHost(source.getLayoutHost());
			_source = source;
		}
		
		public function beforeLayout():void
		{
			// TODO ??
		}
		
		public function afterLayout():void
		{
			// TODO ??	
		}

		public function get parent():IParent
		{
			// TODO Auto Generated method stub
			return null;
		}


		public function addedToParent():void
		{
			// TODO Auto Generated method stub

		}

		public function get alpha():Number
		{
			// TODO Auto Generated method stub
			return 0;
		}

		public function set alpha(value:Number):void
		{
			// TODO Auto Generated method stub

		}

		public function get height():Number
		{
			// TODO Auto Generated method stub
			return 0;
		}

		public function set height(value:Number):void
		{
			// TODO Auto Generated method stub

		}

		public function get topMostEventDispatcher():IEventDispatcher
		{
			// TODO Auto Generated method stub
			return null;
		}

		public function get visible():Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}

		public function set visible(value:Boolean):void
		{
			// TODO Auto Generated method stub

		}

		public function get width():Number
		{
			// TODO Auto Generated method stub
			return 0;
		}

		public function set width(value:Number):void
		{
			// TODO Auto Generated method stub

		}

		public function get x():Number
		{
			// TODO Auto Generated method stub
			return 0;
		}

		public function set x(value:Number):void
		{
			// TODO Auto Generated method stub

		}

		public function get y():Number
		{
			// TODO Auto Generated method stub
			return 0;
		}

		public function set y(value:Number):void
		{
			// TODO Auto Generated method stub

		}


		public function getLayoutHost():ILayoutHost
		{
			return _layoutHost;
		}

		public function get contentView():ILayoutView
		{
			return _layoutHost.contentView;
		}

		public function addBead(bead:IBead):void
		{
			// TODO Auto Generated method stub
		}
		public function registerBead(bead:IBead):void{}
		public function addBeads():void{}

		public function getBeadByType(classOrInterface:Class):IBead
		{
			return (_source as IStrand).getBeadByType(classOrInterface);
		}

		public function removeBead(bead:IBead):IBead
		{
			// TODO Auto Generated method stub
			return null;
		}

		public function get explicitHeight():Number
		{
			// TODO Auto Generated method stub
			return 0;
		}
		public function set explicitHeight(value:Number):void
		{
			// TODO Auto Generated method stub
		}

		public function get explicitWidth():Number
		{
			// TODO Auto Generated method stub
			return 0;
		}
		public function set explicitWidth(value:Number):void
		{
			// TODO Auto Generated method stub
		}

		public function isHeightSizedToContent():Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}

		public function isWidthSizedToContent():Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}

		public function get percentHeight():Number
		{
			// TODO Auto Generated method stub
			return 0;
		}

		public function set percentHeight(value:Number):void
		{
			// TODO Auto Generated method stub

		}

		public function get percentWidth():Number
		{
			// TODO Auto Generated method stub
			return 0;
		}

		public function set percentWidth(value:Number):void
		{
			// TODO Auto Generated method stub

		}

		public function setHeight(value:Number, noEvent:Boolean=false):void
		{
			// TODO Auto Generated method stub

		}

		public function setWidth(value:Number, noEvent:Boolean=false):void
		{
			// TODO Auto Generated method stub

		}

		public function setWidthAndHeight(newWidth:Number, newHeight:Number, noEvent:Boolean=false):void
		{
			// TODO Auto Generated method stub

		}

		public function setX(value:Number):void
		{
			// TODO Auto Generated method stub

		}

		public function setY(value:Number):void
		{
			// TODO Auto Generated method stub

		}

		COMPILE::JS
		public function addEventListener(type:String, handler:Function, opt_capture:Boolean = false, opt_handlerScope:Object = null):void
		{
		}

		COMPILE::SWF
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
		}

		COMPILE::SWF
		public function dispatchEvent(event:Event):Boolean
		{
			return false;
		}

		COMPILE::JS
		public function dispatchEvent(event:Object):Boolean
		{
			return false;
		}

		public function hasEventListener(type:String):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}

		COMPILE::SWF
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
		}

		COMPILE::JS
		public function removeEventListener(type:String, handler:Function, opt_capture:Boolean = false, opt_handlerScope:Object = null):void
		{
			// TODO Auto Generated method stub
		}

		public function willTrigger(type:String):Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}

		COMPILE::SWF
		public function get $displayObject():DisplayObject
		{
			// TODO Auto Generated method stub
			return null;
		}

		COMPILE::JS
		public function get positioner():WrappedHTMLElement
		{
			return null;
		}

		COMPILE::JS
		public function get element():WrappedHTMLElement
		{
			return null;
		}


	}
}
