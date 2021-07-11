defmodule Universe do

  defp alive?() do
    if Enum.random(0..9) < 3, do: :alive, else: :dead
  end

  defp try_get_neighbour(matrix, row, col) do
    try do
      elem(elem(matrix, row), col)
    rescue
      ArgumentError -> :nil
    end
  end

  def create_universe(rows, columns) do
    matrix =
      for r <- 0..(rows - 1) do
        (
          for c <- 0..(columns - 1),
              do: elem(GenServer.start_link(Cell, %Cell.State{status: alive?(), name: "cell-#{r}-#{c}"}), 1))
        |> List.to_tuple()
      end
      |> List.to_tuple()

    for row <- 0..(rows - 1) do
      for col <- 0..(columns - 1) do
        neighbors =
          [
            try_get_neighbour(matrix, row - 1, col + 1),
            try_get_neighbour(matrix, row - 1, col - 1),
            try_get_neighbour(matrix, row, col - 1),
            try_get_neighbour(matrix, row, col + 1),
            try_get_neighbour(matrix, row + 1, col + 1),
            try_get_neighbour(matrix, row + 1, col - 1),
            try_get_neighbour(matrix, row - 1, col),
            try_get_neighbour(matrix, row + 1, col)
          ]
          |> Enum.filter(&(&1 != :nil))
        GenServer.call(elem(elem(matrix, row), col), {:set_neighbours, neighbors})
        GenServer.call(elem(elem(matrix, row), col), :current_state)
      end
    end

  end

end
