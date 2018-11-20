defmodule PersonnummerTest do
  use ExUnit.Case
  doctest Personnummer

  test "test strings" do
    assert Personnummer.valid?("510818-9167") == true
    assert Personnummer.valid?("19900101-0017") == true
    assert Personnummer.valid?("19130401+2931") == true
    assert Personnummer.valid?("196408233234") == true
    assert Personnummer.valid?("0001010107") == true
    assert Personnummer.valid?("000101-0107") == true
    assert Personnummer.valid?("640327-381") == false
    assert Personnummer.valid?("510818-916") == false
    assert Personnummer.valid?("19900101-001") == false
    assert Personnummer.valid?("100101+001") == false
  end

  test "test ints" do
    assert Personnummer.valid?(6403273813) == true
    assert Personnummer.valid?(5108189167) == true
    assert Personnummer.valid?(199001010017) == true
    assert Personnummer.valid?(640327381) == false
    assert Personnummer.valid?(510818916) == false
    assert Personnummer.valid?(19900101001) == false
    assert Personnummer.valid?(100101001) == false
  end
end
