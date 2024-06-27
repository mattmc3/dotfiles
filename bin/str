#!/usr/bin/env python3
"""
str - manipulate strings

A Python implementation of Fish's string utility
https://fishshell.com/docs/current/cmds/string.html
"""

import os
import re
import stat
import sys
import argparse

# region string subcommands


def str_length(args):
    """print string lengths"""
    if len(args.STRINGS) == 0:
        return 1
    for s in args.STRINGS:
        if not args.quiet:
            print(len(s))
    return 0


def str_sub(args):
    """extract substrings"""
    if len(args.STRINGS) == 0:
        return 1
    for s in args.STRINGS:
        newstr = s[args.start : args.end]
        if args.length is not None:
            newstr = newstr[: args.length]
        if not args.quiet:
            print(newstr)
    return 0


def str_pad(args):
    """pad strings to a fixed width"""
    if len(args.STRINGS) == 0:
        return 0
    if not args.width:
        args.width = max([len(x) for x in args.STRINGS])
    for s in args.STRINGS:
        if args.right:
            result = s.ljust(args.width, args.char)
        else:
            result = s.rjust(args.width, args.char)
        if not args.quiet:
            print(result)
    return 0


def str_trim(args):
    """remove leading or trailing whitespace"""
    errcode = 1
    for s in args.STRINGS:
        newstr = s
        if not args.left and not args.right:
            newstr = newstr.strip(args.chars)
        else:
            if args.left:
                newstr = newstr.lstrip(args.chars)
            if args.right:
                newstr = newstr.rstrip(args.chars)
        if newstr != s:
            errcode = 0
        if not args.quiet:
            print(newstr)
    return errcode


def str_join(args):
    """join strings with delimiter"""
    result = args.SEP.join(args.STRINGS)
    if not args.quiet:
        print(result)
    if len(args.STRINGS) < 2:
        return 1
    return 0


def str_join0(args):
    """join strings with null delimiter"""
    args.STRINGS.append("")
    args.SEP = "\0"
    return str_join(args)


def _split_chars(txt, maximum=-1, right=False):
    """split string on empty delimiter"""
    # python's split/rsplit functions don't support empty separators, so this method
    # does that work.
    if maximum == 0:
        return [txt]

    chars = list(txt)
    if maximum < 0:
        return chars

    if right:
        result = chars[maximum * -1 :]
        if maximum < len(txt):
            result.insert(0, "".join(chars[: maximum * -1]))
    else:
        result = chars[:maximum]
        if maximum < len(txt):
            result.append("".join(chars[maximum:]))

    return result


def str_split(args, remove_null_suffix=False):
    """split strings by delimiter"""
    if len(args.STRINGS) < 1:
        return 1

    errcode = 1
    nul = chr(0x00)
    for s in args.STRINGS:
        if remove_null_suffix and s.endswith(nul):
            s = s[:-1]

        if args.SEP == "":
            results = _split_chars(s, args.max, args.right)
        elif args.right:
            results = s.rsplit(args.SEP, args.max)
        else:
            results = s.split(args.SEP, args.max)

        if len(results) > 1:
            errcode = 0
        if not args.quiet:
            print(*results, sep="\n")

    return errcode


def str_split0(args):
    """split strings by null delimiter"""
    args.SEP = "\0"
    result = str_split(args, True)


def str_changecase(args):
    """
    change string case and return errcode if no strings were modified
    """
    errcode = 1
    for s in args.STRINGS:
        if args.case == "lower":
            newstr = s.lower()
        elif args.case == "upper":
            newstr = s.upper()
        else:
            raise ValueError(f"Unexpected case '{args.case}'.")
        if newstr != s:
            errcode = 0
        if not args.quiet:
            print(newstr)
    return errcode


