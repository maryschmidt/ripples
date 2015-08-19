class WelcomeController < ApplicationController
  def index
    @test_variable_1 = Participant.test_class_count
    @test_variable_2 = Match.test_class_count
  end
end
