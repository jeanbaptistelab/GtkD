/*
 * This file is part of gtkD.
 *
 * gtkD is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * gtkD is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with gtkD; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 
// generated automatically - do not change
// find conversion definition on APILookup.txt
// implement new conversion functionalities on the wrap.utils pakage

/*
 * Conversion parameters:
 * inFile  = GtkRecentManager.html
 * outPack = gtk
 * outFile = RecentManager
 * strct   = GtkRecentManager
 * realStrct=
 * ctorStrct=
 * clss    = RecentManager
 * interf  = 
 * class Code: No
 * interface Code: No
 * template for:
 * extend  = 
 * implements:
 * prefixes:
 * 	- gtk_recent_manager_
 * omit structs:
 * omit prefixes:
 * 	- gtk_recent_info_
 * omit code:
 * omit signals:
 * imports:
 * 	- glib.Str
 * 	- gdk.Screen
 * 	- gtk.RecentInfo
 * structWrap:
 * 	- GdkScreen* -> Screen
 * 	- GtkRecentInfo* -> RecentInfo
 * module aliases:
 * local aliases:
 */

module gtk.RecentManager;

public  import gtkc.gtktypes;

private import gtkc.gtk;

private import gobject.Signals;
public  import gtkc.gdktypes;

private import glib.Str;
private import gdk.Screen;
private import gtk.RecentInfo;



private import gobject.ObjectG;

/**
 * Description
 * GtkRecentManager provides a facility for adding, removing and
 * looking up recently used files. Each recently used file is
 * identified by its URI, and has meta-data associated to it, like
 * the names and command lines of the applications that have
 * registered it, the number of time each application has registered
 * the same file, the mime type of the file and whether the file
 * should be displayed only by the applications that have
 * registered it.
 * The GtkRecentManager acts like a database of all the recently
 * used files. You can create new GtkRecentManager objects, but
 * it is more efficient to use the standard recent manager for
 * the GdkScreen so that informations about the recently used
 * files is shared with other people using them. In case the
 * default screen is being used, adding a new recently used
 * file is as simple as:
 * GtkRecentManager *manager;
 * manager = gtk_recent_manager_get_default ();
 * gtk_recent_manager_add_item (manager, file_uri);
 * While looking up a recently used file is as simple as:
 * GtkRecentManager *manager;
 * GtkRecentInfo *info;
 * GError *error = NULL;
 * manager = gtk_recent_manager_get_default ();
 * info = gtk_recent_manager_lookup_item (manager, file_uri, error);
 * if (error)
 *  {
	 *  g_warning ("Could not find the file: %s", error->message);
	 *  g_error_free (error);
 *  }
 * else
 *  {
	 *  /+* Use the info object +/
	 *  gtk_recent_info_unref (info);
 *  }
 * Recently used files are supported since GTK+ 2.10.
 */
public class RecentManager : ObjectG
{
	
	/** the main Gtk struct */
	protected GtkRecentManager* gtkRecentManager;
	
	
	public GtkRecentManager* getRecentManagerStruct()
	{
		return gtkRecentManager;
	}
	
	
	/** the main Gtk struct as a void* */
	protected void* getStruct()
	{
		return cast(void*)gtkRecentManager;
	}
	
	/**
	 * Sets our main struct and passes it to the parent class
	 */
	public this (GtkRecentManager* gtkRecentManager)
	{
		if(gtkRecentManager is null)
		{
			this = null;
			version(Exceptions) throw new Exception("Null gtkRecentManager passed to constructor.");
			else return;
		}
		super(cast(GObject*)gtkRecentManager);
		this.gtkRecentManager = gtkRecentManager;
	}
	
	/**
	 */
	int[char[]] connectedSignals;
	
	void delegate(RecentManager)[] onChangedListeners;
	/**
	 * Emitted when the current recently used resources manager changes its
	 * contents.
	 * Since 2.10
	 */
	void addOnChanged(void delegate(RecentManager) dlg, ConnectFlags connectFlags=cast(ConnectFlags)0)
	{
		if ( !("changed" in connectedSignals) )
		{
			Signals.connectData(
			getStruct(),
			"changed",
			cast(GCallback)&callBackChanged,
			cast(void*)this,
			null,
			connectFlags);
			connectedSignals["changed"] = 1;
		}
		onChangedListeners ~= dlg;
	}
	extern(C) static void callBackChanged(GtkRecentManager* recentManagerStruct, RecentManager recentManager)
	{
		bool consumed = false;
		
		foreach ( void delegate(RecentManager) dlg ; recentManager.onChangedListeners )
		{
			dlg(recentManager);
		}
		
		return consumed;
	}
	
	
	/**
	 * Creates a new recent manager object. Recent manager objects are used to
	 * handle the list of recently used resources. A GtkRecentManager object
	 * monitors the recently used resources list, and emits the "changed" signal
	 * each time something inside the list changes.
	 * GtkRecentManager objects are expensive: be sure to create them only when
	 * needed. You should use gtk_recent_manager_get_default() instead.
	 * Since 2.10
	 */
	public this ()
	{
		// GtkRecentManager* gtk_recent_manager_new (void);
		auto p = gtk_recent_manager_new();
		if(p is null)
		{
			this = null;
			version(Exceptions) throw new Exception("Construction failure.");
			else return;
		}
		this(cast(GtkRecentManager*) p);
	}
	
