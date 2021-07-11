defmodule Cell do
  use GenServer

  defmodule State do
    defstruct status: :alive, neighbours: [], name: "unnamed"
  end

  @impl true
  def init(state) when is_struct(state, State) do
    {:ok, state}
  end

  @impl true
  def handle_call(message, _from, state) do
    case message do
      :current_state ->
        IO.puts("Received current_state command")
        {:reply, state, state}

      :current_and_next_states ->
        IO.puts("Received current_and_next_states command")
        {:reply, {state, state}, state}

      :resurrect ->
        IO.puts("Received mutate_to alive")
        {:reply, :ok, %{state | status: :alive}}

      :die ->
        IO.puts("Received mutate_to dead")
        {:reply, :ok, %{state | status: :dead}}

      {:set_neighbours, new_neighbours} ->
        IO.puts("Received set_neighbours")
        {:reply, :ok, %{state | neighbours: new_neighbours}}

      _ ->
        {:reply, "Unknown command!", state}
    end
  end
end
