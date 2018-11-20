defmodule Personnummer do
  @moduledoc """
  Documentation for Personnummer.
  """

  @doc """
  Validate Swedish social security number.

  ## Examples

      iex> Personnummer.valid?(social_security_number)
      true

  """
  def valid?(value)

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
      {full_year, _} = Enum.at(matches, 1) <> Enum.at(matches, 2)
                  |> Integer.parse()
      {year, _} = Enum.at(matches, 2)
                  |> Integer.parse()
      {month, _} = Enum.at(matches, 3) 
                  |> Integer.parse()
      {day, _} = Enum.at(matches, 4)
                  |> Integer.parse()

      {date_result, _} = Date.new(year, month, day)
      {full_date_result, _} = Date.new(full_year, month, day)

      ( date_result == :ok or full_date_result == :ok ) &&
      Enum.at(matches, 2) <> Enum.at(matches, 3) <> Enum.at(matches, 4) <> Enum.at(matches,6) <> Enum.at(matches, 7)
      |> Luhn.valid?()
    end
  end
end
