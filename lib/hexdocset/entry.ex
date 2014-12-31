defmodule Hexdocset.Entry do
  def parse(html, type) do
    html
    |> Floki.find("#full_list")
    |> Floki.find("a")
    |> parse_entries(type, [])
  end

  defp parse_entries([{"a", [{"href", path}, {"title", _}], [name]} | tail], type, enties) do
    enties = [%{name: name, type: type, path: path} | enties]
    parse_entries(tail, type, enties)
  end

  defp parse_entries([{"a", [{"href", path}], [name]} | tail], type, enties) do
    enties = [%{name: name, type: "Function", path: path} | enties]
    parse_entries(tail, type, enties)
  end

  defp parse_entries([{"a", [{"class", "toggle"}], []} | tail], type, enties) do
    parse_entries(tail, type, enties)
  end

  defp parse_entries([], type, enties) do
    enties
  end
end
