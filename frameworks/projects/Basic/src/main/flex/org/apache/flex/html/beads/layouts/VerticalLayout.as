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
package org.apache.flex.html.beads.layouts
{
	import org.apache.flex.core.LayoutBase;
	
	import org.apache.flex.core.IBeadLayout;
	import org.apache.flex.core.IBeadModel;
	import org.apache.flex.core.ILayoutChild;
	import org.apache.flex.core.ILayoutHost;
	import org.apache.flex.core.ILayoutView;
	import org.apache.flex.core.ILayoutParent;
	import org.apache.flex.core.IParentIUIBase;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.core.IUIBase;
	import org.apache.flex.core.ValuesManager;
	COMPILE::JS
	{
		import org.apache.flex.core.WrappedHTMLElement;
	}
	import org.apache.flex.events.Event;
	import org.apache.flex.events.IEventDispatcher;
	import org.apache.flex.geom.Rectangle;
	import org.apache.flex.utils.CSSContainerUtils;
	import org.apache.flex.utils.CSSUtils;

	/**
	 *  The VerticalLayout class is a simple layout
	 *  bead.  It takes the set of children and lays them out
	 *  vertically in one column, separating them according to
	 *  CSS layout rules for margin and horizontal-align styles.
	 *
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion FlexJS 0.0
	 */
	public class VerticalLayout extends LayoutBase implements IBeadLayout
	{
		/**
		 *  Constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 */
		public function VerticalLayout()
		{
			super();
		}

		/**
		 *  Layout children vertically
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion FlexJS 0.0
		 *  @flexjsignorecoercion org.apache.flex.core.ILayoutHost
		 *  @flexjsignorecoercion org.apache.flex.core.WrappedHTMLElement
		 */
		override public function layout():Boolean
		{
			COMPILE::SWF
			{
				var contentView:ILayoutView = layoutView;

				var n:Number = contentView.numElements;
				if (n == 0) return false;

				var maxWidth:Number = 0;
				var maxHeight:Number = 0;
				var hostWidthSizedToContent:Boolean = host.isWidthSizedToContent();
				var hostHeightSizedToContent:Boolean = host.isHeightSizedToContent();
				var hostWidth:Number = host.width;
				var hostHeight:Number = host.height;

				var ilc:ILayoutChild;
				var data:Object;
				var canAdjust:Boolean = false;

				var paddingMetrics:Rectangle = CSSContainerUtils.getPaddingMetrics(host);
				var borderMetrics:Rectangle = CSSContainerUtils.getBorderMetrics(host);
				
				// adjust the host's usable size by the metrics. If hostSizedToContent, then the
				// resulting adjusted value may be less than zero.
				hostWidth -= paddingMetrics.left + paddingMetrics.right + borderMetrics.left + borderMetrics.right;
				hostHeight -= paddingMetrics.top + paddingMetrics.bottom + borderMetrics.top + borderMetrics.bottom;

				var xpos:Number = borderMetrics.left + paddingMetrics.left;
				var ypos:Number = borderMetrics.top + paddingMetrics.top;

				// First pass determines the data about the child.
				for(var i:int=0; i < n; i++)
				{
					var child:IUIBase = contentView.getElementAt(i) as IUIBase;
					if (child == null || !child.visible) continue;
					var positions:Object = childPositions(child);
					var margins:Object = childMargins(child, hostWidth, hostHeight);

					ilc = child as ILayoutChild;

					ypos += margins.top;

					var childXpos:Number = xpos + margins.left; // default x position

					var childWidth:Number = child.width;
					if (ilc != null && !isNaN(ilc.percentWidth)) {
						childWidth = hostWidth * ilc.percentWidth/100.0;
						ilc.setWidth(childWidth);
					}
					else if (ilc.isWidthSizedToContent() && !margins.auto)
					{
						childWidth = hostWidth;
						ilc.setWidth(childWidth);
					}
					if (margins.auto)
						childXpos = (hostWidth - childWidth) / 2;
						
					if (ilc) {
						ilc.setX(childXpos);
						ilc.setY(ypos);

						if (!isNaN(ilc.percentHeight)) {
							var newHeight:Number = hostHeight * ilc.percentHeight / 100;
							ilc.setHeight(newHeight);
						}

					} else {
						child.x = childXpos;
						child.y = ypos;
					}

					ypos += child.height + margins.bottom;
				}

				return true;
			}
			COMPILE::JS
			{
				var children:Array;
				var i:int;
				var n:int;
				var contentView:IParentIUIBase = layoutView as IParentIUIBase;
				contentView.element.style["vertical-align"] = "top";
				
				children = contentView.internalChildren();
				n = children.length;
				for (i = 0; i < n; i++)
				{
					var child:WrappedHTMLElement = children[i] as WrappedHTMLElement;
					if (child == null) continue;
					child.flexjs_wrapper.setDisplayStyleForLayout('block');
					if (child.style.display === 'none')
					{
						child.flexjs_wrapper.setDisplayStyleForLayout('block');
					}
					else
					{
						// block elements don't measure width correctly so set to inline for a second
						child.style.display = 'inline-block';
						child.style.display = 'block';
					}
					child.flexjs_wrapper.dispatchEvent('sizeChanged');
				}

				return true;
			}
		}

	}
}