	/**
	 * Gets a unique instance of GtkRecentManager, that you can share
	 * in your application without caring about memory management. The
	 * returned instance will be freed when you application terminates.
	 * Since 2.10
	 * Returns: A unique GtkRecentManager. Do not ref or unref it.
	 */
	public static GtkRecentManager* getDefault()
	{
		// GtkRecentManager* gtk_recent_manager_get_default (void);
		return gtk_recent_manager_get_default();
	}
	
	/**
	 * Warning
	 * gtk_recent_manager_get_for_screen has been deprecated since version 2.12 and should not be used in newly-written code. This function has been deprecated and should
	 *  not be used in newly written code. Calling this function is
	 *  equivalent to calling gtk_recent_manager_get_default().
	 * Gets the recent manager object associated with screen; if this
	 * function has not previously been called for the given screen,
	 * a new recent manager object will be created and associated with
	 * the screen. Recent manager objects are fairly expensive to create,
	 * so using this function is usually a better choice than calling
	 * gtk_recent_manager_new() and setting the screen yourself; by using
	 * this function a single recent manager object will be shared between
	 * users.
	 * Since 2.10
	 * Params:
	 * screen =  a GdkScreen
	 * Returns: A unique GtkRecentManager associated with the given screen. This recent manager is associated to the with the screen and can be used as long as the screen is open. Do not ref or unref it.
	 */
	public static GtkRecentManager* getForScreen(Screen screen)
	{
		// GtkRecentManager* gtk_recent_manager_get_for_screen (GdkScreen *screen);
		return gtk_recent_manager_get_for_screen((screen is null) ? null : screen.getScreenStruct());
	}
	
	/**
	 * Warning
	 * gtk_recent_manager_set_screen has been deprecated since version 2.12 and should not be used in newly-written code. This function has been deprecated and should
	 *  not be used in newly written code. Calling this function has
	 *  no effect.
	 * Sets the screen for a recent manager; the screen is used to
	 * track the user's currently configured recently used documents
	 * storage.
	 * Since 2.10
	 * Params:
	 * screen =  a GdkScreen
	 */
	public void setScreen(Screen screen)
	{
		// void gtk_recent_manager_set_screen (GtkRecentManager *manager,  GdkScreen *screen);
		gtk_recent_manager_set_screen(gtkRecentManager, (screen is null) ? null : screen.getScreenStruct());
	}
	
	/**
	 * Adds a new resource, pointed by uri, into the recently used
	 * resources list.
	 * This function automatically retrieves some of the needed
	 * metadata and setting other metadata to common default values; it
	 * then feeds the data to gtk_recent_manager_add_full().
	 * See gtk_recent_manager_add_full() if you want to explicitly
	 * define the metadata for the resource pointed by uri.
	 * Since 2.10
	 * Params:
	 * uri =  a valid URI
	 * Returns: TRUE if the new item was successfully added to the recently used resources list
	 */
	public int addItem(char[] uri)
	{
		// gboolean gtk_recent_manager_add_item (GtkRecentManager *manager,  const gchar *uri);
		return gtk_recent_manager_add_item(gtkRecentManager, Str.toStringz(uri));
	}
	
	/**
	 * Adds a new resource, pointed by uri, into the recently used
	 * resources list, using the metadata specified inside the GtkRecentData
	 * structure passed in recent_data.
	 * The passed URI will be used to identify this resource inside the
	 * list.
	 * In order to register the new recently used resource, metadata about
	 * the resource must be passed as well as the URI; the metadata is
	 * stored in a GtkRecentData structure, which must contain the MIME
	 * type of the resource pointed by the URI; the name of the application
	 * that is registering the item, and a command line to be used when
	 * launching the item.
	 * Optionally, a GtkRecentData structure might contain a UTF-8 string
	 * to be used when viewing the item instead of the last component of the
	 * URI; a short description of the item; whether the item should be
	 * considered private - that is, should be displayed only by the
	 * applications that have registered it.
	 * Since 2.10
	 * Params:
	 * uri =  a valid URI
	 * recentData =  metadata of the resource
	 * Returns: TRUE if the new item was successfully added to therecently used resources list, FALSE otherwise.
	 */
	public int addFull(char[] uri, GtkRecentData* recentData)
	{
		// gboolean gtk_recent_manager_add_full (GtkRecentManager *manager,  const gchar *uri,  const GtkRecentData *recent_data);
		return gtk_recent_manager_add_full(gtkRecentManager, Str.toStringz(uri), recentData);
	}
	
