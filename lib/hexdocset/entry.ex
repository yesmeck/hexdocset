defmodule Hexdocset.Entry do
  def parse(html, type) do
    html
    |> Floki.find("#full_list")
    |> elem(2)
    |> parse_entries(type, [])
  end

  defp parse_entries([{ "li", _, link } | tail], type, enties) do
    link = link
        |> Floki.find("span")
        |> Floki.find("a")
        |> List.first
    name = Floki.text(link)
    path = Floki.attribute(link, "href") |> List.first
    enties = [%{name: name, type: type, path: path} | enties]
    parse_entries(tail, type, enties)
  end

  defp parse_entries([{ "ul", _, links } | tail], type, enties) do
    links = links |> Floki.find("a")
    enties = enties ++ parse_function_entries(links, [])
    parse_entries(tail, type, enties)
  end

  defp parse_entries([], _type, enties) do
    enties
  end

  defp parse_function_entries([head | tail], enties) do
    name = Floki.text(head)
    path = Floki.attribute(head, "href") |> List.first
    enties = [%{name: name, type: "Function", path: path} | enties]
    parse_function_entries(tail, enties)
  end

  defp parse_function_entries([], enties) do
    enties
  end
end
