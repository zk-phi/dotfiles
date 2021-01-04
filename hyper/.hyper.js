// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

const REGION  = "rgba(253, 167, 0, 0.3)";
const WHITE   = "#7e7765";
const BLACK   = "#fafafa";
const RED     = "#f47166";
const GREEN   = "#34bd7d";
const YELLOW  = "#fda700";
const BLUE    = "#59a9d2";
const MAGENTA = "#db8d2e";
const CYAN    = "#fda700";
const NAV     = "rgba(255, 255, 255, 0.08)";

const CSS = `
nav {
  background-color: ${NAV};
}
.tab_tab {
  border none;
  border-left: 1px solid ${BLACK} !important;
}
.tab_active {
  color: ${WHITE};
  border-bottom: 1px solid ${BLUE} !important;
  transition: border 200ms;
}
`;

module.exports = {
    config: {
        updateChannel: 'canary', // available: stable, canary

        // font
        fontSize: 13,
        fontFamily: 'nasia, code8903, Monaco, Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
        padding: '6px',

        // colors
        backgroundColor:   BLACK,
        foregroundColor:   WHITE,
        selectionColor:    REGION,
        cursorColor:       WHITE,
        cursorAccentColor: BLACK,
        borderColor:       BLACK,
        colors: {
            black:   BLACK,
            red:     RED,
            green:   GREEN,
            yellow:  YELLOW,
            blue:    BLUE,
            magenta: MAGENTA,
            cyan:    CYAN,
            white:   WHITE,
            lightBlack:   BLACK,
            lightRed:     RED,
            lightGreen:   GREEN,
            lightYellow:  YELLOW,
            lightBlue:    BLUE,
            lightMagenta: MAGENTA,
            lightCyan:    CYAN,
            lightWhite:   WHITE,
        },

        // cursor
        cursorShape: 'BLOCK', // available: BEAM, UNDERLINE, BLOCK
        cursorBlink: false,

        // extra styles
        css: CSS,

        // shell process
        shell: "zsh",
        shellArgs: ['--login'],
        env: {},

        // other interface
        copyOnSelect: false
    },

    plugins: [
        'hyper-tab-icons-plus',
        'hyper-search',
        'hyperlinks'
    ],

    keymaps: {
    }
};
