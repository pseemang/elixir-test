defmodule Issues.CLI do
    @default_count 4

    @moduledoc """
    Handle the command line parcing and the dispatch to the various functions tht end up gnerating a atable of the last _n_ issues in a github project
    """

    @doc """
    More stuff to come
    """

    def run(argv) do
        IO.puts "Program running"

        argv 
        |> parse_args
        |> process
    end

    def parse_args(argv) do
        parse = OptionParser.parse(argv, switches: [help: :boolean],
                                         aliases: [h: :help])

        case parse do
            {[help: true], _, _} -> :help
            {_, [user, project, count], _} -> {user, project, String.to_integer(count)}
            {_, [user, project], _} -> {user, project, @default_count}
            _ -> :help
        end
    end

    def process(:help) do
        IO.puts """
        usage: issues <user> <project> [ count | #{@default_count}]
        """

        System.halt(0)
    end

    def process({user, project, _count}) do
        Issues.GithubIssues.fetch(user, project)
        |> decode_response
        |> convert_to_list_of_maps
    end

    def sort_into_ascending_order(list_of_issues) do
        Enum.sort list_of_issues,
                  fn i1, i2 -> i1["created_at"] <= i2["created_at"]
    end
end