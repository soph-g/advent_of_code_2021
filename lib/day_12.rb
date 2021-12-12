require 'set'

input = File
  .open('inputs/12/day_12.txt')
  .readlines
  .map(&:chomp)

input.map! { |line| line.split('-') }

def build_graph(input)
  graph = Hash.new { |h,k| h[k] = Array.new }

  input.each do |edge|
    graph[edge[0]] << edge[1]

    next if edge[0] == 'start' || edge[1] == 'end'

    graph[edge[1]] << edge[0]

  end

  graph
end

graph = build_graph(input)

def find_route(graph, node, routes, route = [], visited = Hash.new(false))
  return if visited[node]

  route << node
  visited[node] = true if node.downcase == node

  routes << route if node == 'end'

  graph[node].each do |n|
    find_route(graph, n, routes, route.dup, visited.dup)
  end
end

def find_routes(graph, start, end_node)
  routes = []

  find_route(graph, start, routes)

  routes
end

p 'Part 1'
p find_routes(graph, 'start', 'end').size

p 'Part 2'

def find_route(graph, node, routes, visit_twice, route = [], visited = Hash.new(0))
  if node.downcase == node
    return if visited[node] == 1 && visit_twice != node
    return if visited[node] == 2 && visit_twice == node

    visited[node] += 1
  end

  route << node
  routes.add(route) if node == 'end'

  graph[node].each do |n|
    find_route(graph, n, routes, visit_twice, route.dup, visited.dup)
  end
end

def find_routes(graph, start, end_node)
  routes = Set.new
  small_caves = graph.keys.select do |node|
    node.downcase == node && node != start && node != end_node
  end

  small_caves.each do |sc|
    find_route(graph, start, routes, sc)
  end

  routes.to_a
end

p find_routes(graph, 'start', 'end').size
