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

module dglib.File;

private import def.Types;
private import def.Constants;

private import lib.glib;

private import dool.String;
private import dool.io.Path;
private import dool.io.FileException;

private:

private import dglib.ErrorG;

/**
 * A directory error
 * No error codes for now, just inadequate descriptive message
 */
class DirectoryError : Error
{
	this(char[] message)
	{
		super(message);
	}
}

/**
 * File Utilities
 */
public
class File
{
	public:

	GDir* gDir;
	
	/** the path of the current directory */
	String path; 
	
	/**
	 * Creates a File from a GtkFile
	 * @param *gtkWidget the gtk struct address pointer
	 * @return 
	 */
    this(GDir* gDir)
    {
        this.gDir = gDir;
    }


	/**
	 * Gets a GFileError constant based on the passed-in errno. For example, if you pass in EEXIST this function
	 * returns GFILEERROREXIST. Unlike errno values, you can portably assume that all GFileError values will exist.<br>
	 * Normally a GFileError value goes into a GError returned from a function that manipulates files. So you
	 * would use gFileErrorFromErrno() when constructing a GError.
	 * @param errNo an "errno" value
	 * @return GFileError corresponding to the given errno
	 */
	static FileError errorFromErrno(gint err_no)
	{
		return cast(FileError)g_file_error_from_errno(err_no);
	}


	/**
	 * Reads an entire file into allocated memory, with good error checking. If error is set, FALSE is returned, and
	 * contents is set to NULL. If TRUE is returned, error will not be set, and contents will be set to the file
	 * contents. The string stored in contents will be nul-terminated, so for text files you can pass NULL for the
	 * length argument. The error domain is GFILEERROR. Possible error codes are those in the GFileError
	 * enumeration.
	 * @param filename a file to read contents from
	 * @param contents location to store an allocated string
	 * @param length location to store length in bytes of the contents
	 * @param error return location for a GError
	 * @return TRUE on success, FALSE if error is set
	 */
	static bit getContents(String  filename, String contents, out gsize length, ErrorG error)
	{
		char** gContents;
		bit ok = g_file_get_contents(
			filename.toStringz(),
			gContents,
			&length,
			(error===null?null:error.getGA())) == 0 ? false : true;
		contents.set(*gContents, length);
		return ok;
	}


	/**
	 * Returns TRUE if any of the tests in the bitfield test are TRUE. For example, (GFILETESTEXISTS |
	 * GFILETESTISDIR) will return TRUE if the file exists; the check whether it's a directory doesn't matter
	 * since the existence test is TRUE. With the current set of available tests, there's no point passing in more
	 * than one test at a time.<br>
	 * Apart from GFILETESTISSYMLINK all tests follow symbolic links, so for a symbolic link to a regular file
	 * gFileTest() will return TRUE for both GFILETESTISSYMLINK and GFILETESTISREGULAR.<br>
	 * Note, that for a dangling symbolic link gFileTest() will return TRUE for GFILETESTISSYMLINK and FALSE for
	 * all other flags.<br>
	 * You should never use gFileTest() to test whether it is safe to perform an operaton, because there is always
	 * the possibility of the condition changing before you actually perform the operation. For example, you might
	 * think you could use GFILETESTISSYMLINK to know whether it is is safe to write to a file without being
	 * tricked into writing into a different location. It doesn't work!<br>
	 * //DON'T DO THIS <br>
	 * if (!gFileTest (filename, GFILETESTISSYMLINK)) {<br>
	 * fd = open (filename, OWRONLY);<br>
	 * // write to fd <br>
	 * }<br>
	 * Another thing to note is that GFILETESTEXISTS and GFILETESTISEXECUTABLE are implemented using the access()
	 * system call. This usually doesn't matter, but if your program is setuid or setgid it means that these tests
	 * will give you the answer for the real user ID and group ID , rather than the effective user ID and group
	 * ID.
	 * @param filename a filename to test
	 * @param test bitfield of GFileTest flags
	 * @return whether a test was TRUE
	 */
	static bit test(String filename, FileTest fileTestFlags)
	{
		return g_file_test(filename.toStringz(), fileTestFlags) == 0 ? false : true;
	}


