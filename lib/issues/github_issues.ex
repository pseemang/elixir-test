defmodule Issues.GithubIssues do
    @user_agent [{"User-agent", "Elixir dave@pragprog.com"}]
    @github_url Application.get_env(:issues, :github_url)

    def fetch(user, project) do
        issues_url(user, project)
        |> HTTPoison.get(@user_agent)
        |> handle_response
    end

    def issues_url(user, project) do
        "#{@github_url}/repos/#{user}/#{project}/issues"
    end

    def handle_response({:ok, %{status_code: 200, body: body}}) do
        {:ok, Poison.Parser.parse!(body)}
    end

    def handle_response({_, %{status_code: _, body: body}}) do
        {:error, Poison.Parser.parse!(body)}
    end

    def decode_response({:ok, body}) do
        body
    end

    def decode_response({:error, error}) do
        {_, message} = List.keyfind(error, "message", 0)
        IO.puts "Error fetching from Github: #{message}"
        System.halt(2)
    end

    def convert_to_list_of_maps(list) do
        list
        |> Enum.map(&Enum.into(&1, Map.new))
    end
end