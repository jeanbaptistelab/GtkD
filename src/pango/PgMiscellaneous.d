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


module pango.PgMiscellaneous;

private import core.stdc.stdio;
private import glib.Str;
private import glib.StringG;
private import gtkc.pango;
public  import gtkc.pangotypes;


public struct PgMiscellaneous
{
	/**
	 */

	/**
	 * Looks up a key in the Pango config database
	 * (pseudo-win.ini style, read from $sysconfdir/pango/pangorc,
	 * $XDG_CONFIG_HOME/pango/pangorc, and getenv (PANGO_RC_FILE).)
	 *
	 * Params:
	 *     key = Key to look up, in the form "SECTION/KEY".
	 *
	 * Return: the value, if found, otherwise %NULL. The value is a
	 *     newly-allocated string and must be freed with g_free().
	 */
	public static string configKeyGet(string key)
	{
		return Str.toString(pango_config_key_get(Str.toStringz(key)));
	}

	/**
	 * Looks up a key, consulting only the Pango system config database
	 * in $sysconfdir/pango/pangorc.
	 *
	 * Params:
	 *     key = Key to look up, in the form "SECTION/KEY".
	 *
	 * Return: the value, if found, otherwise %NULL. The value is a
	 *     newly-allocated string and must be freed with g_free().
	 */
	public static string configKeyGetSystem(string key)
	{
		return Str.toString(pango_config_key_get_system(Str.toStringz(key)));
	}

	/**
	 * On Unix, returns the name of the "pango" subdirectory of LIBDIR
	 * (which is set at compile time). On Windows, returns the lib\pango
	 * subdirectory of the Pango installation directory (which is deduced
	 * at run time from the DLL's location).
	 *
	 * Return: the Pango lib directory. The returned string should
	 *     not be freed.
	 */
	public static string getLibSubdirectory()
	{
		return Str.toString(pango_get_lib_subdirectory());
	}

	/**
	 * On Unix, returns the name of the "pango" subdirectory of SYSCONFDIR
	 * (which is set at compile time). On Windows, returns the etc\pango
	 * subdirectory of the Pango installation directory (which is deduced
	 * at run time from the DLL's location).
	 *
	 * Return: the Pango sysconf directory. The returned string should
	 *     not be freed.
	 */
	public static string getSysconfSubdirectory()
	{
		return Str.toString(pango_get_sysconf_subdirectory());
	}

	/**
	 * Checks @ch to see if it is a character that should not be
	 * normally rendered on the screen.  This includes all Unicode characters
	 * with "ZERO WIDTH" in their name, as well as <firstterm>bidi</firstterm> formatting characters, and
	 * a few other ones.  This is totally different from g_unichar_iszerowidth()
	 * and is at best misnamed.
	 *
	 * Params:
	 *     ch = a Unicode character
	 *
	 * Return: %TRUE if @ch is a zero-width character, %FALSE otherwise
	 *
	 * Since: 1.10
	 */
	public static bool isZeroWidth(dchar ch)
	{
		return pango_is_zero_width(ch) != 0;
	}

	/**
	 * This will return the bidirectional embedding levels of the input paragraph
	 * as defined by the Unicode Bidirectional Algorithm available at:
	 *
	 * http://www.unicode.org/reports/tr9/
	 *
	 * If the input base direction is a weak direction, the direction of the
	 * characters in the text will determine the final resolved direction.
	 *
	 * Params:
	 *     text = the text to itemize.
	 *     length = the number of bytes (not characters) to process, or -1
	 *         if @text is nul-terminated and the length should be calculated.
	 *     pbaseDir = input base direction, and output resolved direction.
	 *
	 * Return: a newly allocated array of embedding levels, one item per
	 *     character (not byte), that should be freed using g_free.
	 *
	 * Since: 1.4
	 */
	public static ubyte* log2visGetEmbeddingLevels(string text, int length, PangoDirection* pbaseDir)
	{
		return pango_log2vis_get_embedding_levels(Str.toStringz(text), length, pbaseDir);
	}

	/**
	 * Look up all user defined aliases for the alias @fontname.
	 * The resulting font family names will be stored in @families,
	 * and the number of families in @n_families.
	 *
	 * Deprecated: This function is not thread-safe.
	 *
	 * Params:
	 *     fontname = an ascii string
	 *     families = will be set to an array of font family names.
	 *         this array is owned by pango and should not be freed.
	 *     nFamilies = will be set to the length of the @families array.
	 */
	public static void lookupAliases(string fontname, out string[] families)
	{
		char** outfamilies = null;
		int nFamilies;
		
		pango_lookup_aliases(Str.toStringz(fontname), &outfamilies, &nFamilies);
		
		families = Str.toStringArray(outfamilies, nFamilies);
	}

