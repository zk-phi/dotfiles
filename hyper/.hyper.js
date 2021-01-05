// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

const BLACK   = "#192129"; /* bg */
const WHITE   = "#79828c"; /* fg */
const BLUE    = "#729fcf"; /* accent 1 */
const CYAN    = "#c4dde8"; /* accent 2 */
const YELLOW  = "#e9b96e"; /* accent 3 */
const RED     = "#ff8683";
const GREEN   = "#649d8a";
const MAGENTA = "#fe5450";
const NAV     = "rgba(128, 128, 128, 0.15)";
const REGION  = WHITE < BLACK ? "rgba(0, 0, 0, 0.3)" : "rgba(255, 255, 255, 0.3)";
const NAVFG   = WHITE < BLACK ? "#000" : "#fff";

const CSS = `
nav {
  background-color: ${NAV};
}
.tab_tab {
  color: ${NAVFG};
  border none;
  border-left: 1px solid ${BLACK} !important;
}
.tab_active {
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
