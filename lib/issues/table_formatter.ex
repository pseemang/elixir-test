defmodule Issues.TableFormatter do
    import Enum, only: [each: 2, map: 2, map_join: 3, max: 1]

    def print_table_for_columns(rows, headers) do
        # with data_by_colums = split_into_colums(rows, headers),
        #      column_widths  = widths_of(data_by_columns),
        #      format = format_for(column_widths)
        # do
        #     puts_on_line_in_columns(headers, format)
        #     IO.puts(separator(colum_widths))
        #     puts_in_columns(data_by_columns, format)
        # end
    end


end