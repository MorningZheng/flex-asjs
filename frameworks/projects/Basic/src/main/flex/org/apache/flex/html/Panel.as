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
package org.apache.flex.html
{
	import org.apache.flex.core.IPanelModel;
	import org.apache.flex.core.IChild;
	import org.apache.flex.html.beads.PanelView;
	import org.apache.flex.events.Event;

    COMPILE::JS
    {
        import org.apache.flex.core.WrappedHTMLElement;
    }
    
	[Event(name="close", type="org.apache.flex.events.Event")]
	
	/**
	 *  The Panel class is a Container component capable of parenting other
	 *  components. The Panel has a TitleBar.  If you want to a Panel with
     *  a ControlBar, use PanelWithControlBar which
     *  will instantiate, by default, an ControlBar. 
	 *  The Panel uses the following bead types:
	 * 
	 *  org.apache.flex.core.IBeadModel: the data model for the Panel that includes the title and whether
	 *  or not to display the close button.
	 *  org.apache.flex.core.IBeadView: creates the parts of the Panel.
	 *  org.apache.flex.core.IBorderBead: if present, draws a border around the Panel.
	 *  org.apache.flex.core.IBackgroundBead: if present, provides a colored background for the Panel.
	 *  
     *  @toplevel
	 *  @see PanelWithControlBar
	 *  @see ControlBar
	 *  @see TitleBar
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class Panel extends Group
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function Panel()
		{
			super();
			
			className = "Panel";
		}
		
		public function $addElement(c:IChild, dispatchEvent:Boolean = true):void
		{
			super.addElement(c, dispatchEvent);
		}
		
		public function get $numElements():Number
		{
			return super.numElements;
		}
		
		public function $getElementAt(index:Number):IChild
		{
			return super.getElementAt(index);
		}
		
		/**
		 *  The string to display in the org.apache.flex.html.TitleBar.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function get title():String
		{
			return IPanelModel(model).title;
		}
		public function set title(value:String):void
		{
			IPanelModel(model).title = value;
		}
		
		/**
		 *  The HTML string to display in the org.apache.flex.html.TitleBar.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function get htmlTitle():String
		{
			return IPanelModel(model).htmlTitle;
		}
		public function set htmlTitle(value:String):void
		{
			IPanelModel(model).htmlTitle = value;
		}
		
		/**
		 * Whether or not to show a Close button in the org.apache.flex.html.TitleBar.
		 */
		public function get showCloseButton():Boolean
		{
			return IPanelModel(model).showCloseButton;
		}
		public function set showCloseButton(value:Boolean):void
		{
			IPanelModel(model).showCloseButton = value;
		}
		
		
		/**
		 * @private
		 * @flexjsignorecoercion org.apache.flex.html.beads.PanelView
		 */
		override public function addElement(c:IChild, dispatchEvent:Boolean = true):void
		{
			var panelView:PanelView = view as PanelView;
			panelView.contentArea.addElement(c, dispatchEvent);
			panelView.contentArea.dispatchEvent(new Event("layoutNeeded"));
		}
		
		/**
		 * @private
		 * @flexjsignorecoercion org.apache.flex.html.beads.PanelView
		 */
		override public function addElementAt(c:IChild, index:int, dispatchEvent:Boolean = true):void
		{
			var panelView:PanelView = view as PanelView;
			panelView.contentArea.addElementAt(c, index, dispatchEvent);
			panelView.contentArea.dispatchEvent(new Event("layoutNeeded"));
		}
		
		/**
		 * @private
		 * @flexjsignorecoercion org.apache.flex.html.beads.PanelView
		 */
		override public function getElementIndex(c:IChild):int
		{
			var panelView:PanelView = view as PanelView;
			return panelView.contentArea.getElementIndex(c);
		}
		
		/**
		 * @private
		 * @flexjsignorecoercion org.apache.flex.html.beads.PanelView
		 */
		override public function removeElement(c:IChild, dispatchEvent:Boolean = true):void
		{
			var panelView:PanelView = view as PanelView;
			panelView.contentArea.removeElement(c, dispatchEvent);
		}
		
		/**
		 * @private
		 * @flexjsignorecoercion org.apache.flex.html.beads.PanelView
		 */
		override public function get numElements():int
		{
			var panelView:PanelView = view as PanelView;
			return panelView.contentArea.numElements;
		}
		
		/**
		 * @private
		 * @flexjsignorecoercion org.apache.flex.html.beads.PanelView
		 */
		override public function getElementAt(index:int):IChild
		{
			var panelView:PanelView = view as PanelView;
			return panelView.contentArea.getElementAt(index);
		}
	}
}
