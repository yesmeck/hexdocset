# Hexdocset

**[Dash support hexdoc offically now!](https://kapeli.com/docsets#exdoc)**

Convert hex doc to Dash.app's docset format.

## Installation

### Requirements

- sqlite3


### Direct download

Download the binary release from the [release page](https://github.com/yesmeck/hexdocset/releases).

### Build from source

```bash
git clone https://github.com/yesmeck/hexdocset.git && cd hexdocset && mix do deps.get, escript.build
```

## Usage

```bash
hexdocset <name> <source> <distination>
```

### Example

Convert Phoenix's doc

```bash
hexdocset Phoenix ./phoenix_docs .
```
