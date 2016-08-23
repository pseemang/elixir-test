defmodule Issues.CLI do
    @default_count 4

    @moduledoc """
    Handle the command line parcing and the dispatch to the various functions tht end up gnerating a atable of the last _n_ issues in a github project
    """

    @doc """
    More stuff to come
    """

    def run(argv) do
        parse_args(argv)
    end

    def parse_args(argv) do
        parse = OptionParser.parse(argv, switches: [help: :boolean],
                                         aliases: [h: :help])

        case parse do
            {[help: true], _, _} -> :help
            {_, [user, project, count], _} -> {user, project, count}
            {_, [user, project], _} -> {user, project, @default_count}
            _ -> :help
        end
    end
end