def str_repeat(args):
    """
    change string case and return errcode if no strings were modified
    """
    errcode = 1
    for s in args.STRINGS:
        result = ""
        if args.count > 0:
            result = s * args.count
        elif args.max > 0:
            result = s * ((args.max // len(s)) + 1)
        if args.max > 0:
            result = result[: args.max]

        errcode = 0 if len(result) > 0 else errcode
        if not args.quiet:
            print(result)

    return errcode


def _convert_regex_flags(args):
    flags = 0
    if args.verbose:
        flags = flags | re.X
    if args.multiline:
        flags = flags | re.M
    if args.dotall:
        flags = flags | re.S
    if args.ignore_case:
        flags = flags | re.I
    return flags


def _regex_collect_matches(
    pattern,
    string,
    flags,
    all_matches,
    entire_string,
    groups_only,
    index_mode,
    fish_compat,
):
    matches = []
    for match in re.finditer(pattern, string, flags=flags):
        start = 1 if groups_only else 0
        for i in range(start, len(match.groups()) + 1):
            if entire_string and i == 0:
                matches.append(string)
            elif index_mode:
                span = match.span(i)
                if fish_compat:
                    span = span[0] + 1, span[1] - span[0]
                matches.append(" ".join(map(str, span)))
            else:
                matches.append(match.group(i))

        # just do the first one
        if not all_matches:
            break
    return matches


def str_match(args):
    """match substrings"""
    flags = _convert_regex_flags(args)

    errcode = 1
    for string in args.STRINGS:
        matches = _regex_collect_matches(
            args.PATTERN,
            string,
            flags,
            args.all,
            args.entire,
            args.groups_only,
            args.index,
            args.fish_compat,
        )

        # output
        if not args.quiet:
            found = len(matches) > 0
            if args.invert and not found:
                print(string)
            elif not args.invert and found:
                print(*matches, sep="\n")

        # determine overall success
        if found and not args.invert:
            errcode = 0
        elif not found and args.invert:
            errcode = 0
    return errcode


# endregion

# region not implement subcommands


def str_replace(args):
    """replace substrings"""
    pass


# endregion

# region argument parser


def int_try_parse(value):
    """try to parse integer from a string"""
    try:
        return int(value), True
    except ValueError:
        return value, False


def single_char(value):
    """verify an arg is a single character"""
    if len(str(value)) != 1:
        raise argparse.ArgumentTypeError(
            f"Invalid value '{value}'. Expecting a single character."
        )
    return value


def non_negative_int(value):
    """verify an arg is a positive integer"""
    value, isint = int_try_parse(value)
    if isint and value < 0:
        raise argparse.ArgumentTypeError(
            f"Invalid value '{value}'. Expecting a non-negative integer."
        )
    return int(value)


class StrArgParser:
    def __init__(self):
        self.parser = argparse.ArgumentParser()
        self.subparsers = self.parser.add_subparsers()
        self.parent_parser = argparse.ArgumentParser(add_help=False)
        self.parent_parser.add_argument(
            "-q",
            "--quiet",
            action="store_true",
            help="suppresses output but exits with the documented status",
        )
        self.add_joincmd_parser("join", str_join)
        self.add_joincmd_parser("join0", str_join0, False)
        self.add_simplecmd_parser("length", str_length)
        self.add_casecmd_parser("lower", str_changecase)
        self.add_matchcmd_parser("match", str_match)
        self.add_padcmd_parser("pad", str_pad)
        self.add_repeatcmd_parser("repeat", str_repeat)
        # self.add_replacecmd_parser("replace", str_replace)
        self.add_splitcmd_parser("split", str_split)
        self.add_splitcmd_parser("split0", str_split0, False)
        self.add_subcmd_parser("sub", str_sub)
        self.add_trimcmd_parser("trim", str_trim)
        self.add_casecmd_parser("upper", str_changecase)

    def add_simplecmd_parser(self, name, str_fn):
        p = self.add_subparser(name, str_fn)
        self.add_STRINGS_arg(p)

    def add_joincmd_parser(self, name, str_fn, include_sep=True):
        p = self.add_subparser(name, str_fn)
        if include_sep:
            p.add_argument("SEP", help="separator")
        self.add_STRINGS_arg(p)

    def add_splitcmd_parser(self, name, str_fn, include_sep=True):
        p = self.add_subparser(name, str_fn)
        p.add_argument(
            "-r",
            "--right",
            action="store_true",
            help="splitting is performed right to left",
        )
        p.add_argument(
            "-m",
            "--max",
            type=int,
            default=-1,
            help="at most MAX splits are done on each string",
        )
        if include_sep:
            p.add_argument("SEP", help="separator")
        self.add_STRINGS_arg(p)

    def add_subcmd_parser(self, name, str_fn):
        p = self.add_subparser(name, str_fn)
        p.add_argument(
            "-s",
            "--start",
            default=0,
            type=int,
            help="the start of the substring",
        )
        grp_mutex_endlen = p.add_mutually_exclusive_group()
        grp_mutex_endlen.add_argument(
            "-e",
            "--end",
            type=int,
            help="the end of the substring",
        )
        grp_mutex_endlen.add_argument(
            "-l",
            "--length",
            type=non_negative_int,
            help="the length of the substring",
        )
        self.add_STRINGS_arg(p)

    def add_padcmd_parser(self, name, str_fn):
        p = self.add_subparser(name, str_fn)
        p.add_argument(
            "-r",
            "--right",
            action="store_true",
            help="add the padding after a string",
        )
        p.add_argument(
            "-c",
            "--char",
            default=" ",
            type=single_char,
            help="pad with CHAR instead of whitespace",
        )
        p.add_argument(
            "-w",
            "--width",
            type=int,
            help="ensure minimum width of padded results",
        )
        self.add_STRINGS_arg(p)
        p.set_defaults(func=str_fn)

    def add_repeatcmd_parser(self, name, str_fn):
        p = self.add_subparser(name, str_fn)
        p.add_argument(
            "-n",
            "--count",
            default=0,
            type=non_negative_int,
            help="the number of times to repeat",
        )
        p.add_argument(
            "-m",
            "--max",
            default=0,
            type=non_negative_int,
            help="the maximum length of the result",
        )
        self.add_STRINGS_arg(p)

    def add_replacecmd_parser(self, name, str_fn):
        p = self.add_subparser(name, str_fn)
        # self.add_bool_arg(p, "regex", "patterns are PCRE regex syntax")
        self.add_bool_arg(p, "all", "report all matches not just the first one")
        self.add_bool_arg(p, "ignore-case", "match with case-insensitive")
        self.add_bool_arg(p, "filter", "only print strings with replacements")
        p.add_argument("PATTERN", help="the regex pattern to replace")
        p.add_argument("REPLACEMENT", help="the string replacement")
        self.add_STRINGS_arg(p)

    def add_matchcmd_parser(self, name, str_fn):
        p = self.add_subparser(name, str_fn)
        # self.add_bool_arg(p, "regex", "patterns are PCRE regex syntax")
        self.add_bool_arg(p, "all", "report all matches not just the first one")
        self.add_bool_arg(
            p,
            "index",
            "print the starting and ending indices of matches",
            short_char="n",
        )
        grp_mutex_output = p.add_mutually_exclusive_group()
        grp_mutex_output.add_argument(
            "-e",
            "--entire",
            action="store_true",
            help="print the entire matching string",
        )
        grp_mutex_output.add_argument(
            "-g",
            "--groups-only",
            action="store_true",
            help="print only the regex capturing groups of matches",
        )
        grp_mutex_output.add_argument(
            "-v",
            "--invert",
            action="store_true",
            help="print only non-matching strings",
        )
        self.add_bool_arg(
            p, "verbose", "regex verbose (extended) option", short_char="x"
        )
        self.add_bool_arg(p, "multiline", "regex multiline option")
        self.add_bool_arg(
            p, "dotall", "regex dotall (singleline) option", short_char="s"
        )
        self.add_bool_arg(p, "ignore-case", "regex case-insensitive option")
        self.add_bool_arg(p, "regex", "unused, but provided for compatibility")
        self.add_bool_arg(
            p, "fish-compat", "compatibility mode with fish's string util"
        )
        p.add_argument("PATTERN", help="the regex pattern to match")
        self.add_STRINGS_arg(p)

    def add_trimcmd_parser(self, name, str_fn):
        p = self.add_subparser(name, str_fn)
        self.add_bool_arg(p, "left", "only leading whitespace is removed")
        self.add_bool_arg(p, "right", "only trailing whitespace is removed")
        self.add_arg(p, "chars", help="remove specific chars instead of whitespace")
        self.add_STRINGS_arg(p)

    def add_casecmd_parser(self, name, str_fn, strcase=None):
        if not strcase:
            strcase = name
        p = self.add_subparser(
            name, str_fn, help=f"convert strings to {strcase}case"
        )
        p.add_argument("--case", default=strcase, help=argparse.SUPPRESS)
        self.add_STRINGS_arg(p)

    def add_subparser(self, name, str_fn, help=None):
        if not help:
            help = str_fn.__doc__
        p = self.subparsers.add_parser(name, parents=[self.parent_parser], help=help)
        p.set_defaults(func=str_fn)
        return p

    def add_bool_arg(self, parser, name, help, short_char=None):
        self.add_arg(parser, name, help, action="store_true", short_char=short_char)

    def add_arg(self, parser, name, help, action="store", short_char=None):
        if not short_char:
            short_char = name[0]
        parser.add_argument(
            f"-{short_char}",
            f"--{name}",
            action=action,
            help=help,
        )

    def add_STRINGS_arg(self, parser):
        parser.add_argument("STRINGS", nargs="*", help="strings to manipulate")


# endregion


def stdin_is_piped():
    fileno = sys.stdin.fileno()
    mode = os.fstat(fileno).st_mode
    return not os.isatty(fileno) and stat.S_ISFIFO(mode)


def main():
    if len(sys.argv) == 1:
        print("str: missing subcommand", file=sys.stderr)
        return 2

    # parse args and call func
    parser = StrArgParser().parser
    args = parser.parse_args()

    if stdin_is_piped():
        args.STRINGS.extend(sys.stdin.read().splitlines())

    return args.func(args)


if __name__ == "__main__":
    result = main()
    if result is None:
        result = 0
    exit(result)
