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
    import org.apache.flex.core.IToggleButtonModel;
    import org.apache.flex.events.Event;
    import org.apache.flex.events.MouseEvent;
    import org.apache.flex.core.IStrand;
    import org.apache.flex.html.TextButton;
    import org.apache.flex.events.IEventDispatcher;
    import org.apache.flex.core.IUIBase;
    import org.apache.flex.mdl.beads.UpgradeChildren;
    import org.apache.flex.mdl.beads.UpgradeElement;

    COMPILE::JS
    {    
        import org.apache.flex.core.WrappedHTMLElement;
    }

    //--------------------------------------
    //  Events
    //--------------------------------------

    /**
     *  Dispatched when the text label is changed.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.8
     */
    [Event(name="textChange", type="org.apache.flex.events.Event")]
    
    /**
     *  Dispatched when the user clicks on Switch.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.8
     */
	[Event(name="click", type="org.apache.flex.events.MouseEvent")]

    /**
     *  Dispatched when Switch is being selected/unselected.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.8
     */
    [Event(name="change", type="org.apache.flex.events.Event")]

    /**
     *  The Material Design Lite (MDL) switch component is an enhanced version of the
     *  standard HTML <input type="checkbox"> element. A switch consists of a short horizontal
     *  "track" with a prominent circular state indicator and, typically, text that clearly 
     *  communicates a binary condition that will be set or unset when the user clicks or touches
     *  it. Like checkboxes, switches may appear individually or in groups, and can be selected 
     *  and deselected individually. However, switches provide a more intuitive visual representation
     *  of their state: left/gray for off, right/colored for on. The MDL switch component allows you
     *  to add both display and click effects.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.8
     */
    public class Switch extends TextButton
    {
        /**
         *  Constructor.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.8
         */
        public function Switch()
        {
            super();

            className = "";
            
            addBead(new UpgradeElement());
            addBead(new UpgradeChildren(["mdl-switch__ripple-container"]));
        }

        /**
         *  @copy org.apache.flex.html.Label#text
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.8
         */
        override public function get text():String
        {
            return IToggleButtonModel(model).text;
        }
        /**
         *  @private
         */
        override public function set text(value:String):void
        {
            IToggleButtonModel(model).text = value;

            COMPILE::JS
            {
                span.textContent = value;
                dispatchEvent('textChange');
            }
        }

        [Bindable("change")]
        /**
         *  <code>true</code> if the Switch is selected.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.8
         */
        public function get selected():Boolean
        {
            return IToggleButtonModel(model).selected;
        }

        public function set selected(value:Boolean):void
        {
            if (IToggleButtonModel(model).selected != value)
            {
                IToggleButtonModel(model).selected = value;


                COMPILE::JS
                {
                    input.checked = value;
                }
                
                dispatchEvent(new Event(Event.CHANGE))
            }
        }

        private var _ripple:Boolean = false;
        /**
         *  A boolean flag to activate "mdl-js-ripple-effect" effect selector.
         *  Applies ripple click effect. May be used in combination with any other classes
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.8
         */
        public function get ripple():Boolean
        {
            return _ripple;
        }

        public function set ripple(value:Boolean):void
        {
            _ripple = value;

            COMPILE::JS
            {
                element.classList.toggle("mdl-js-ripple-effect", _ripple);
                typeNames = element.className;
            }
        }

        COMPILE::JS
        protected var label:HTMLLabelElement;

        COMPILE::JS
        protected var input:HTMLInputElement;

        COMPILE::JS
        private var span:HTMLSpanElement;

        /**
         * @flexjsignorecoercion org.apache.flex.core.WrappedHTMLElement
         * @flexjsignorecoercion HTMLLabelElement
         * @flexjsignorecoercion HTMLInputElement
         * @flexjsignorecoercion HTMLSpanElement
         */
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
            typeNames = "mdl-switch mdl-js-switch";

            label = document.createElement("label") as HTMLLabelElement;
            element = label as WrappedHTMLElement;

            input = document.createElement("input") as HTMLInputElement;
            input.type = "checkbox";
            input.classList.add("mdl-switch__input");

            label.appendChild(input);

            span = document.createElement("span") as HTMLSpanElement;
            span.classList.add("mdl-switch__label");

            label.appendChild(span);

            positioner = element;

            (input as WrappedHTMLElement).flexjs_wrapper = this;
            (span as WrappedHTMLElement).flexjs_wrapper = this;
            element.flexjs_wrapper = this;

            element.addEventListener(MouseEvent.CLICK, clickHandler, false);

            return element;
        }

        COMPILE::JS
        public function clickHandler(event:Event):void
        {
            event.preventDefault();
            selected = !selected;
            input.checked = selected;
            label.classList.toggle("is-checked", selected);
        }
    }
}