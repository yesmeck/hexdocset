defmodule Hexdocset.SQLite do
  def execute(db, sql) do
    cmd = String.to_char_list("echo \"#{sql}\" | sqlite3 #{db}")
    :os.cmd(cmd)
  end
end
