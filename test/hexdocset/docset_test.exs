defmodule Hexdocset.DocsetTest do
  use ExUnit.Case

  import Hexdocset.Docset

  test "create_folder_structure" do
    docset = %Hexdocset.Docset{
      name: "Hexdocset",
      distination_path: Path.expand("../../tmp", __DIR__)
    }
    create_folder_structure(docset)
    assert File.exists?(docset.distination_path)
  end

  test "copy_files" do
    dummy_source_folder = Path.join([Path.expand("../../tmp", __DIR__), "dummy_source"])
    dummy_distination_folder =  Path.join([Path.expand("../../tmp", __DIR__), "dummy_distination"])

    File.mkdir_p!(Path.join([dummy_source_folder, "dummy_folder"]))
    File.touch!(Path.join([dummy_source_folder, "dummy_file"]))
    File.mkdir_p!(dummy_distination_folder)

    copy_files(%Hexdocset.Docset{source_path: dummy_source_folder, documents_path: dummy_distination_folder})

    assert File.exists?(Path.join([dummy_distination_folder, "dummy_folder"]))
    assert File.exists?(Path.join([dummy_distination_folder, "dummy_file"]))
  end

  test "create_plist" do
    docset_path = Path.join([Path.expand("../../tmp", __DIR__), ])
    create_plist(%Hexdocset.Docset{name: "Hexdocset",docset_path: docset_path})

    assert File.exists?(Path.join([docset_path, 'Info.plist']))
  end
end
