defmodule Universe do
  use Supervisor

  @rows 2
  @columns 2

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = create_universe()

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp try_get_neighbour(matrix, row, col) do
    try do
      elem(elem(matrix, row), col)
    rescue
      ArgumentError -> :nil
    end
  end

  def create_universe() do
#    matrix =
#      for r <- 0..(@rows - 1) do
#        (
#          for c <- 0..(@columns - 1),
#              do: elem(GenServer.start_link(Cell, %Cell.State{status: alive?()}), 1))
#        |> List.to_tuple()
#      end
#      |> List.to_tuple()
#
#    for row <- 0..(rows - 1) do
#      for col <- 0..(columns - 1) do
#        neighbors =
#          [
#            try_get_neighbour(matrix, row - 1, col + 1),
#            try_get_neighbour(matrix, row - 1, col - 1),
#            try_get_neighbour(matrix, row, col - 1),
#            try_get_neighbour(matrix, row, col + 1),
#            try_get_neighbour(matrix, row + 1, col + 1),
#            try_get_neighbour(matrix, row + 1, col - 1),
#            try_get_neighbour(matrix, row - 1, col),
#            try_get_neighbour(matrix, row + 1, col)
#          ]
#          |> Enum.filter(&(&1 != :nil))
#        GenServer.call(elem(elem(matrix, row), col), {:set_neighbours, neighbors})
##        GenServer.call(elem(elem(matrix, row), col), :current_state)
#      end
#    end

    for r <- 0..(@rows - 1), c <- 0..(@columns - 1), do: {Cell, id: String.to_atom("cell-#{r}-#{c}")}
  end

end
