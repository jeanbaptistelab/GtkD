/*
 * This file is part of gtkD.
 *
 * gtkD is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation; either version 3
 * of the License, or (at your option) any later version, with
 * some exceptions, please read the COPYING file.
 *
 * gtkD is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with gtkD; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110, USA
 */

// generated automatically - do not change
// find conversion definition on APILookup.txt
// implement new conversion functionalities on the wrap.utils pakage


module gstreamer.ParseContext;

private import glib.ConstructionException;
private import glib.Str;
private import gobject.ObjectG;
private import gstreamerc.gstreamer;
public  import gstreamerc.gstreamertypes;


/**
 * Opaque structure.
 */
public class ParseContext
{
	/** the main Gtk struct */
	protected GstParseContext* gstParseContext;

	/** Get the main Gtk struct */
	public GstParseContext* getParseContextStruct()
	{
		return gstParseContext;
	}

	/** the main Gtk struct as a void* */
	protected void* getStruct()
	{
		return cast(void*)gstParseContext;
	}

	/**
	 * Sets our main struct and passes it to the parent class.
	 */
	public this (GstParseContext* gstParseContext)
	{
		this.gstParseContext = gstParseContext;
	}

	/**
	 */

	public static GType getType()
	{
		return gst_parse_context_get_type();
	}

	/**
	 * Allocates a parse context for use with gst_parse_launch_full() or
	 * gst_parse_launchv_full().
	 *
	 * Free-function: gst_parse_context_free
	 *
	 * Return: a newly-allocated parse context. Free with
	 *     gst_parse_context_free() when no longer needed.
	 *
	 * Throws: ConstructionException GTK+ fails to create the object.
	 */
	public this()
	{
		auto p = gst_parse_context_new();
		
		if(p is null)
		{
			throw new ConstructionException("null returned by new");
		}
		
		this(cast(GstParseContext*) p);
	}

	/**
	 * Frees a parse context previously allocated with gst_parse_context_new().
	 */
	public void free()
	{
		gst_parse_context_free(gstParseContext);
	}

	/**
	 * Retrieve missing elements from a previous run of gst_parse_launch_full()
	 * or gst_parse_launchv_full(). Will only return results if an error code
	 * of %GST_PARSE_ERROR_NO_SUCH_ELEMENT was returned.
	 *
	 * Return: a
	 *     %NULL-terminated array of element factory name strings of missing
	 *     elements. Free with g_strfreev() when no longer needed.
	 */
	public string[] getMissingElements()
	{
		return Str.toStringArray(gst_parse_context_get_missing_elements(gstParseContext));
	}
}
