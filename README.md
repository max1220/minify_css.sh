# minify_css.sh

The most basic CSS "compiler"(concatenator) and minifier(removes whitespace and comments),
implemented in Bash using only basic text processing utilities(cat, sed, gzip).



## Warning

Some care needs to be taken to make sure that the CSS files are not "mangeled":
You need consistent newlines at the ends of files, and the sed scripts
might not deal well with e.g. space, tabs, comments in strings, special escape sequences etc.

If in doubt, consult the sed command or take a close look at the
generated minified CSS scripts in a browser, after parsing(via the developer tools).

You have been warned! <small>(I've never had any issues with this though™)</small>



## Usage

```
minify_css.sh <input dir> <concat file> <minified file> <gzipped file>
```

`<input dir>` is the input directory for locating CSS files.
Only filenames matching the format `xxx_*.css`(xxx is a digit 0-9) are read.

If only `<input dir>` is the only argument the concatenated CSS is written to stdout.

`<concat file>` is the optional output file path for the concatenated CSS.

`<minified file>` is the optional output file path for minified CSS.

`<gzipped file>` is the optional output file path for gzipped CSS.
