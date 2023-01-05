from ranger.api.commands import Command
from collections import deque
import re

class fzf_select(Command):
    """
    :fzf_select
    Find a file using fzf.
    With a prefix argument to select only directories.

    See: https://github.com/junegunn/fzf
    """

    def execute(self):
        import subprocess
        import os
        from ranger.ext.get_executables import get_executables

        if 'fzf' not in get_executables():
            self.fm.notify('Could not find fzf in the PATH.', bad=True)
            return

        fd = None
        if 'fdfind' in get_executables():
            fd = 'fdfind'
        elif 'fd' in get_executables():
            fd = 'fd'

        if fd is not None:
            hidden = ('--hidden' if self.fm.settings.show_hidden else '')
            exclude = "--no-ignore-vcs --exclude '.git' --exclude '*.py[co]' --exclude '__pycache__'"
            only_directories = ('--type directory' if self.quantifier else '')
            fzf_default_command = '{} --follow {} {} {} --color=always'.format(
                fd, hidden, exclude, only_directories
            )
        else:
            hidden = ('-false' if self.fm.settings.show_hidden else r"-path '*/\.*' -prune")
            exclude = r"\( -name '\.git' -o -iname '\.*py[co]' -o -fstype 'dev' -o -fstype 'proc' \) -prune"
            only_directories = ('-type d' if self.quantifier else '')
            fzf_default_command = 'find -L . -mindepth 1 {} -o {} -o {} -print | cut -b3-'.format(
                hidden, exclude, only_directories
            )

        env = os.environ.copy()
        env['FZF_DEFAULT_COMMAND'] = fzf_default_command
        env['FZF_DEFAULT_OPTS'] = ' --layout=reverse --ansi --preview="{}"'.format('''
            (
                batcat --color=always {} ||
                bat --color=always {} ||
                cat {} ||
                tree -ahpCL 3 -I '.git' -I '*.py[co]' -I '__pycache__' {}
            ) 2>/dev/null | head -n 100
        ''')

        fzf = self.fm.execute_command('fzf --no-multi', env=env,
                                      universal_newlines=True, stdout=subprocess.PIPE)
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            selected = os.path.abspath(stdout.strip())
            if os.path.isdir(selected):
                self.fm.cd(selected)
            else:
                self.fm.select_file(selected)

class fzf_rga_documents_search(Command):
    """
    :fzf_rga_search_documents
    Search in PDFs, E-Books and Office documents in current directory.
    Allowed extensions: .epub, .odt, .docx, .fb2, .ipynb, .pdf.

    Usage: fzf_rga_search_documents <search string>
    """
    def execute(self):
        if self.arg(1):
            search_string = self.rest(1)
        else:
            self.fm.notify("Usage: fzf_rga_search_documents <search string>", bad=True)
            return

        import subprocess
        import os.path
        from ranger.container.file import File
        command="rga '%s' . --rga-adapters=pandoc,poppler | fzf +m | awk -F':' '{print $1}'" % search_string
        fzf = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = fzf.communicate()
        if fzf.returncode == 0:
            fzf_file = os.path.abspath(stdout.rstrip('\n'))
            self.fm.execute_file(File(fzf_file))

class fuzzy(Command):
    """:fuzzy [-FLAGS...] <pattern>

    Swiss army knife command for searching, traveling and filtering files.

    Flags:
     -a    Automatically open a file on unambiguous match
     -e    Open the selected file when pressing enter
     -f    Filter files that match the current search pattern
     -g    Interpret pattern as a glob pattern
     -i    Ignore the letter case of the files
     -k    Keep the console open when changing a directory with the command
     -l    Letter skipping; e.g. allow "rdme" to match the file "readme"
     -m    Mark the matching files after pressing enter
     -M    Unmark the matching files after pressing enter
     -p    Permanent filter: hide non-matching files after pressing enter
     -r    Interpret pattern as a regular expression pattern
     -s    Smart case; like -i unless pattern contains upper case letters
     -t    Apply filter and search pattern as you type
     -v    Inverts the match

    Multiple flags can be combined.  For example, ":fuzzy -gpt" would create
    a :filter-like command using globbing.
    """

    AUTO_OPEN = "a"
    OPEN_ON_ENTER = "e"
    FILTER = "f"
    SM_GLOB = "g"
    IGNORE_CASE = "i"
    KEEP_OPEN = "k"
    SM_LETTERSKIP = "l"
    MARK = "m"
    UNMARK = "M"
    PERM_FILTER = "p"
    SM_REGEX = "r"
    SMART_CASE = "s"
    AS_YOU_TYPE = "t"
    INVERT = "v"

    def __init__(self, *args, **kwargs):
        super(fuzzy, self).__init__(*args, **kwargs)
        self._regex = None
        self.flags, self.pattern = self.parse_flags()

    def execute(self):  # pylint: disable=too-many-branches
        thisdir = self.fm.thisdir
        #flags = self.flags
        #pattern = self.pattern
        #regex = self._build_regex()
        #count = self._count(move=True)

