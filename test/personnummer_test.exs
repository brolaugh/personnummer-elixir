defmodule PersonnummerTest do
  use ExUnit.Case
  doctest Personnummer

  test "valid?/1" do
    IO.inspect Personnummer.parse("510818-9167")

    assert Personnummer.valid?("510818-9167") == true
    assert Personnummer.valid?("640327-381") == false
  end

  test "valid strings" do
    assert elem(Personnummer.parse("510818-9167"), 0) == :ok
    assert elem(Personnummer.parse("19900101-0017"), 0) == :ok
    assert elem(Personnummer.parse("19130401+2931"), 0) == :ok
    assert elem(Personnummer.parse("196408233234"), 0) == :ok
    assert elem(Personnummer.parse("0001010107"), 0) == :ok
  end

  test "invalid formated strings" do
    assert Personnummer.parse("640327-381") == {:error, :invalid_format}
    assert Personnummer.parse("510818-916") == {:error, :invalid_format}
    assert Personnummer.parse("19900101-001") == {:error, :invalid_format}
    assert Personnummer.parse("100101+001") == {:error, :invalid_format}
  end

  test "valid ints" do
    assert elem(Personnummer.parse(6403273813), 0) == :ok
    assert elem(Personnummer.parse(5108189167), 0) == :ok
    assert elem(Personnummer.parse(199001010017), 0) == :ok
  end

  test "invalid ints" do
    assert Personnummer.parse(640327381) == {:error, :invalid_format}
    assert Personnummer.parse(510818916) == {:error, :invalid_format}
    assert Personnummer.parse(19900101001) == {:error, :invalid_format}
    assert Personnummer.parse(100101001) == {:error, :invalid_format}
  end

  test "valid coordination strings" do
    assert elem(Personnummer.parse("701063-2391"), 0) == :ok
    assert elem(Personnummer.parse("640883-3231"), 0) == :ok
  end
  test "invalid coordination strings" do
    assert Personnummer.parse("900161-0017") == {:error, :invalid_luhn}
    assert Personnummer.parse("640893-3231") == {:error, :invalid_luhn}
  end

  test "valid coordination ints" do
    assert elem(Personnummer.parse(7010632391), 0) == :ok
    assert elem(Personnummer.parse(6408833231), 0) == :ok
  end
  test "invalid coordination ints" do
    assert Personnummer.parse(9001610017) == {:error, :invalid_luhn}
    assert Personnummer.parse(6408933231) == {:error, :invalid_luhn}
  end

  test "invalid types" do
    assert Personnummer.parse(nil) == {:error, :invalid_type }
    assert Personnummer.parse([]) == {:error, :invalid_type }
    assert Personnummer.parse({}) == {:error, :invalid_type }
    assert Personnummer.parse(%{}) == {:error, :invalid_type }
    assert Personnummer.parse(:error) == {:error, :invalid_type }
    assert Personnummer.parse(:ok) == {:error, :invalid_type }
    assert Personnummer.parse("Just a string") == {:error, :invalid_format }
    assert Personnummer.parse('510818+9167') == {:error, :invalid_type }
    assert Personnummer.parse('510818-9167') == {:error, :invalid_type }
    assert Personnummer.parse('5108189167') == {:error, :invalid_type }
    assert Personnummer.parse(:atom) == {:error, :invalid_type }
    assert Personnummer.parse(:"510818+9167") == {:error, :invalid_type }
    assert Personnummer.parse(:"510818-9167") == {:error, :invalid_type }
    assert Personnummer.parse(:"5108189167") == {:error, :invalid_type }
  end

  test "gender setter" do
    assert Personnummer.number_to_gender(0) == :female
    assert Personnummer.number_to_gender(1) == :male
    assert Personnummer.number_to_gender(2) == :female
    assert Personnummer.number_to_gender(3) == :male
  end
end