	/**
	 * Opens a temporary file. See the mkstemp() documentation on most UNIX-like systems. This is a portability
	 * wrapper, which simply calls mkstemp() on systems that have it, and implements it in GLib otherwise.<br>
	 * The parameter is a string that should match the rules for mkstemp(), i.e. end in "XXXXXX". The X string
	 * will be modified to form the name of a file that didn't exist.
	 * @param tmpl template filename
	 * @return A file handle (as from open()) to the file opened for reading and writing. The file is opened in
	 * binary mode on platforms where there is a difference. The file handle should be closed with close(). In
	 * case of errors, -1 is returned.
	 * \todo return a file - see what's needed for that.
	 */
	static gint emp(String tmpl)
	{
		return g_mkstemp(tmpl.toStringz());
	}


	/**
	 * Opens a file for writing in the preferred directory for temporary files (as returned by gGetTmpDir()).<br>
	 * tmpl should be a string ending with six 'X' characters, as the parameter to gMkstemp() (or mkstemp()).
	 * However, unlike these functions, the template should only be a basename, no directory components are
	 * allowed. If template is NULL, a default template is used.<br>
	 * Note that in contrast to gMkstemp() (and mkstemp()) tmpl is not modified, and might thus be a read-only
	 * literal string.<br>
	 * The actual name used is returned in nameUsed if non-NULL. This string should be freed with gFree() when not
	 * needed any longer.
	 * @param tmpl Template for file name, as in gMkstemp(), basename only
	 * @param nameUsed location to store actual name used
	 * @param error return location for a GError
	 * @return A file handle (as from open()) to the file opened for reading and writing. The file is opened in
	 * binary mode on platforms where there is a difference. The file handle should be closed with close(). In
	 * case of errors, -1 is returned and error will be set.
	 * \todo return a file - see what's needed for that.
	 */
	static gint openTmp(String tmpl, String nameUsed, ErrorG error)
	{
		char** nu;
		gint fd = g_file_open_tmp(
			tmpl.toStringz(), 
			nu,
			(error===null?null:error.getGA()));
		nameUsed.setz(*nu);
		return fd;
	}


	/**
	 * Reads the contents of the symbolic link filename like the POSIX readlink() function. The returned string is in
	 * the encoding used for filenames. Use gFilenameToUtf8() to convert it to UTF-8.
	 * @param filename the symbolic link
	 * @param error return location for a GError
	 * @return A newly allocated string with the contents of the symbolic link, or NULL if an error occurred.
	 */
	static String readLink(String  filename, ErrorG error)
	{
		return String.newz(g_file_read_link(filename.toStringz(), (error===null?null:error.getGA())));
	}


	/**
	 * Opens a directory for reading. The names of the files in the directory can then be retrieved using
	 * gDirReadName().
	 * @param path the path to the directory you are interested in
	 * @param flags Currently must be set to 0. Reserved for future use.
	 * @param error return location for a GError, or NULL. If non-NULL, an error will be set if and only if
	 * gDirOpenFails.
	 * @return a newly allocated GDir on success, NULL on failure. If non-NULL, you must free the result with
	 * gDirClose() when you are finished with it.
	 */
	this(String path, guint flags, ErrorG error)
	{
		path = new String(path);
		this(g_dir_open(path.toStringz(), flags, (error===null?null:error.getGA())));
	}

	this(String path)
	{
		this(path, 0 , null);
	}

	this(String path, bit create)
	{
		this(path, 0 , null);
		if ( gDir === null && create)
		{
			mkdirs(path);
			gDir = g_dir_open(path.toStringz(), 0, null);
		}
	}
	
	~this()
	{
		close();
	}
	
	String getPath()
	{
		if ( gDir !== null )
		{
			return path;
		}
		return null;
	}
	
