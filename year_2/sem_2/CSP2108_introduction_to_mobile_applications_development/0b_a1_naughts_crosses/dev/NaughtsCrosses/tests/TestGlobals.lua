require("modules.30log.30log-global");

-- stub display since unit tests run independent of corona sdk
display = require("mocks.mockDisplay");
Logger = require("Logger");
Board = require("Board");
Game = require("Game");
Ai = require("Ai");
event = {
    phase = "ended"
};

-- setup globals, see main.lua
_d = display;
_w = _d.contentWidth;
_h = _d.contentHeight;
_cx = _d.contentCenterX;
_cy = _d.contentCenterY;
_colors = {
    black = {0, 0, 0},
    white = {1, 1, 1},
    red = {1, 0, 0},
    green = {0, 1, 0},
    orange = {1, 0.5, 0, 1}
};
_chars = {
    empty = 0,
    x = 1,
    o = -1
};
_x = "x";
_o = "o";
_event = "touch";
_logMode = "info";