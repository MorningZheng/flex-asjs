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
package org.apache.flex.mdl
{
	import org.apache.flex.html.List;

    COMPILE::JS
    {
        import org.apache.flex.core.WrappedHTMLElement;        
    }

	/**
	 *  List in MDL are customizable scrollable lists. Lists present multiple line 
	 *  items vertically as a single continuous element.
	 *  
	 *  In FlexJS MDL relies on an itemRenderer factory to produce its children components
	 *  and on a layout to arrange them. This is the only UI element aside from the itemRenderers.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */ 
	public class List extends org.apache.flex.html.List
	{
		/**
		 * @flexjsignorecoercion org.apache.flex.core.WrappedHTMLElement
		 */
		COMPILE::JS
		override protected function createElement():WrappedHTMLElement
		{
			typeNames = "mdl-list";
			
			element = document.createElement('ul') as WrappedHTMLElement;
			
			positioner = element;
			element.flexjs_wrapper = this;
			
			return positioner;
		}
	}
}
