defmodule AddRange do
  def main(recv, n_process, min_num, max_num) do
    # Consider only if (max_num - min_num) is a multiple of (n_process).
    size_window = trunc((max_num - min_num) / n_process)

    Enum.each(1..n_process, fn(i) -> spawn(AddRange, :subprocess, [self(), min_num, size_window, i]) end)

    # for i <- 1..n_process do
    #   min = min_num + (i - 1) * size_window + 1
    #   max = min_num + i * size_window
    #   spawn(AddRange, :subprocess, [self(), min, max])
    # end

    tot = for _i <- 1..n_process do
      receive do
        {:value, val} -> val
      end
    end |> Enum.sum

    send recv, {:total, tot}
  end

  def subprocess(recv, min_num, size_window, i) do
    min = min_num + (i - 1) * size_window + 1
    max = min_num + i * size_window
    send recv, {:value, Enum.sum(min..max)}
  end
end
