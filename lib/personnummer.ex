defmodule Personnummer do
  @moduledoc """
  Documentation for Personnummer.
  """

  @spec valid_date_part?(integer(), integer(), integer()) :: boolean()
  defp valid_date_part?(year, month, day) do
    {result, _} = Date.new(year, month, day)
    {result2, _} = Date.new(year, month, day - 60)
    result == :ok || result2 == :ok
  end

  @doc """
  Validate Swedish social security number.

  ## Examples

      iex> Personnummer.valid?(6403273813)
      true
      iex> Personnummer.valid?("19130401+2931")
      true

  """
  def valid?(value) when is_integer(value) == false and is_binary(value) == false do
    false
  end

  def valid?(value) when is_integer(value) do
    value
    |> to_string()
    |> valid?()
  end

  def valid?(value) when is_binary(value) do
    matches = Regex.run(~r/^(\d{2}){0,1}(\d{2})(\d{2})(\d{2})([-|+]{0,1})?(\d{3})(\d{1})$/, value)

    if(matches == nil or length(matches) < 1 or length(matches) < 7 ) do
      false
    else
      year    = Enum.at(matches, 2)
      month   = Enum.at(matches, 3)
      day     = Enum.at(matches, 4)
      num     = Enum.at(matches, 6)
      check   = Enum.at(matches, 7)

      valid = Luhn.valid?(year <> month <> day <> num <> check)

      # The regex should have filtered out any input that would cause this block to crash
      year_i = year
        |> Integer.parse()
        |> elem(0)
      month_i = month
        |> Integer.parse()
        |> elem(0)
      day_i = day
        |> Integer.parse()
        |> elem(0)

      valid and valid_date_part?(year_i, month_i, day_i)

    end
  end
end
