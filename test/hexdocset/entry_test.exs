defmodule Hexdocset.EntryTest do
  use ExUnit.Case

  import Hexdocset.Entry

  test "parse" do
    html = """
    <ul id="full_list">
      <li class="r1" style="padding-left: 25px;">
        <a class="toggle"></a>
        <span class="object_link">
          <a href="Mix.Tasks.Phoenix.html" title="Mix.Tasks.Phoenix">Mix.Tasks.Phoenix</a>
        </span>
        <small class="search_info">Mix.Tasks.Phoenix</small>
      </li>
      <ul class="collapsed">
        <li>
          <span class="object_link">
            <a href="Mix.Tasks.Phoenix.html#run/1">run/1</a>
          </span>
          <small class="search_info">Mix.Tasks.Phoenix</small>
        </li>
      </ul>
    </ul>
    """

    assert parse(html, "Module") == [
      %{ name: "run/1", type: "Function", path: "Mix.Tasks.Phoenix.html#run/1" },
      %{ name: "Mix.Tasks.Phoenix", type: "Module", path: "Mix.Tasks.Phoenix.html" }
    ]
  end
end
