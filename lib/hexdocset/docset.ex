defmodule Hexdocset.Docset do
  defstruct name: "",
            source_path: "",
            distination_path: "",
            docset_path: "",
            documents_path: ""

  def create(docset) do
    create_folder_structure(docset)
    |> copy_files
    |> create_plist
    |> create_sqlite_index
  end

  def create_folder_structure(docset = %Hexdocset.Docset{name: name, distination_path: distination_path}) do
    docset_path = Path.join([distination_path, "#{name}.docset"])
    documents_path = Path.join([docset_path, "Contents", "Resources", "Documents"])
    File.mkdir_p!(documents_path)
    docset = %Hexdocset.Docset{ docset | docset_path: docset_path }
    %Hexdocset.Docset{ docset | documents_path:  documents_path}
  end

  def copy_files(docset = %Hexdocset.Docset{source_path: source_path, documents_path: documents_path}) do
    File.cp_r!(source_path, documents_path)
    docset
  end

  def create_plist(docset = %Hexdocset.Docset{name: name, docset_path: docset_path}) do
    plist = Path.join([docset_path, 'Contents', 'Info.plist'])
    content = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>CFBundleIdentifier</key>
      <string>#{String.downcase(name)}</string>
      <key>CFBundleName</key>
      <string>#{name}</string>
      <key>DocSetPlatformFamily</key>
      <string>#{String.downcase(name)}</string>
      <key>isDashDocset</key>
      <true/>
      <key>dashIndexFilePath</key>
      <string>overview.html</string>
    </dict>
    </plist>
    """
    File.write!(plist, content)
    docset
  end

  def create_sqlite_index(%Hexdocset.Docset{docset_path: docset_path, documents_path: documents_path}) do
    db = Path.join([docset_path, "Contents", "Resources", "docSet.dsidx"])
    Hexdocset.SQLite.execute(db, "CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);")
    Hexdocset.SQLite.execute(db, "CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path);")
    ["modules_list.html", "records_list.html", "exceptions_list.html", "protocls_list.html"]
    |> Enum.map(fn(file) -> Path.join([documents_path, file]) end)
    |> read_enties([])
    |> Enum.each fn(entry) ->
      Hexdocset.SQLite.execute(db, "INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES ('#{entry[:name]}', '#{entry[:type]}', '#{entry[:path]}');")
    end
  end

  def read_enties([file | tail], enties) do
    if File.exists?(file) do
      enties = enties ++ (File.read!(file) |> Hexdocset.Entry.parse)
    end
    read_enties(tail, enties)
  end

  def read_enties([], enties) do
    enties
  end
end

