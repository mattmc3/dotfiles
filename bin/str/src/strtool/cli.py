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
import click
import fnmatch


@click.group(context_settings={"help_option_names": ["-h", "--help"]})
def cli():
    """Manipulate strings - A Python implementation of Fish's string utility"""
    pass


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.argument("strings", nargs=-1)
@click.pass_context
def length(ctx, quiet, strings):
    """Print string lengths"""
    strings = list(strings) + read_stdin_if_piped()
    if len(strings) == 0:
        ctx.exit(1)
    for s in strings:
        if not quiet:
            click.echo(len(s))
    ctx.exit(0)


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.option("-s", "--start", default=0, type=int, help="The start of the substring")
@click.option("-e", "--end", type=int, help="The end of the substring")
@click.option("-l", "--length", type=int, help="The length of the substring")
@click.argument("strings", nargs=-1)
@click.pass_context
def sub(ctx, quiet, start, end, length, strings):
    """Extract substrings"""
    strings = list(strings) + read_stdin_if_piped()
    if len(strings) == 0:
        ctx.exit(1)

    if end is not None and length is not None:
        click.echo("Error: Cannot specify both --end and --length", err=True)
        ctx.exit(2)

    for s in strings:
        newstr = s[start:end]
        if length is not None:
            newstr = newstr[:length]
        if not quiet:
            click.echo(newstr)
    ctx.exit(0)


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.option("-r", "--right", is_flag=True, help="Add the padding after a string")
@click.option("-c", "--char", default=" ", help="Pad with CHAR instead of whitespace")
@click.option("-w", "--width", type=int, help="Ensure minimum width of padded results")
@click.argument("strings", nargs=-1)
@click.pass_context
def pad(ctx, quiet, right, char, width, strings):
    """Pad strings to a fixed width"""
    strings = list(strings) + read_stdin_if_piped()
    if len(strings) == 0:
        ctx.exit(0)

    if len(char) != 1:
        click.echo(f"Error: --char must be a single character", err=True)
        ctx.exit(2)

    if not width:
        width = max([len(x) for x in strings])

    for s in strings:
        if right:
            result = s.ljust(width, char)
        else:
            result = s.rjust(width, char)
        if not quiet:
            click.echo(result)
    ctx.exit(0)


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.option("-l", "--left", is_flag=True, help="Only leading whitespace is removed")
@click.option("-r", "--right", is_flag=True, help="Only trailing whitespace is removed")
@click.option("-c", "--chars", help="Remove specific chars instead of whitespace")
@click.argument("strings", nargs=-1)
@click.pass_context
def trim(ctx, quiet, left, right, chars, strings):
    """Remove leading or trailing whitespace"""
    strings = list(strings) + read_stdin_if_piped()
    errcode = 1

    for s in strings:
        newstr = s
        if not left and not right:
            newstr = newstr.strip(chars)
        else:
            if left:
                newstr = newstr.lstrip(chars)
            if right:
                newstr = newstr.rstrip(chars)
        if newstr != s:
            errcode = 0
        if not quiet:
            click.echo(newstr)
    ctx.exit(errcode)


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.argument("sep")
@click.argument("strings", nargs=-1)
@click.pass_context
def join(ctx, quiet, sep, strings):
    """Join strings with delimiter"""
    strings = list(strings) + read_stdin_if_piped()
    result = sep.join(strings)
    if not quiet:
        click.echo(result)
    ctx.exit(0 if len(strings) >= 2 else 1)


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.argument("strings", nargs=-1)
@click.pass_context
def join0(ctx, quiet, strings):
    """Join strings with null delimiter"""
    strings = list(strings) + read_stdin_if_piped()
    strings.append("")
    result = "\0".join(strings)
    if not quiet:
        click.echo(result)
    ctx.exit(0 if len(strings) >= 2 else 1)


