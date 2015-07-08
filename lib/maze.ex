defmodule Maze do
  @doc """
        o 0
         \
    2 o   o 1
       \   \
      3 o   o 65
       / \ /
   35 o   o 67
  """
  def generate do
    %{
      0  => [1],
      1  => [0, 65],
      65 => [1, 67],
      67 => [65, 3],
      3  => [67, 35, 2],
      35 => [3],
      2  => [3]
    }
  end

  defp calculate_state(graph, this_node, target_node, acc) do
    %{
      this_node: this_node,
      adjacent_to: graph[this_node],
      target_node: target_node,
      path: acc.path,
      loop: this_node in acc.path
    }
  end

  defp _walk(_, this_node, target_node, _, acc, _)
      when this_node == target_node do
    acc
  end
  defp _walk(graph, this_node, target_node, fun, acc, user_acc) do
    state = calculate_state(graph, this_node, target_node, acc)

    {next_node, new_user_acc} = fun.(state, user_acc)
    if state.loop do
      :timer.sleep 1000
    end
    new_acc = %{acc|path: acc.path ++ [this_node]}

    _walk(graph, next_node, target_node, fun, new_acc, new_user_acc)
  end

  def walk(graph, first_node, target_node, fun) do
    unless first_node in Map.keys(graph) && target_node in Map.keys(graph) do
      raise ArgumentError, message: "nodes must lie on the given graph"
    end

    acc = %{
      path: []
    }

    _walk(graph, first_node, target_node, fun, acc, %{})
  end
end
