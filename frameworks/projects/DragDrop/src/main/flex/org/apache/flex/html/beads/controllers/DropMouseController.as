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
package org.apache.flex.html.beads.controllers
{
	import org.apache.flex.core.IBead;
	import org.apache.flex.core.IDragInitiator;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.IUIBase;
	import org.apache.flex.events.DragEvent;
	import org.apache.flex.events.EventDispatcher;
	import org.apache.flex.events.IEventDispatcher;
	import org.apache.flex.events.MouseEvent;
	import org.apache.flex.geom.Point;
	import org.apache.flex.utils.PointUtils;
	import org.apache.flex.css2.Cursors;
	
	COMPILE::SWF {
		import flash.display.InteractiveObject;
	}

    /**
     *  Indicates that the mouse has entered the component during
     *  a drag operatino.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.8
     */
    [Event(name="dragEnter", type="org.apache.flex.events.DragEvent")]
    
    /**
     *  Indicates that the mouse is moving over a component during
     *  a drag/drop operation.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.8
     */
    [Event(name="dragOver", type="org.apache.flex.events.DragEvent")]
    
    /**
     *  Indicates that the mouse is moving out of a component during
     *  a drag/drop operation.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.8
     */
    [Event(name="dragExit", type="org.apache.flex.events.DragEvent")]
    
    /**
     *  Indicates that a drop operation should be executed.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.8
     */
    [Event(name="dragDrop", type="org.apache.flex.events.DragEvent")]
    
	/**
	 *  The DropMouseController bead handles mouse events on the 
	 *  a component, looking for events from a drag/drop operation.
	 *  
     *  @flexjsignoreimport org.apache.flex.core.IDragInitiator
     * 
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.8
	 */
	public class DropMouseController extends EventDispatcher implements IBead
	{		
		/**
		 *  constructor.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.8
		 */
		public function DropMouseController()
		{
		}
		        
		private var _strand:IStrand;
		
		/**
		 *  @copy org.apache.flex.core.IBead#strand
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.8
		 */
		public function set strand(value:IStrand):void
		{
			_strand = value;
			
            COMPILE::SWF
            {
                // consider using [Mixin] and requiring MixinManager
                DragEvent.init();
            }
            IEventDispatcher(_strand).addEventListener(DragEvent.DRAG_MOVE, dragMoveHandler);
		}
		
		public function get strand():IStrand
		{
			return _strand;
		}
        
        private var inside:Boolean;
        
        private var dragSource:Object;
        private var dragInitiator:IDragInitiator;
        
        public function acceptDragDrop(target:IUIBase, type:String):void
        {
            // TODO: aharui: switch icons
        }
        
        /**
         *  @private
		 * @flexjsignorecoercion org.apache.flex.events.MouseEvent
         */
        private function dragMoveHandler(event:DragEvent):void
        {
//            trace("DROP-MOUSE: dragMove" + event.target.toString());
            var dragEvent:DragEvent;
            if (!inside)
            {
                dragEvent = DragEvent.createDragEvent("dragEnter", event as MouseEvent);
				dispatchEvent(dragEvent);
                inside = true;
                IUIBase(_strand).addEventListener(DragEvent.DRAG_END, dragEndHandler);
                IUIBase(_strand).addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
				
				Cursors.setCursor(_strand as IUIBase, Cursors.MOVE);
            }
            else
            {
                dragEvent = DragEvent.createDragEvent("dragOver", event as MouseEvent);
				dispatchEvent(dragEvent);
            }
        }
        
        private function rollOutHandler(event:MouseEvent):void
        {
            var dragEvent:DragEvent;
            
            if (inside)
            {
                dragEvent = DragEvent.createDragEvent("dragExit", event);
				dispatchEvent(dragEvent);
                inside = false;
				
				Cursors.setCursor(_strand as IUIBase, Cursors.AUTO);
            }
            IUIBase(_strand).removeEventListener(DragEvent.DRAG_END, dragEndHandler);
            IUIBase(_strand).removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);			
        }
        
		/**
		 * @flexjsignorecoercion org.apache.flex.events.MouseEvent
		 */
        private function dragEndHandler(event:DragEvent):void
        {
            trace("DROP-MOUSE: dragEnd received for event via: "+event.target.toString());
            var dragEvent:DragEvent;
			            
			var screenPoint:Point = new Point(event.screenX, event.screenY);
			var newPoint:Point = PointUtils.globalToLocal(screenPoint, _strand);
            dragEvent = DragEvent.createDragEvent("dragDrop", event as MouseEvent);
			dragEvent.clientX = newPoint.x;
			dragEvent.clientY = newPoint.y;
			COMPILE::SWF {
				dragEvent.relatedObject = event.target as InteractiveObject;
			}
			COMPILE::JS {
				dragEvent.relatedObject = event.target;
			}
						
			DragEvent.dispatchDragEvent(dragEvent, this); 
            
            inside = false;
            IUIBase(_strand).removeEventListener(DragEvent.DRAG_END, dragEndHandler);
            IUIBase(_strand).removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);	
			
			Cursors.setCursor(_strand as IUIBase, Cursors.AUTO);
        }
		
	}
}