def _split_chars(txt, maximum=-1, right=False):
    """Split string on empty delimiter"""
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


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.option("-r", "--right", is_flag=True, help="Splitting is performed right to left")
@click.option(
    "-m",
    "--max",
    "maximum",
    default=-1,
    type=int,
    help="At most MAX splits are done on each string",
)
@click.argument("sep")
@click.argument("strings", nargs=-1)
@click.pass_context
def split(ctx, quiet, right, maximum, sep, strings):
    """Split strings by delimiter"""
    strings = list(strings) + read_stdin_if_piped()
    if len(strings) < 1:
        ctx.exit(1)

    errcode = 1
    for s in strings:
        if sep == "":
            results = _split_chars(s, maximum, right)
        elif right:
            results = s.rsplit(sep, maximum)
        else:
            results = s.split(sep, maximum)

        if len(results) > 1:
            errcode = 0
        if not quiet:
            for result in results:
                click.echo(result)

    ctx.exit(errcode)


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.option("-r", "--right", is_flag=True, help="Splitting is performed right to left")
@click.option(
    "-m",
    "--max",
    "maximum",
    default=-1,
    type=int,
    help="At most MAX splits are done on each string",
)
@click.argument("strings", nargs=-1)
@click.pass_context
def split0(ctx, quiet, right, maximum, strings):
    """Split strings by null delimiter"""
    strings = list(strings) + read_stdin_if_piped()
    if len(strings) < 1:
        ctx.exit(1)

    errcode = 1
    nul = chr(0x00)
    for s in strings:
        if s.endswith(nul):
            s = s[:-1]

        if right:
            results = s.rsplit(nul, maximum)
        else:
            results = s.split(nul, maximum)

        if len(results) > 1:
            errcode = 0
        if not quiet:
            for result in results:
                click.echo(result)

    ctx.exit(errcode)


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.argument("strings", nargs=-1)
@click.pass_context
def lower(ctx, quiet, strings):
    """Convert strings to lowercase"""
    strings = list(strings) + read_stdin_if_piped()
    errcode = 1
    for s in strings:
        newstr = s.lower()
        if newstr != s:
            errcode = 0
        if not quiet:
            click.echo(newstr)
    ctx.exit(errcode)


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.argument("strings", nargs=-1)
@click.pass_context
def upper(ctx, quiet, strings):
    """Convert strings to uppercase"""
    strings = list(strings) + read_stdin_if_piped()
    errcode = 1
    for s in strings:
        newstr = s.upper()
        if newstr != s:
            errcode = 0
        if not quiet:
            click.echo(newstr)
    ctx.exit(errcode)


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.option("-n", "--count", default=0, type=int, help="The number of times to repeat")
@click.option(
    "-m",
    "--max",
    "maximum",
    default=0,
    type=int,
    help="The maximum length of the result",
)
@click.argument("strings", nargs=-1)
@click.pass_context
def repeat(ctx, quiet, count, maximum, strings):
    """Repeat strings"""
    strings = list(strings) + read_stdin_if_piped()
    errcode = 1

    if count < 0:
        click.echo("Error: --count must be non-negative", err=True)
        ctx.exit(2)
    if maximum < 0:
        click.echo("Error: --max must be non-negative", err=True)
        ctx.exit(2)

    for s in strings:
        result = ""
        if count > 0:
            result = s * count
        elif maximum > 0:
            result = s * ((maximum // len(s)) + 1)
        if maximum > 0:
            result = result[:maximum]

        errcode = 0 if len(result) > 0 else errcode
        if not quiet:
            click.echo(result)

    ctx.exit(errcode)


def _convert_regex_flags(verbose, multiline, dotall, ignore_case):
    flags = 0
    if verbose:
        flags = flags | re.X
    if multiline:
        flags = flags | re.M
    if dotall:
        flags = flags | re.S
    if ignore_case:
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


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.option("-a", "--all", is_flag=True, help="Report all matches not just the first one")
@click.option("-n", "--index", is_flag=True, help="Print the starting and ending indices of matches")
@click.option("-e", "--entire", is_flag=True, help="Print the entire matching string")
@click.option("-g", "--groups-only", is_flag=True, help="Print only the regex capturing groups of matches")
@click.option("-v", "--invert", is_flag=True, help="Print only non-matching strings")
@click.option("-x", "--verbose", is_flag=True, help="Regex verbose (extended) option")
@click.option("--multiline", is_flag=True, help="Regex multiline option")
@click.option("-s", "--dotall", is_flag=True, help="Regex dotall (singleline) option")
@click.option("-i", "--ignore-case", is_flag=True, help="Regex case-insensitive option")
@click.option("-r", "--regex", is_flag=True, help="Use regex instead of glob pattern matching")
@click.option("--fish-compat", is_flag=True, help="Compatibility mode with fish's string util")
@click.argument("pattern")
@click.argument("strings", nargs=-1)
@click.pass_context
def match(
    ctx, quiet, all, index, entire, groups_only, invert, verbose, multiline, dotall, ignore_case, regex, fish_compat, pattern, strings
):
    """Match substrings"""
    strings = list(strings) + read_stdin_if_piped()

    if entire and groups_only:
        click.echo("Error: Cannot specify both --entire and --groups-only", err=True)
        ctx.exit(2)
    if entire and invert:
        click.echo("Error: Cannot specify both --entire and --invert", err=True)
        ctx.exit(2)
    if groups_only and invert:
        click.echo("Error: Cannot specify both --groups-only and --invert", err=True)
        ctx.exit(2)

    # Convert glob to regex if not using --regex flag
    if not regex:
        pattern = fnmatch.translate(pattern)

    flags = _convert_regex_flags(verbose, multiline, dotall, ignore_case)

    errcode = 1
    for string in strings:
        matches = _regex_collect_matches(
            pattern,
            string,
            flags,
            all,
            entire,
            groups_only,
            index,
            fish_compat,
        )

        found = len(matches) > 0

        if not quiet:
            if invert and not found:
                click.echo(string)
            elif not invert and found:
                for m in matches:
                    click.echo(m)

        if found and not invert:
            errcode = 0
        elif not found and invert:
            errcode = 0

    ctx.exit(errcode)


@cli.command()
@click.option("-q", "--quiet", is_flag=True, help="Suppresses output but exits with the documented status")
@click.option("-a", "--all", is_flag=True, help="Report all matches not just the first one")
@click.option("-i", "--ignore-case", is_flag=True, help="Match with case-insensitive")
@click.option("-f", "--filter", is_flag=True, help="Only print strings with replacements")
@click.option("-r", "--regex", is_flag=True, help="Use regex instead of glob pattern matching")
@click.argument("pattern")
@click.argument("replacement")
@click.argument("strings", nargs=-1)
@click.pass_context
def replace(ctx, quiet, all, ignore_case, filter, regex, pattern, replacement, strings):
    """Replace substrings"""
    strings = list(strings) + read_stdin_if_piped()

    # Convert glob to regex if not using --regex flag
    if not regex:
        pattern = fnmatch.translate(pattern)

    flags = 0
    if ignore_case:
        flags = re.I

    errcode = 1
    for s in strings:
        if all:
            newstr = re.sub(pattern, replacement, s, flags=flags)
        else:
            newstr = re.sub(pattern, replacement, s, count=1, flags=flags)

        if newstr != s:
            errcode = 0

        if not quiet:
            if filter and newstr == s:
                continue
            click.echo(newstr)

    ctx.exit(errcode)


def stdin_is_piped():
    fileno = sys.stdin.fileno()
    mode = os.fstat(fileno).st_mode
    return not os.isatty(fileno) and stat.S_ISFIFO(mode)


def read_stdin_if_piped():
    if stdin_is_piped():
        return sys.stdin.read().splitlines()
    return []


def main():
    cli()


if __name__ == "__main__":
    main()
