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
    import org.apache.flex.mdl.beads.models.IToastModel;
    import org.apache.flex.core.UIBase;
    import org.apache.flex.events.Event;

    COMPILE::JS
    {    
        import org.apache.flex.core.WrappedHTMLElement;
    }

    /**
     *  Toast are transient popup notifications without actions like Snackbar (see
     *  Snackbar class) without user actions implied.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.8
     */
    public class Toast extends UIBase
    {
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.8
         */
        public function Toast()
        {
            super();

            className = "";
        }

        /**
         *  Message to be displayed on Snackbar
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.8
         */
        public function get message():String
        {
            return IToastModel(model).message;
        }
        /**
         *  @private
         */
        public function set message(value:String):void
        {
            IToastModel(model).message = value;
        }

        /**
         *  Timout in milliseconds for hiding Snackbar
         *
         *  @default 2750
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.8
         */
        public function get timeout():int
        {
            return IToastModel(model).timeout;
        }
        /**
         *  @private
         */
        public function set timeout(value:int):void
        {
            IToastModel(model).timeout = value;
        }

        /**
         *  Show the snackbar
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.8
         */
        public function show():void
        {
            if (snackbar)
            {
                var snackbarData:Object = IToastModel(model).snackbarData;
                snackbar.showSnackbar(snackbarData);
            }
            //dispatchEvent(new Event("action"));
        }

        protected var snackbar:Object;

        COMPILE::JS
        private var snackbarAction:HTMLButtonElement;

        COMPILE::JS
        private var snackbarText:HTMLDivElement;

        /**
         * @flexjsignorecoercion org.apache.flex.core.WrappedHTMLElement
         * @flexjsignorecoercion HTMLDivElement
         * @flexjsignorecoercion HTMLButtonElement
         *
         * @return
         */
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
            typeNames = "mdl-js-snackbar mdl-snackbar";

            element = document.createElement("div") as WrappedHTMLElement;
            element.addEventListener("mdl-componentupgraded", onElementMdlComponentUpgraded, false);

            snackbarText = document.createElement("div") as HTMLDivElement;
            snackbarText.classList.add("mdl-snackbar__text");
            element.appendChild(snackbarText);

            snackbarAction = document.createElement("button") as HTMLButtonElement;
            snackbarAction.classList.add("mdl-snackbar__action");
            element.appendChild(snackbarAction);

            positioner = element;
            element.flexjs_wrapper = this;

            return element;
        }

        /**
         *  @private
         */
        private function onElementMdlComponentUpgraded(event:Event):void
        {
            if (!event.currentTarget) return;

            snackbar = event.currentTarget.MaterialSnackbar;
        }
    }
}
