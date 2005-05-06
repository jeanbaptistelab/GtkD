/*
 * This file is part of dui.
 * 
 * dui is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or
 * (at your option) any later version.
 * 
 * dui is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with dui; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * - automatically generated by leds
 * - pos-processed by Antonio Monteiro
 */

module dglib.SpawnException;
	
private import dool.String;

public
class SpawnException : Exception
{

	int code;
	String message;
	
	this(int code, char[] message)
	{
		this(code, new String (message));
	}
	
	this(int code, String message)
	{
		this.code = code;
		this.message = message.dup;
		super(message.toString());
	}
}