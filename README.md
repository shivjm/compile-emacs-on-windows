# Compile Emacs from Source on Windows

Emacs cannot be compiled using native Windows tools, but it can be compiled using [the MinGW MSYS2 environments](https://www.msys2.org/). This script is primarily based on [u/tuhdo’s post on Reddit](https://www.reddit.com/r/emacs/comments/131354i/guide_compile_your_own_emacs_to_make_it_really/). Other references include:

* https://practical.li/blog/posts/build-emacs-from-source-on-ubuntu-linux/
* https://ubuntuhandbook.org/index.php/2021/12/compile-gnu-emacs-source-ubuntu/

Note that this script enables tree-sitter and native JSON parsing.

## Building

MSYS2 must have been installed already.

1. Open a MinGW / MSYS shell. (I’ve only used the 64-bit version.)
2. Clone this repository.
3. Run <kbd>./tuhdo-compile.sh</kbd>.

Assuming it completed successfully, you can find the Emacs distribution under the output directory and can run it using <kbd>./output/bin/emacs.exe</kbd>.
