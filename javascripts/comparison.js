$(document).ready(CheckAChamp());

function CheckAChamp() {

  var champDiffs = Ripples.champDiffs();
  var champCount = champDiffs.length;

  var championImage = "http://ddragon.leagueoflegends.com/cdn/5.14.1/img/champion/";
  var itemImage = "http://ddragon.leagueoflegends.com/cdn/5.14.1/img/item/";

  $('select.champion').on('input', function(e) {
    updateComparison($('select.champion').val());
  });

  function updateComparison(newName) {

    for (var i=0; i < champCount; i++) {
      if (champDiffs[i].name == newName) {
        $('.champion-portrait img').attr('src', championImage + champDiffs[i].image);
        $('.items-before').html('<img src=' + itemImage + champDiffs[i].items1[0] + '> ' +
            '<img src=' + itemImage + champDiffs[i].items1[1] + '> ' +
            '<img src=' + itemImage + champDiffs[i].items1[2] + '> ' +
            '<img src=' + itemImage + champDiffs[i].items1[3] + '> ' +
            '<img src=' + itemImage + champDiffs[i].items1[4] + '> ' +
            '<img src=' + itemImage + champDiffs[i].items1[5] + '> ');
        $('.items-after').html('<img src=' + itemImage + champDiffs[i].items2[0] + '> ' +
            '<img src=' + itemImage + champDiffs[i].items2[1] + '> ' +
            '<img src=' + itemImage + champDiffs[i].items2[2] + '> ' +
            '<img src=' + itemImage + champDiffs[i].items2[3] + '> ' +
            '<img src=' + itemImage + champDiffs[i].items2[4] + '> ' +
            '<img src=' + itemImage + champDiffs[i].items2[5] + '> ');

        diffvalue = champDiffs[i].delta / Math.sqrt(2);
        diffvalue = diffvalue * 100;
        diffvalue = diffvalue.toFixed(2);
        $('.diff').text(diffvalue + '% Different');

        break;
      }
    }

  }

  updateComparison($('select.champion').val());

}
