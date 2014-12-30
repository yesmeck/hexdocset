defmodule Hexdocset.Entry do
  def parse(html) do
    html
    |> Floki.find("#full_list")
    |> Floki.find("a")
    |> parse_entries([])
  end

  defp parse_entries([{"a", [{"href", path}, {"title", _}], [name]} | tail], enties) do
    enties = [%{name: name, type: "Module", path: path} | enties]
    parse_entries(tail, enties)
  end

  defp parse_entries([{"a", [{"href", path}], [name]} | tail], enties) do
    enties = [%{name: name, type: "Function", path: path} | enties]
    parse_entries(tail, enties)
  end

  defp parse_entries([{"a", [{"class", "toggle"}], []} | tail], enties) do
    parse_entries(tail, enties)
  end

  defp parse_entries([], enties) do
    enties
  end
end
