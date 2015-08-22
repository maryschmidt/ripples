class WelcomeController < ApplicationController
  def index
    data = Participant.cluster_champs_by_build
    @test_variable_1 = data[0]
    @test_variable_2 = data[1]
    @test_variable_3 = data[2]
    @test_variable_4 = data[3]
  end
end