	/**
	 * Removes a resource pointed by uri from the recently used resources
	 * list handled by a recent manager.
	 * Since 2.10
	 * Params:
	 * uri =  the URI of the item you wish to remove
	 * error =  return location for a GError, or NULL
	 * Returns: TRUE if the item pointed by uri has been successfully removed by the recently used resources list, and FALSE otherwise.
	 */
	public int removeItem(char[] uri, GError** error)
	{
		// gboolean gtk_recent_manager_remove_item (GtkRecentManager *manager,  const gchar *uri,  GError **error);
		return gtk_recent_manager_remove_item(gtkRecentManager, Str.toStringz(uri), error);
	}
	
	/**
	 * Searches for a URI inside the recently used resources list, and
	 * returns a structure containing informations about the resource
	 * like its MIME type, or its display name.
	 * Since 2.10
	 * Params:
	 * uri =  a URI
	 * error =  a return location for a GError, or NULL
	 * Returns: a GtkRecentInfo structure containing information about the resource pointed by uri, or NULL if the URI was not registered in the recently used resources list. Free with gtk_recent_info_unref().
	 */
	public RecentInfo lookupItem(char[] uri, GError** error)
	{
		// GtkRecentInfo* gtk_recent_manager_lookup_item (GtkRecentManager *manager,  const gchar *uri,  GError **error);
		auto p = gtk_recent_manager_lookup_item(gtkRecentManager, Str.toStringz(uri), error);
		if(p is null)
		{
			version(Exceptions) throw new Exception("Null GObject from GTK+.");
			else return null;
		}
		return new RecentInfo(cast(GtkRecentInfo*) p);
	}
	
	/**
	 * Checks whether there is a recently used resource registered
	 * with uri inside the recent manager.
	 * Since 2.10
	 * Params:
	 * uri =  a URI
	 * Returns: TRUE if the resource was found, FALSE otherwise.
	 */
	public int hasItem(char[] uri)
	{
		// gboolean gtk_recent_manager_has_item (GtkRecentManager *manager,  const gchar *uri);
		return gtk_recent_manager_has_item(gtkRecentManager, Str.toStringz(uri));
	}
	
	/**
	 * Changes the location of a recently used resource from uri to new_uri.
	 * Please note that this function will not affect the resource pointed
	 * by the URIs, but only the URI used in the recently used resources list.
	 * Since 2.10
	 * Params:
	 * uri =  the URI of a recently used resource
	 * newUri =  the new URI of the recently used resource, or NULL to
	 *  remove the item pointed by uri in the list
	 * error =  a return location for a GError, or NULL
	 * Returns: TRUE on success.
	 */
	public int moveItem(char[] uri, char[] newUri, GError** error)
	{
		// gboolean gtk_recent_manager_move_item (GtkRecentManager *manager,  const gchar *uri,  const gchar *new_uri,  GError **error);
		return gtk_recent_manager_move_item(gtkRecentManager, Str.toStringz(uri), Str.toStringz(newUri), error);
	}
	
	/**
	 * Gets the maximum number of items that the gtk_recent_manager_get_items()
	 * function should return.
	 * Since 2.10
	 * Returns: the number of items to return, or -1 for every item.
	 */
	public int getLimit()
	{
		// gint gtk_recent_manager_get_limit (GtkRecentManager *manager);
		return gtk_recent_manager_get_limit(gtkRecentManager);
	}
	
	/**
	 * Sets the maximum number of item that the gtk_recent_manager_get_items()
	 * function should return. If limit is set to -1, then return all the
	 * items.
	 * Since 2.10
	 * Params:
	 * limit =  the maximum number of items to return, or -1.
	 */
	public void setLimit(int limit)
	{
		// void gtk_recent_manager_set_limit (GtkRecentManager *manager,  gint limit);
		gtk_recent_manager_set_limit(gtkRecentManager, limit);
	}
	
	/**
	 * Gets the list of recently used resources.
	 * Since 2.10
	 * Returns: a list of newly allocated GtkRecentInfo objects. Use gtk_recent_info_unref() on each item inside the list, and then free the list itself using g_list_free().
	 */
	public GList* getItems()
	{
		// GList* gtk_recent_manager_get_items (GtkRecentManager *manager);
		return gtk_recent_manager_get_items(gtkRecentManager);
	}
	
	/**
	 * Purges every item from the recently used resources list.
	 * Since 2.10
	 * Params:
	 * error =  a return location for a GError, or NULL
	 * Returns: the number of items that have been removed from the recently used resources list.
	 */
	public int purgeItems(GError** error)
	{
		// gint gtk_recent_manager_purge_items (GtkRecentManager *manager,  GError **error);
		return gtk_recent_manager_purge_items(gtkRecentManager, error);
	}
}