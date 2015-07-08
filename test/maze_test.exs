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
end
