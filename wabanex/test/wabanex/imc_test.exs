defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, returns data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)
      expected_response =
        {:ok,
          %{
            "Dani" => 23.437499999999996,
            "Diego" => 23.04002019946976,
            "Gabul" => 22.857142857142858,
            "Rafael" => 24.897060231734173,
            "Rodrigo" => 26.234567901234566
          }
        }
      assert response == expected_response
    end

    test "when the file doesnt exists, returns an error" do
      params = %{"filename" => "non_existing_filename.csv"}

      response = IMC.calculate(params)
      expected_response = {:error, "Error while opening the file"}
      assert response == expected_response
    end
  end
end