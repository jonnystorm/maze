Maze
====
Navigate a numbered graph by providing a function


```
iex> maze = Maze.generate
%{0 => [1], 1 => [0, 65], 2 => [3], 3 => [67, 35, 2], 35 => [3], 65 => [1, 67], 67 => [65, 3]}

iex> Maze.walk(graph, 35, 0, fn(state, %{}) ->
  random_index = (length(state.adjacent_to) |> :random.uniform) - 1

  next_node = state.adjacent_to
  |> Enum.drop(random_index)
  |> List.first

  {next_node, %{}}
end)
%{path: [35, 3, 2, 3, 35, 3, 35, 3, 2, 3, 35, 3, 67, 3, 67, 3, 67, 65, 1]}
```

