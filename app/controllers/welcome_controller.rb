class WelcomeController < ApplicationController
  def results
    @ap_items = File.read(File.absolute_path("lib/assets/comparisons/ap_items_all.json")).html_safe
    @ap_champs = File.read(File.absolute_path("lib/assets/comparisons/ap_champs_all.json")).html_safe
    @champ_diffs = File.read(File.absolute_path("lib/assets/comparisons/champ_diffs_all.json")).html_safe
  end

  def explore
    @clusters_511_all = File.read(File.absolute_path("lib/assets/comparisons/clusters_511_all.json")).html_safe
    @clusters_514_all = File.read(File.absolute_path("lib/assets/comparisons/clusters_514_all.json")).html_safe
  end
end