	/**
	 * Parses an enum type and stores the result in @value.
	 *
	 * If @str does not match the nick name of any of the possible values for the
	 * enum and is not an integer, %FALSE is returned, a warning is issued
	 * if @warn is %TRUE, and a
	 * string representing the list of possible values is stored in
	 * @possible_values.  The list is slash-separated, eg.
	 * "none/start/middle/end".  If failed and @possible_values is not %NULL,
	 * returned string should be freed using g_free().
	 *
	 * Params:
	 *     type = enum type to parse, eg. %PANGO_TYPE_ELLIPSIZE_MODE.
	 *     str = string to parse.  May be %NULL.
	 *     value = integer to store the result in, or %NULL.
	 *     warn = if %TRUE, issue a g_warning() on bad input.
	 *     possibleValues = place to store list of possible values on failure, or %NULL.
	 *
	 * Return: %TRUE if @str was successfully parsed.
	 *
	 * Since: 1.16
	 */
	public static bool parseEnum(GType type, string str, out int value, bool warn, out string possibleValues)
	{
		char* outpossibleValues = null;
		
		auto p = pango_parse_enum(type, Str.toStringz(str), &value, warn, &outpossibleValues) != 0;
		
		possibleValues = Str.toString(outpossibleValues);
		
		return p;
	}

	/**
	 * Parses a font stretch. The allowed values are
	 * "ultra_condensed", "extra_condensed", "condensed",
	 * "semi_condensed", "normal", "semi_expanded", "expanded",
	 * "extra_expanded" and "ultra_expanded". Case variations are
	 * ignored and the '_' characters may be omitted.
	 *
	 * Params:
	 *     str = a string to parse.
	 *     stretch = a #PangoStretch to store the
	 *         result in.
	 *     warn = if %TRUE, issue a g_warning() on bad input.
	 *
	 * Return: %TRUE if @str was successfully parsed.
	 */
	public static bool parseStretch(string str, out PangoStretch stretch, bool warn)
	{
		return pango_parse_stretch(Str.toStringz(str), &stretch, warn) != 0;
	}

	/**
	 * Parses a font style. The allowed values are "normal",
	 * "italic" and "oblique", case variations being
	 * ignored.
	 *
	 * Params:
	 *     str = a string to parse.
	 *     style = a #PangoStyle to store the result
	 *         in.
	 *     warn = if %TRUE, issue a g_warning() on bad input.
	 *
	 * Return: %TRUE if @str was successfully parsed.
	 */
	public static bool parseStyle(string str, out PangoStyle style, bool warn)
	{
		return pango_parse_style(Str.toStringz(str), &style, warn) != 0;
	}

	/**
	 * Parses a font variant. The allowed values are "normal"
	 * and "smallcaps" or "small_caps", case variations being
	 * ignored.
	 *
	 * Params:
	 *     str = a string to parse.
	 *     variant = a #PangoVariant to store the
	 *         result in.
	 *     warn = if %TRUE, issue a g_warning() on bad input.
	 *
	 * Return: %TRUE if @str was successfully parsed.
	 */
	public static bool parseVariant(string str, out PangoVariant variant, bool warn)
	{
		return pango_parse_variant(Str.toStringz(str), &variant, warn) != 0;
	}

	/**
	 * Parses a font weight. The allowed values are "heavy",
	 * "ultrabold", "bold", "normal", "light", "ultraleight"
	 * and integers. Case variations are ignored.
	 *
	 * Params:
	 *     str = a string to parse.
	 *     weight = a #PangoWeight to store the result
	 *         in.
	 *     warn = if %TRUE, issue a g_warning() on bad input.
	 *
	 * Return: %TRUE if @str was successfully parsed.
	 */
	public static bool parseWeight(string str, out PangoWeight weight, bool warn)
	{
		return pango_parse_weight(Str.toStringz(str), &weight, warn) != 0;
	}

	/**
	 * Quantizes the thickness and position of a line, typically an
	 * underline or strikethrough, to whole device pixels, that is integer
	 * multiples of %PANGO_SCALE. The purpose of this function is to avoid
	 * such lines looking blurry.
	 *
	 * Care is taken to make sure @thickness is at least one pixel when this
	 * function returns, but returned @position may become zero as a result
	 * of rounding.
	 *
	 * Params:
	 *     thickness = pointer to the thickness of a line, in Pango units
	 *     position = corresponding position
	 *
	 * Since: 1.12
	 */
	public static void quantizeLineGeometry(ref int thickness, ref int position)
	{
		pango_quantize_line_geometry(&thickness, &position);
	}

