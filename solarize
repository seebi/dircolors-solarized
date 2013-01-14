#!/usr/bin/python
"""Solarized theme for gnome-terminal

see http://ethanschoonover.com/solarized
"""
import posixpath
from optparse import OptionParser
import gconf

BASE03 = '#002B36'
BASE02 = '#073642'
BASE01 = '#586E75'
BASE00 = '#657B83'
BASE0 = '#839496'
BASE1 = '#93A1A1'
BASE2 = '#EEE8D5'
BASE3 = '#FDF6E3'
YELLOW = '#B58900'
ORANGE = '#CB4B16'
RED = '#DC322F'
MAGENTA = '#D33682'
VIOLET = '#6C71C4'
BLUE = '#268BD2'
CYAN = '#2AA198'
GREEN = '#859900'
# 16 colors palette
PALETTE = [BASE02, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, BASE2,
           BASE03, ORANGE, BASE01, BASE00, BASE0, VIOLET, BASE1, BASE3]
SCHEMES = {'dark': {'background_color': BASE03,
                    'foreground_color': BASE0,
                    'bold_color': BASE1},
           'light': {'background_color': BASE3,
                     'foreground_color': BASE00,
                     'bold_color': BASE01}}


def _solarize(profile, scheme):
    conf = {
        'solarized_scheme': scheme,
        'visible_name': profile,
        'palette': ':'.join(PALETTE),
        'use_theme_colors': False,
        'use_theme_background': False,
        'bold_color_same_as_fg': False,
        #'default_show_menubar': False,
        #'use_system_font': False,
        #'font': 'Inconsolata Medium 10',
    }
    conf.update(SCHEMES[scheme])
    _set_profile(profile, **conf)


def _set_profile(profile, **conf):
    c = gconf.client_get_default()
    pp = lambda k: _gpath('profiles', profile, k)
    for k, v in conf.iteritems():
        _set_value(c, pp(k), v)

    # Add name to profile list
    profiles = c.get_list(_gpath('global/profile_list'), gconf.VALUE_STRING)
    if profile not in profiles:
        profiles.append(profile)
        c.set_list(_gpath('global/profile_list'), gconf.VALUE_STRING, profiles)
    # Set profile as default for new windows
    c.set_string(_gpath('global/default_profile'), profile)


def _next_scheme(profile):
    c = gconf.client_get_default()
    scheme = c.get_string(_gpath('profiles', profile, 'solarized_scheme'))
    return 'light' if scheme == 'dark' else 'dark'


def _gpath(*parts):
    return posixpath.join('/apps/gnome-terminal', *parts)


def _set_value(c, k, v):
    if isinstance(v, str):
        c.set_string(k, v)
    elif isinstance(v, bool):
        c.set_bool(k, v)
    elif isinstance(v, int):
        c.set_int(k, v)
    else:
        raise ValueError('Unknown type for key %s: %s', k, type(v))


def main():
    op = OptionParser()
    op.add_option('-p', '--profile', default='Solarized',
                  help='gnome-terminal profile name to set, default="%default"')
    opts, args = op.parse_args()

    scheme = args[0] if args else _next_scheme(opts.profile)
    if scheme in ('dark', 'light'):
        _solarize(profile=opts.profile, scheme=scheme)
    else:
        op.error('Unknown scheme: %s' % scheme)


if __name__ == '__main__':
    main()
