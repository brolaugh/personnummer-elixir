defmodule PersonnummerTest do
  use ExUnit.Case
  doctest Personnummer

  test "test valid strings" do
    assert Personnummer.valid?("510818-9167") == true
    assert Personnummer.valid?("19900101-0017") == true
    assert Personnummer.valid?("19130401+2931") == true
    assert Personnummer.valid?("196408233234") == true
    assert Personnummer.valid?("0001010107") == true
  end
  test "test invalid strings" do
    assert Personnummer.valid?("000101-0107") == true
    assert Personnummer.valid?("640327-381") == false
    assert Personnummer.valid?("510818-916") == false
    assert Personnummer.valid?("19900101-001") == false
    assert Personnummer.valid?("100101+001") == false
  end

  test "test valid ints" do
    assert Personnummer.valid?(6403273813) == true
    assert Personnummer.valid?(5108189167) == true
    assert Personnummer.valid?(199001010017) == true
  end
  test "test invalid ints" do
    assert Personnummer.valid?(640327381) == false
    assert Personnummer.valid?(510818916) == false
    assert Personnummer.valid?(19900101001) == false
    assert Personnummer.valid?(100101001) == false
  end

  test "test valid coordination strings" do
    assert Personnummer.valid?("701063-2391") == true
    assert Personnummer.valid?("640883-3231") == true
  end
  test "test invalid coordination strings" do
    assert Personnummer.valid?("900161-0017") == false
    assert Personnummer.valid?("640893-3231") == false
  end

  test "test valid coordination ints" do
    assert Personnummer.valid?(7010632391) == true
    assert Personnummer.valid?(6408833231) == true
  end
  test "test invalid coordination ints" do

    assert Personnummer.valid?(9001610017) == false
    assert Personnummer.valid?(6408933231) == false
  end

  test "test invalid types" do
    assert Personnummer.valid?(nil) == false
    assert Personnummer.valid?([]) == false
    assert Personnummer.valid?({}) == false
    assert Personnummer.valid?(%{}) == false
    assert Personnummer.valid?(false) == false
    assert Personnummer.valid?(true) == false
    assert Personnummer.valid?("Just a string") == false
    assert Personnummer.valid?('510818+9167') == false
    assert Personnummer.valid?('510818-9167') == false
    assert Personnummer.valid?('5108189167') == false
    assert Personnummer.valid?(:atom) == false
    assert Personnummer.valid?(:"510818+9167") == false
    assert Personnummer.valid?(:"510818-9167") == false
    assert Personnummer.valid?(:"5108189167") == false

  end
end
