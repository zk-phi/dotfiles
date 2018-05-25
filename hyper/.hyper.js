// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    updateChannel: 'canary', // available: stable, canary

    // font
    fontSize: 12,
    lineHeight: 1.1,
    fontFamily: 'Monaco, Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    padding: '6px',

    // cursor
    cursorShape: 'BLOCK', // available: BEAM, UNDERLINE, BLOCK
    cursorBlink: false,

    // extra styles
    css: "",

    // shell process
    shellArgs: ['--login'],
    env: {},

    // other interface
    copyOnSelect: false,
  },

  plugins: [
    'hyper-tab-icons-plus',
    'hyper-atom-dark-transparent',
    'hyper-search',
    'hyperterm-cursor',
    'hyperlinks',
    'hyperterm-mactabs'
  ],

  keymaps: {
  }
};
