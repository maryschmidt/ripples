class WelcomeController < ApplicationController
  def index
    data = Participant.cluster_champs_by_build
    @test_variable_1 = data[0]
    @test_variable_2 = data[1]
    @test_variable_3 = data[2]
    @test_variable_4 = data[3]
    @test_variable_5 = data[4]
    @test_variable_6 = data[5]

    file_1 = File.absolute_path("lib/assets/clusters/NA_ranked_5.11.0.270_100.json")
    @test_json_1 = File.read(file_1).html_safe

    file_2 = File.absolute_path("lib/assets/clusters/NA_ranked_5.11.0.270_1000.json")
    @test_json_2 = File.read(file_2).html_safe
  end
end
