/**
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

goog.provide('org.apache.flex.html.supportClasses.ContainerContentArea');

goog.require('org.apache.flex.core.UIBase');



/**
 * @constructor
 * @extends {org.apache.flex.core.UIBase}
 */
org.apache.flex.html.supportClasses.ContainerContentArea =
function() {
  org.apache.flex.html.supportClasses.ContainerContentArea.base(this, 'constructor');
};
goog.inherits(
    org.apache.flex.html.supportClasses.ContainerContentArea,
    org.apache.flex.core.UIBase);


/**
 * Metadata
 *
 * @type {Object.<string, Array.<Object>>}
 */
org.apache.flex.html.supportClasses.ContainerContentArea.prototype.FLEXJS_CLASS_INFO =
    { names: [{ name: 'ContainerContentArea',
                qName: 'org.apache.flex.html.supportClasses.ContainerContentArea' }]};


/**
 * @override
 */
org.apache.flex.html.supportClasses.ContainerContentArea.prototype.createElement =
    function() {
  this.element = document.createElement('div');

  this.positioner = this.element;
  // absolute positioned children need a non-null
  // position value in the parent.  It might
  // get set to 'absolute' if the container is
  // also absolutely positioned
  this.positioner.style.position = 'relative';
  this.element.flexjs_wrapper = this;

  return this.element;
};
