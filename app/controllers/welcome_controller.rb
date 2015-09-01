class WelcomeController < ApplicationController
  def results
    @ap_items = File.read(File.absolute_path("lib/assets/comparisons/ap_items_all.json")).html_safe
    @ap_champs = File.read(File.absolute_path("lib/assets/comparisons/ap_champs_all.json")).html_safe
    @champ_diffs = File.read(File.absolute_path("lib/assets/comparisons/champ_diffs_all.json")).html_safe
  end

  def explore
    @clusters_511_all = File.read(File.absolute_path("lib/assets/comparisons/clusters_511_all.json")).html_safe
    @clusters_514_all = File.read(File.absolute_path("lib/assets/comparisons/clusters_514_all.json")).html_safe
    @clusters_511_na = File.read(File.absolute_path("lib/assets/clusters/NA_RANKED_5.11.json")).html_safe
    @clusters_514_na = File.read(File.absolute_path("lib/assets/clusters/NA_RANKED_5.14.json")).html_safe
    @clusters_511_euw = File.read(File.absolute_path("lib/assets/clusters/EUW_RANKED_5.11.json")).html_safe
    @clusters_514_euw = File.read(File.absolute_path("lib/assets/clusters/EUW_RANKED_5.14.json")).html_safe
    @clusters_511_kr = File.read(File.absolute_path("lib/assets/clusters/KR_RANKED_5.11.json")).html_safe
    @clusters_514_kr = File.read(File.absolute_path("lib/assets/clusters/KR_RANKED_5.14.json")).html_safe
  end
end
