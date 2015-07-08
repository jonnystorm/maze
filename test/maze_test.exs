defmodule MazeTest do
  use Amrita.Sweet

  fact "function with complete knowledge succeeds" do
    Maze.generate
    |> Maze.walk(35, 0, fn(state, acc) ->
      case state.this_node do
        35 ->
          {3, acc}
        3 ->
          {67, acc}
        67 ->
          {65, acc}
        65 ->
          {1, acc}
        1 ->
          {0, acc}
      end
    end)
    |> %{path: [35, 3, 67, 65, 1]}
  end

  fact "random walk eventually succeeds" do
    Maze.generate
    |> Maze.walk(35, 0, fn(state, %{}) ->
      random_index = (length(state.adjacent_to) |> :random.uniform) - 1

      next_node = state.adjacent_to
      |> Enum.drop(random_index)
      |> List.first

      {next_node, %{}}
    end)
  end
end