#        self.fm.thistab.last_search = regex
#        self.fm.set_search_method(order="search")
#
#        if (self.MARK in flags or self.UNMARK in flags) and thisdir.files:
#            value = flags.find(self.MARK) > flags.find(self.UNMARK)
#            if self.FILTER in flags:
#                for fobj in thisdir.files:
#                    thisdir.mark_item(fobj, value)
#            else:
#                for fobj in thisdir.files:
#                    if regex.search(fobj.relative_path):
#                        thisdir.mark_item(fobj, value)
#
#        if self.PERM_FILTER in flags:
#            thisdir.filter = regex if pattern else None
#
#        # clean up:
#        self.cancel()
#
#        if self.OPEN_ON_ENTER in flags or \
#                (self.AUTO_OPEN in flags and count == 1):
#            if pattern == '..':
#                self.fm.cd(pattern)
#            else:
#                self.fm.move(right=1)
#                if self.quickly_executed:
#                    self.fm.block_input(0.5)
#
#        if self.KEEP_OPEN in flags and thisdir != self.fm.thisdir:
#            # reopen the console:
#            if not pattern:
#                self.fm.open_console(self.line)
#            else:
#                self.fm.open_console(self.line[0:-len(pattern)])
#
#        if self.quickly_executed and thisdir != self.fm.thisdir and pattern != "..":
#            self.fm.block_input(0.5)
#
    def cancel(self):
        self.fm.thisdir.temporary_filter = None
        self.fm.thisdir.refilter()

    def quick(self):
        asyoutype = self.AS_YOU_TYPE in self.flags
        if self.FILTER in self.flags:
            self.fm.thisdir.temporary_filter = self._build_regex()
        if self.PERM_FILTER in self.flags and asyoutype:
            self.fm.thisdir.filter = self._build_regex()
        if self.FILTER in self.flags or self.PERM_FILTER in self.flags:
            self.fm.thisdir.refilter()
        if self._count(move=asyoutype) == 1 and self.AUTO_OPEN in self.flags:
            return True
        return False

    def tab(self, tabnum):
        self._count(move=True, offset=tabnum)

    def _build_regex(self):
        if self._regex is not None:
            return self._regex

        frmat = "%s"
        flags = self.flags
        pattern = self.pattern

        if pattern == ".":
            return re.compile("")

        # Handle carets at start and dollar signs at end separately
        if pattern.startswith('^'):
            pattern = pattern[1:]
            frmat = "^" + frmat
        if pattern.endswith('$'):
            pattern = pattern[:-1]
            frmat += "$"

        # Apply one of the search methods
        if self.SM_REGEX in flags:
            regex = pattern
        elif self.SM_GLOB in flags:
            regex = re.escape(pattern).replace("\\*", ".*").replace("\\?", ".")
        elif self.SM_LETTERSKIP in flags:
            regex = ".*".join(re.escape(c) for c in pattern)
        else:
            regex = re.escape(pattern)

        regex = frmat % regex

        # Invert regular expression if necessary
        if self.INVERT in flags:
            regex = "^(?:(?!%s).)*$" % regex

        # Compile Regular Expression
        # pylint: disable=no-member
        options = re.UNICODE
        if self.IGNORE_CASE in flags or self.SMART_CASE in flags and \
                pattern.islower():
            options |= re.IGNORECASE
        # pylint: enable=no-member
        try:
            self._regex = re.compile(regex, options)
        except re.error:
            self._regex = re.compile("")
        return self._regex

    def _count(self, move=False, offset=0):
        count = 0
        cwd = self.fm.thisdir
        pattern = self.pattern

        if not pattern or not cwd.files:
            return 0
        if pattern == '.':
            return 0
        if pattern == '..':
            return 1

        deq = deque(cwd.files)
        deq.rotate(-cwd.pointer - offset)
        i = offset
        regex = self._build_regex()
        for fsobj in deq:
            if regex.search(fsobj.relative_path):
                count += 1
                if move and count == 1:
                    cwd.move(to=(cwd.pointer + i) % len(cwd.files))
                    self.fm.thisfile = cwd.pointed_obj
            if count > 1:
                return count
            i += 1

        return count == 1

