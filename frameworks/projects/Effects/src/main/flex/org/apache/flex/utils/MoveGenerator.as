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
	import org.apache.flex.core.ILayoutChild;
	import org.apache.flex.core.IUIBase;
	import org.apache.flex.effects.IEffect;
	import org.apache.flex.effects.Move;
	
	public class MoveGenerator implements IEffectsGenerator
	{
		public function MoveGenerator()
		{
		}
		
		public function generateEffect(source:ILayoutChild, destination:ILayoutChild):IEffect
		{
			var xDiff:Number = destination.x - source.x;
			var yDiff:Number = destination.y - source.y;
			if (xDiff != 0 || yDiff != 0)
			{
				var move:Move = new Move(source as IUIBase);
				move.xBy = xDiff;
				move.yBy = yDiff;
				return move;
			}
			return null;
		}
		
	}
}