	/**
	 * Retrieves the name of the next entry in the directory. The '.' and '..' entries are omitted. The returned name
	 * is in the encoding used for filenames. Use gFilenameToUtf8() to convert it to UTF-8.
	 * @param dir a GDir* created by gDirOpen()
	 * @return The entries name or NULL if there are no more entries. The return value is owned by GLib and must
	 * not be modified or freed.
	 */
	String  readName()
	{
		if ( gDir === null )
		{
			return new String();
		}
		String name = String.newz(g_dir_read_name(gDir));
		return name;
	}


	/**
	 * Resets the given directory. The next call to gDirReadName() will return the first entry again.
	 * @param dir a GDir* created by gDirOpen()
	 */
	void rewind()
	{
		if ( gDir === null )
		{
			return;
		}
		g_dir_rewind(gDir);
	}


	/**
	 * Closes the directory and deallocates all related resources.
	 * @param dir a GDir* created by gDirOpen(
	 */
	void close()
	{
		if ( gDir === null )
		{
			return;
		}
		g_dir_close(gDir);
		gDir = null;
	}

	////////////////////////////////////////////////////////////////////////////
	/// DUI extensions /////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	
	/**
	 * Gets a sorted array with all directory entries with a specific type
	 * @param type the type of entries to include
	 * @return a sorted array with all directory entries of specific type
	 */
	String[] getNames(FileTest fileTestFlags)
	{
		//printf("File.getNames fileTestFlags = %d\n", fileTestFlags);
		String[] names;
		rewind();
		String name;
		name = readName();
		
		while ( name.length > 0 )
		{
			//printf("File.getNames name = %.*s\n", name);
			if ( fileTestFlags == 0 || test(Path.join(path,name), fileTestFlags ) )
			{
				//printf("\taccepted\n" );
				names ~= name.dup;
			}
			name = readName();
		}
		
		return names;
	}

	/**
	 * Gets a sorted array of the subdirectories
	 * @return a sorted array of the subdirectories
	 */
	String[] getDirNames()
	{
		return getNames(FileTest.IS_DIR);
	}

	/**
	 * Gets a sorted array of the files on this directory
	 * @return a sorted array of the files on this directory
	 */
	String[] getFileNames()
	{
		return getNames(FileTest.IS_REGULAR);
	}

	/**
	 * Deletes a file from the file system
	 */
	public static void removeFile(String pathname)
	{
		//printf("Directory.remove pathname = %.*s\n",pathname);
		try
		{
			Path.remove(pathname.toString());
		}
		catch ( FileException fe )
		{
			printf("cannot remove file %.*s\n",pathname.toStringz());
		}
	}
	
	public static bit mkdirs(String pathName)
	{
		bit dirExists = false;
		try
		{
			dirExists = Path.isDir(pathName) != 0;
			printf("Directory.mkdirs already exists pathName = %.*s\n", pathName.toString());
		}
		catch ( FileException fe )
		{
			// try to create
			String path = new String();
			if ( Path.isSep(pathName.charAt(0)) )
			{
				path ~= Path.sep;
			}
			foreach ( String dir ; pathName.split() )
			{
				path ~= Path.join(path,dir);
				try
				{
					Path.mkdir(path);
				}
				catch ( FileException fe )
				{
					// ignore test on the end only
				}
			}
			try
			{
				dirExists = Path.isDir(pathName) != 0; 
			}
			catch ( FileException fe )
			{
				dirExists = false;
			}
		}
		printf("Directory.mkdirs exists pathName = %.*s %d\n", pathName, dirExists);
		return dirExists;
	}
	
	bit existDir()
	{
		if ( gDir === null )
		{
			return false;
		}
		return test(path, FileTest.EXISTS);
	}
	
}


/+
enum GFileError