	/**
	 * Reads an entire line from a file into a buffer. Lines may
	 * be delimited with '\n', '\r', '\n\r', or '\r\n'. The delimiter
	 * is not written into the buffer. Text after a '#' character is treated as
	 * a comment and skipped. '\' can be used to escape a # character.
	 * '\' proceeding a line delimiter combines adjacent lines. A '\' proceeding
	 * any other character is ignored and written into the output buffer
	 * unmodified.
	 *
	 * Params:
	 *     stream = a stdio stream
	 *     str = #GString buffer into which to write the result
	 *
	 * Return: 0 if the stream was already at an %EOF character, otherwise
	 *     the number of lines read (this is useful for maintaining
	 *     a line number counter which doesn't combine lines with '\')
	 */
	public static int readLine(FILE* stream, out StringG str)
	{
		GString* outstr = new GString;
		
		auto p = pango_read_line(stream, outstr);
		
		str = new StringG(outstr);
		
		return p;
	}

	/**
	 * Scans an integer.
	 * Leading white space is skipped.
	 *
	 * Params:
	 *     pos = in/out string position
	 *     output = an int into which to write the result
	 *
	 * Return: %FALSE if a parse error occurred.
	 */
	public static bool scanInt(ref string pos, out int output)
	{
		char* outpos = Str.toStringz(pos);
		
		auto p = pango_scan_int(&outpos, &output) != 0;
		
		pos = Str.toString(outpos);
		
		return p;
	}

	/**
	 * Scans a string into a #GString buffer. The string may either
	 * be a sequence of non-white-space characters, or a quoted
	 * string with '"'. Instead a quoted string, '\"' represents
	 * a literal quote. Leading white space outside of quotes is skipped.
	 *
	 * Params:
	 *     pos = in/out string position
	 *     output = a #GString into which to write the result
	 *
	 * Return: %FALSE if a parse error occurred.
	 */
	public static bool scanString(ref string pos, out StringG output)
	{
		char* outpos = Str.toStringz(pos);
		GString* outoutput = new GString;
		
		auto p = pango_scan_string(&outpos, outoutput) != 0;
		
		pos = Str.toString(outpos);
		output = new StringG(outoutput);
		
		return p;
	}

	/**
	 * Scans a word into a #GString buffer. A word consists
	 * of [A-Za-z_] followed by zero or more [A-Za-z_0-9]
	 * Leading white space is skipped.
	 *
	 * Params:
	 *     pos = in/out string position
	 *     output = a #GString into which to write the result
	 *
	 * Return: %FALSE if a parse error occurred.
	 */
	public static bool scanWord(ref string pos, out StringG output)
	{
		char* outpos = Str.toStringz(pos);
		GString* outoutput = new GString;
		
		auto p = pango_scan_word(&outpos, outoutput) != 0;
		
		pos = Str.toString(outpos);
		output = new StringG(outoutput);
		
		return p;
	}

	/**
	 * Skips 0 or more characters of white space.
	 *
	 * Params:
	 *     pos = in/out string position
	 *
	 * Return: %FALSE if skipping the white space leaves
	 *     the position at a '\0' character.
	 */
	public static bool skipSpace(ref string pos)
	{
		char* outpos = Str.toStringz(pos);
		
		auto p = pango_skip_space(&outpos) != 0;
		
		pos = Str.toString(outpos);
		
		return p;
	}

	/**
	 * Splits a %G_SEARCHPATH_SEPARATOR-separated list of files, stripping
	 * white space and substituting ~/ with $HOME/.
	 *
	 * Params:
	 *     str = a %G_SEARCHPATH_SEPARATOR separated list of filenames
	 *
	 * Return: a list of
	 *     strings to be freed with g_strfreev()
	 */
	public static string[] splitFileList(string str)
	{
		return Str.toStringArray(pango_split_file_list(Str.toStringz(str)));
	}

	/**
	 * Trims leading and trailing whitespace from a string.
	 *
	 * Params:
	 *     str = a string
	 *
	 * Return: A newly-allocated string that must be freed with g_free()
	 */
	public static string trimString(string str)
	{
		return Str.toString(pango_trim_string(Str.toStringz(str)));
	}
}