import parasail


class SwSortKey:
    def __init__(self):
        self.Alphabet = set()
        self.MatchScore = 2
        self.MismatchScore = -1
        self.GapOpen = 2
        self.GapExtend = 0
        self.MatchMatrix = None

        self.Ref = None

    def setRef(self, ref):
        self.Ref = ref
        self._addToAlphabet(ref)

    def __call__(self, s):
        self._addToAlphabet(s)
        r = parasail.sw_striped_16(s, self.Ref, self.GapOpen, self.GapExtend, self.MatchMatrix)
        return r.score + 1 / len(s)

    def _addToAlphabet(self, x):
        chars = set(x)
        newChars = chars - self.Alphabet
        if len(newChars) == 0:
            return

        self.Alphabet.update(newChars)
        self.MatchMatrix = parasail.matrix_create(''.join(self.Alphabet), self.MatchScore, self.MismatchScore)


class SwSplitApplySortKey(SwSortKey):
    '''
    - splits ref by splitBy
    - applies applyF to sort item
    - matches new sort item to all parts of ref
    - returns sum of scores
    '''

    def __init__(self, splitBy=None, applyF=lambda item: item):
        super().__init__()

        self.SplitBy = splitBy
        self.ApplyF = applyF

        self._Refs = None

    def setRef(self, ref):
        self.Ref = ref
        self._Refs = refs = ref.split(self.SplitBy)
        for ref in refs:
            self._addToAlphabet(ref)

    def __call__(self, x):
        refBak = self.Ref

        x = self.ApplyF(x)
        r = 0

        try:
            for ref in self._Refs:
                self.Ref = ref
                r += super().__call__(x)
        finally:
            self.Ref = refBak

        return r


sortKey = SwSplitApplySortKey()


class sw_nav(Command):
    OPEN_ON_ENTER = 'e'
    IGNORE_CASE = 'i'
    KEEP_OPEN = 'k'
    SMART_CASE = 's'
    OPEN_ON_TAB = 't'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.Flags, self.Ref = self.parse_flags()

    def quick(self):
        ignoreCase = sw_nav.IGNORE_CASE in self.Flags or (sw_nav.SMART_CASE in self.Flags and self.Ref.islower())

        # modify global key
        if ignoreCase:
            sortKey.setRef(self.Ref.lower())
            sortKey.ApplyF = lambda item: item.relative_path_lower
        else:
            sortKey.setRef(self.Ref)
            sortKey.ApplyF = lambda item: item.relative_path

        # force sort
        thisdir = self.fm.thisdir
        thisdir.files_all.sort(key=sortKey, reverse=True)
        thisdir.refilter()
        thisdir.move(to=0)

        return False

    def tab(self, tabnum):
        if sw_nav.OPEN_ON_TAB in self.Flags:
            self._finish()
            self._open()
            return

        self.fm.thisdir.move(down=tabnum)

    def execute(self):
        if sw_nav.OPEN_ON_ENTER not in self.Flags:
            return

        self._finish()
        self._open()

    def _open(self):
        self.fm.move(right=1)

        if sw_nav.KEEP_OPEN not in self.Flags:
            return

        if len(self.Ref) == 0:
            line = self.line
        else:
            line = self.line[:-len(self.Ref):]
        self.fm.open_console(line)

    def cancel(self):
        self._finish()

    def _finish(self):
        thisdir = self.fm.thisdir
        thisdir.sort()
