defmodule Hexdocset.CLI do
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases:  [ h:    :help   ])
    case  parse  do
      { [ help: true ], _,           _ } -> :help
      { _, [ name, source, distination ],        _ } -> { name, source, distination }
      _                                  -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: hexdocset <name> <source> <distination>
    """
    System.halt(0)
  end

  def process({name, source, distination}) do
    %Hexdocset.Docset{name: name, source_path: source, distination_path: distination}
    |> Hexdocset.Docset.create
  end
end