typedef enum
{
  G_FILE_ERROR_EXIST,
  G_FILE_ERROR_ISDIR,
  G_FILE_ERROR_ACCES,
  G_FILE_ERROR_NAMETOOLONG,
  G_FILE_ERROR_NOENT,
  G_FILE_ERROR_NOTDIR,
  G_FILE_ERROR_NXIO,
  G_FILE_ERROR_NODEV,
  G_FILE_ERROR_ROFS,
  G_FILE_ERROR_TXTBSY,
  G_FILE_ERROR_FAULT,
  G_FILE_ERROR_LOOP,
  G_FILE_ERROR_NOSPC,
  G_FILE_ERROR_NOMEM,
  G_FILE_ERROR_MFILE,
  G_FILE_ERROR_NFILE,
  G_FILE_ERROR_BADF,
  G_FILE_ERROR_INVAL,
  G_FILE_ERROR_PIPE,
  G_FILE_ERROR_AGAIN,
  G_FILE_ERROR_INTR,
  G_FILE_ERROR_IO,
  G_FILE_ERROR_PERM,
  G_FILE_ERROR_FAILED
} GFileError;

Values corresponding to errno codes returned from file operations on UNIX. Unlike errno codes, GFileError values are available on all systems, even Windows. The exact meaning of each code depends on what sort of file operation you were performing; the UNIX documentation gives more details. The following error code descriptions come from the GNU C Library manual, and are under the copyright of that manual.

It's not very portable to make detailed assumptions about exactly which errors will be returned from a given operation. Some errors don't occur on some systems, etc., sometimes there are subtle differences in when a system will report a given error, etc.
G_FILE_ERROR_EXIST	Operation not permitted; only the owner of the file (or other resource) or processes with special privileges can perform the operation.
G_FILE_ERROR_ISDIR	File is a directory; you cannot open a directory for writing, or create or remove hard links to it.
G_FILE_ERROR_ACCES	Permission denied; the file permissions do not allow the attempted operation.
G_FILE_ERROR_NAMETOOLONG	Filename too long.
G_FILE_ERROR_NOENT	No such file or directory. This is a "file doesn't exist" error for ordinary files that are referenced in contexts where they are expected to already exist.
G_FILE_ERROR_NOTDIR	A file that isn't a directory was specified when a directory is required.
G_FILE_ERROR_NXIO	No such device or address. The system tried to use the device represented by a file you specified, and it couldn't find the device. This can mean that the device file was installed incorrectly, or that the physical device is missing or not correctly attached to the computer.
G_FILE_ERROR_NODEV	This file is of a type that doesn't support mapping.
G_FILE_ERROR_ROFS	The directory containing the new link can't be modified because it's on a read-only file system.
G_FILE_ERROR_TXTBSY	Text file busy.
G_FILE_ERROR_FAULT	You passed in a pointer to bad memory. (GLib won't reliably return this, don't pass in pointers to bad memory.)
G_FILE_ERROR_LOOP	Too many levels of symbolic links were encountered in looking up a file name. This often indicates a cycle of symbolic links.
G_FILE_ERROR_NOSPC	No space left on device; write operation on a file failed because the disk is full.
G_FILE_ERROR_NOMEM	No memory available. The system cannot allocate more virtual memory because its capacity is full.
G_FILE_ERROR_MFILE	The current process has too many files open and can't open any more. Duplicate descriptors do count toward this limit.
G_FILE_ERROR_NFILE	There are too many distinct file openings in the entire system.
G_FILE_ERROR_BADF	Bad file descriptor; for example, I/O on a descriptor that has been closed or reading from a descriptor open only for writing (or vice versa).
G_FILE_ERROR_INVAL	Invalid argument. This is used to indicate various kinds of problems with passing the wrong argument to a library function.
G_FILE_ERROR_PIPE	Broken pipe; there is no process reading from the other end of a pipe. Every library function that returns this error code also generates a `SIGPIPE' signal; this signal terminates the program if not handled or blocked. Thus, your program will never actually see this code unless it has handled or blocked `SIGPIPE'.
G_FILE_ERROR_AGAIN	Resource temporarily unavailable; the call might work if you try again later.
G_FILE_ERROR_INTR	Interrupted function call; an asynchronous signal occurred and prevented completion of the call. When this happens, you should try the call again.
G_FILE_ERROR_IO	Input/output error; usually used for physical read or write errors. i.e. the disk or other physical device hardware is returning errors.
G_FILE_ERROR_PERM	Operation not permitted; only the owner of the file (or other resource) or processes with special privileges can perform the operation.
G_FILE_ERROR_FAILED	Does not correspond to a UNIX error code; this is the standard "failed for unspecified reason" error code present in all GError error code enumerations. Returned if no specific code applies.
G_FILE_ERROR

