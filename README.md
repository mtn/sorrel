# sorrel

Sorrel is a full-featured lisp interpreter based on [mal](https://github.com/kanaka/mal).

Everything is immutable, and integer, boolean, list, and hash-maps are built in. Builtin functions are mostly implemented in ruby in `src/core.rb`, though a few functions are defined in sorrel itself in `src/lib/core.srl` and loaded when the interpreter starts.

## Usage

To run the interpreter:

    ./sorrel

To run in batch mode:

    ./sorrel filename

## License

See [LICENSE](LICENSE)
