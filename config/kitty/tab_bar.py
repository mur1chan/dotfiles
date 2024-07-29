# pyright: reportMissingImports=false
# pylint: disable=E0401,C0116,C0103,W0603,R0913

import datetime
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    TabBarData,
    as_rgb,
    draw_title,
)
from kitty.utils import color_as_int

opts = get_options()

# colors
TABBAR_BG = as_rgb(color_as_int(opts.tab_bar_background or opts.color0))
ACTIVE_BG = as_rgb(color_as_int(opts.active_tab_background or opts.color8))
ACTIVE_FG = as_rgb(color_as_int(opts.active_tab_foreground or opts.color4))
INACTIVE_BG = as_rgb(color_as_int(opts.inactive_tab_background or opts.color12))
INACTIVE_FG = as_rgb(color_as_int(opts.inactive_tab_foreground or opts.color7))
ACTIVE_WINDOW_BG = as_rgb(color_as_int(opts.color6))


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    _draw_left_status(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )

    if is_last:
        _draw_right_status(screen)

    return screen.cursor.x


def _draw_right_status(screen: Screen) -> int:
    now = datetime.datetime.now().strftime("%H:%M")
    time_fg = INACTIVE_FG
    time_bg = TABBAR_BG
    time_str = f" {now} "

    right_status_length = len(time_str)

    leading_spaces = screen.columns - screen.cursor.x - right_status_length

    if leading_spaces > 0:
        screen.draw(" " * leading_spaces)

    screen.cursor.fg = time_fg
    screen.cursor.bg = time_bg
    screen.draw(time_str)
    screen.cursor.fg = 0
    screen.cursor.bg = 0

    screen.cursor.x = max(screen.cursor.x, screen.columns - right_status_length)
    return screen.cursor.x


SEPARATOR_SYMBOL, SOFT_SEPARATOR_SYMBOL = ("", "")


def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    tab_bg = screen.cursor.bg
    tab_fg = screen.cursor.fg
    default_bg = as_rgb(int(draw_data.default_bg))
    if extra_data.next_tab:
        next_tab_bg = as_rgb(draw_data.tab_bg(extra_data.next_tab))
        needs_soft_separator = next_tab_bg == tab_bg
    else:
        next_tab_bg = default_bg
        needs_soft_separator = False
    screen.cursor.bg = tab_bg
    draw_title(draw_data, screen, tab, index)
    if not needs_soft_separator:
        screen.draw(" ")
        screen.cursor.fg = tab_bg
        screen.cursor.bg = next_tab_bg
        screen.draw(SEPARATOR_SYMBOL)
    else:
        prev_fg = screen.cursor.fg
        if tab_bg == tab_fg:
            screen.cursor.fg = default_bg
        elif tab_bg != default_bg:
            c1 = draw_data.inactive_bg.contrast(draw_data.default_bg)
            c2 = draw_data.inactive_bg.contrast(draw_data.inactive_fg)
            if c1 < c2:
                screen.cursor.fg = default_bg
        screen.cursor.fg = prev_fg
        screen.draw(" " + SOFT_SEPARATOR_SYMBOL)
    end = screen.cursor.x
    return end