#define G_FILE_ERROR g_file_error_quark ()

Error domain for file operations. Errors in this domain will be from the GFileError enumeration. See GError for information on error domains.
enum GFileTest

typedef enum
{
  G_FILE_TEST_IS_REGULAR    = 1 << 0,
  G_FILE_TEST_IS_SYMLINK    = 1 << 1,
  G_FILE_TEST_IS_DIR        = 1 << 2,
  G_FILE_TEST_IS_EXECUTABLE = 1 << 3,
  G_FILE_TEST_EXISTS        = 1 << 4
} GFileTest;

A test to perform an a file using g_file_test().
G_FILE_TEST_IS_REGULAR	TRUE if the file is a regular file (not a symlink or directory)
G_FILE_TEST_IS_SYMLINK	TRUE if the file is a symlink.
G_FILE_TEST_IS_DIR	TRUE if the file is a directory.
G_FILE_TEST_IS_EXECUTABLE	TRUE if the file is executable.
G_FILE_TEST_EXISTS	TRUE if the file exists. It may or may not be a regular file.
g_file_error_from_errno ()

GFileError  g_file_error_from_errno         (gint err_no);

Gets a GFileError constant based on the passed-in errno. For example, if you pass in EEXIST this function returns G_FILE_ERROR_EXIST. Unlike errno values, you can portably assume that all GFileError values will exist.

Normally a GFileError value goes into a GError returned from a function that manipulates files. So you would use g_file_error_from_errno() when constructing a GError.

err_no :	an "errno" value
Returns :	GFileError corresponding to the given errno
g_file_get_contents ()

gboolean    g_file_get_contents             (const gchar *filename,
                                             gchar **contents,
                                             gsize *length,
                                             GError **error);

Reads an entire file into allocated memory, with good error checking. If error is set, FALSE is returned, and contents is set to NULL. If TRUE is returned, error will not be set, and contents will be set to the file contents. The string stored in contents will be nul-terminated, so for text files you can pass NULL for the length argument. The error domain is G_FILE_ERROR. Possible error codes are those in the GFileError enumeration.

filename :	a file to read contents from
contents :	location to store an allocated string
length :	location to store length in bytes of the contents
error :	return location for a GError
Returns :	TRUE on success, FALSE if error is set
g_file_test ()

gboolean    g_file_test                     (const gchar *filename,
                                             GFileTest test);

Returns TRUE if any of the tests in the bitfield test are TRUE. For example, (G_FILE_TEST_EXISTS | G_FILE_TEST_IS_DIR) will return TRUE if the file exists; the check whether it's a directory doesn't matter since the existence test is TRUE. With the current set of available tests, there's no point passing in more than one test at a time.

Apart from G_FILE_TEST_IS_SYMLINK all tests follow symbolic links, so for a symbolic link to a regular file g_file_test() will return TRUE for both G_FILE_TEST_IS_SYMLINK and G_FILE_TEST_IS_REGULAR.

Note, that for a dangling symbolic link g_file_test() will return TRUE for G_FILE_TEST_IS_SYMLINK and FALSE for all other flags.

You should never use g_file_test() to test whether it is safe to perform an operaton, because there is always the possibility of the condition changing before you actually perform the operation. For example, you might think you could use G_FILE_TEST_IS_SYMLINK to know whether it is is safe to write to a file without being tricked into writing into a different location. It doesn't work!

/* DON'T DO THIS */
 if (!g_file_test (filename, G_FILE_TEST_IS_SYMLINK)) {
   fd = open (filename, O_WRONLY);
   /* write to fd */
 }

