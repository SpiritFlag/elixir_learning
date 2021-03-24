defmodule Test do
  def main do
    n_process = 100
    min_num = 0
    max_num = 10000

    spawn(AddRange, :main, [self(), n_process, min_num, max_num])

    receive do
      {:total, tot} -> tot
      IO.puts "result= " <> to_string(tot)
    end
  end
end
