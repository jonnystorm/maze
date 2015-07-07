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

  def _walk(_, this_node, last_node, _, acc) when this_node == last_node do
    acc
  end
  def _walk(graph, this_node, last_node, fun, acc) do
    {next_node, new_acc} = fun.(%{
      this_node: this_node,
      adjacent_to: graph[this_node],
      target_node: last_node
    }, acc)

    _walk(graph, next_node, last_node, fun, new_acc)
  end

  def walk(graph, first_node, target_node, fun) do
    unless first_node in Map.keys(graph) && target_node in Map.keys(graph) do
      raise ArgumentError, message: "nodes must lie on the given graph"
    end

    _walk(graph, first_node, target_node, fun, %{})
  end
end