Another thing to note is that G_FILE_TEST_EXISTS and G_FILE_TEST_IS_EXECUTABLE are implemented using the access() system call. This usually doesn't matter, but if your program is setuid or setgid it means that these tests will give you the answer for the real user ID and group ID , rather than the effective user ID and group ID.

filename :	a filename to test
test :	bitfield of GFileTest flags
Returns :	whether a test was TRUE
g_mkstemp ()

gint        g_mkstemp                       (gchar *tmpl);

Opens a temporary file. See the mkstemp() documentation on most UNIX-like systems. This is a portability wrapper, which simply calls mkstemp() on systems that have it, and implements it in GLib otherwise.

The parameter is a string that should match the rules for mkstemp(), i.e. end in "XXXXXX". The X string will be modified to form the name of a file that didn't exist.

tmpl :	template filename
Returns :	A file handle (as from open()) to the file opened for reading and writing. The file is opened in binary mode on platforms where there is a difference. The file handle should be closed with close(). In case of errors, -1 is returned.
g_file_open_tmp ()

gint        g_file_open_tmp                 (const gchar *tmpl,
                                             gchar **name_used,
                                             GError **error);

Opens a file for writing in the preferred directory for temporary files (as returned by g_get_tmp_dir()).

tmpl should be a string ending with six 'X' characters, as the parameter to g_mkstemp() (or mkstemp()). However, unlike these functions, the template should only be a basename, no directory components are allowed. If template is NULL, a default template is used.

Note that in contrast to g_mkstemp() (and mkstemp()) tmpl is not modified, and might thus be a read-only literal string.

The actual name used is returned in name_used if non-NULL. This string should be freed with g_free() when not needed any longer.

tmpl :	Template for file name, as in g_mkstemp(), basename only
name_used :	location to store actual name used
error :	return location for a GError
Returns :	A file handle (as from open()) to the file opened for reading and writing. The file is opened in binary mode on platforms where there is a difference. The file handle should be closed with close(). In case of errors, -1 is returned and error will be set.
g_file_read_link ()

gchar*      g_file_read_link                (const gchar *filename,
                                             GError **error);

Reads the contents of the symbolic link filename like the POSIX readlink() function. The returned string is in the encoding used for filenames. Use g_filename_to_utf8() to convert it to UTF-8.

filename :	the symbolic link
error :	return location for a GError
Returns :	A newly allocated string with the contents of the symbolic link, or NULL if an error occurred.

Since 2.4
struct GDir

struct GDir;

An opaque structure representing an opened directory.
g_dir_open ()

GDir*       g_dir_open                      (const gchar *path,
                                             guint flags,
                                             GError **error);

Opens a directory for reading. The names of the files in the directory can then be retrieved using g_dir_read_name().

path :	the path to the directory you are interested in
flags :	Currently must be set to 0. Reserved for future use.
error :	return location for a GError, or NULL. If non-NULL, an error will be set if and only if g_dir_open_fails.
Returns :	a newly allocated GDir on success, NULL on failure. If non-NULL, you must free the result with g_dir_close() when you are finished with it.
g_dir_read_name ()

G_CONST_RETURN gchar* g_dir_read_name       (GDir *dir);

Retrieves the name of the next entry in the directory. The '.' and '..' entries are omitted. The returned name is in the encoding used for filenames. Use g_filename_to_utf8() to convert it to UTF-8.

dir :	a GDir* created by g_dir_open()
Returns :	The entries name or NULL if there are no more entries. The return value is owned by GLib and must not be modified or freed.
g_dir_rewind ()

void        g_dir_rewind                    (GDir *dir);

Resets the given directory. The next call to g_dir_read_name() will return the first entry again.

dir :	a GDir* created by g_dir_open()
g_dir_close ()

void        g_dir_close                     (GDir *dir);

Closes the directory and deallocates all related resources.

dir :	a GDir* created by g_dir_open()
+/

