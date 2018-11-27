defmodule Personnummer do
  @moduledoc """
  A module to make the usage of Swedish social security numbers easier.
  """
  defp valid_date_part?(year, month, day) do
    {social_security_success, _} = Date.new(year, month, day)
    {coordination_success, _} = Date.new(year, month, day - 60)
    social_security_success == :ok || coordination_success == :ok
  end

  defp fix_seperator(candidate) do
    if(String.length(candidate) != 1) do
      "-"
    else
      candidate
    end
  end

  
  def number_to_gender(number) when is_integer(number) do
    if rem(number, 2) == 1, do: :male, else: :female
  end

  defp validate_map(candidate) when is_map(candidate) do
    year = candidate.year
      |> Integer.to_string()
      |> String.pad_leading(2, "0")
    month = candidate.month
      |> Integer.to_string()
      |> String.pad_leading(2, "0")
    day =  candidate.day
      |> Integer.to_string()
      |> String.pad_leading(2, "0")
    number = candidate.number
      |> Integer.to_string()
      |> String.pad_leading(3, "0")
    check = candidate.check
      |> Integer.to_string()

    valid_luhn = year <> month <> day <> number <> check
      |> Luhn.valid?()

    cond do
      !valid_luhn ->
        :invalid_luhn
      !valid_date_part?(candidate.year, candidate.month, candidate.day) ->
        :invalid_date
      true ->
        :ok
      end
  end

  defp regex_match(value) do
    matches = Regex.run(~r/^(\d{2}){0,1}(\d{2})(\d{2})(\d{2})([-|+]{0,1})?(\d{3})(\d{1})$/, value)

    if(matches == nil or length(matches) < 7 ) do
      {:error, nil}
    else
      {:ok, matches}
    end
  end

  defp to_map(list) when is_nil(list) == false do
    %{
      #short_form = fn -> do to_string(year) <> to_string(month) <> to_string(day) <> number <> to_string(check) end
      #long_form = fn -> do to_string(year) <> to_string(month) <> to_string(day) <> seperator <> number <> to_string(check) end
      year: Enum.at(list, 2)
        |> Integer.parse()
        |> elem(0),
      month: Enum.at(list, 3)
        |> Integer.parse()
        |> elem(0),
      day: Enum.at(list, 4)
        |> Integer.parse()
        |> elem(0),
      seperator: Enum.at(list, 5)
        |> fix_seperator(),
      number: Enum.at(list, 6)
        |> Integer.parse()
        |> elem(0),
      check: Enum.at(list, 7)
        |> Integer.parse()
        |> elem(0),
      gender: Enum.at(list, 6)
        |> Integer.parse()
        |> elem(0)
        |> number_to_gender()
    }
  end
  @doc """
  Validate Swedish social security number.
  ## Examples
      iex> Personnummer.valid?(6403273813)
      true
      iex> Personnummer.valid?("19130401+2931")
      true
  """
  def valid?(value) do
    {success, _} = parse(value)
    success === :ok
  end

  def parse(value) when is_integer(value) == false and is_binary(value) == false do
    {:error, :invalid_type}
  end

  def parse(value) when is_integer(value) do
    value
      |> Integer.to_string()
      |> parse()
  end

  @doc """
  Parses a swedish social security number

  ## Examples
  iex> Personnummer.parse("510818-9167")
  {:ok, %{ check: 7, day: 18, gender: :female, month: 8, number: 916, seperator: "-", year: 51 }}
  """
  def parse(value) when is_binary(value) and is_nil(value) == false do
    {match_result, matches} = regex_match(value)

    if(match_result == :error) do
      {:error, :invalid_format}
    else
      map = to_map(matches)

      validation_result = validate_map(map)

      if(validation_result === :ok) do
        {:ok, map}
      else
        {:error, validation_result}
      end
    end
  end
end
