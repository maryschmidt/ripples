$(document).ready(Sunburst());

function Sunburst() {
  var datasets = {
    all_511: function() { return Ripples.clusters511All(); },
    all_514: function() { return Ripples.clusters514All(); },
    na_511: function() { return Ripples.clusters511Na(); },
    na_514: function() { return Ripples.clusters514Na(); },
    euw_511: function() { return Ripples.clusters511Euw(); },
    euw_514: function() { return Ripples.clusters514Euw(); },
    kr_511: function() { return Ripples.clusters511Kr(); },
    kr_514: function() { return Ripples.clusters514Kr(); }
  };

  $('select.scale').on('input', function (e) { changeScaling(e.currentTarget.selectedOptions[0].dataset.slice); });

  $('select.data').on('input', function (e) {
    set = $('select.region').val() + '_' + $('select.data').val();
    changeData(datasets[set]());
  });

  $('select.region').on('input', function(e) {
    set = $('select.region').val() + '_' + $('select.data').val();
    changeData(datasets[set]());
  });

  var root = datasets.all_514();

  var championImage = "http://ddragon.leagueoflegends.com/cdn/5.14.1/img/champion/";
  var itemImage = "http://ddragon.leagueoflegends.com/cdn/5.14.1/img/item/";

  var width = 700,
    height = 700,
    radius = Math.min(width, height) / 2 - 20;

  var x = d3.scale.linear()
    .range([0, 2 * Math.PI]);

  var y = d3.scale.sqrt()
    .range([0, radius]);

  var color = d3.scale.ordinal()
    .range(['#641AAC', '#9748e3', '#11b5e0', '#1CC3EE', '#0fc891', '#34f0b8', '#F6A110', '#f9be5a', '#8D1A62', '#ce268f']);

  var strokeColors = d3.scale.ordinal()
    .range(['#bd8aed', '#bd8aed', '#aae9f8', '#aae9f8', '#c2faea', '#c2faea', '#fee9d5', '#fee9d5', '#e15fb1', '#e15fb1']);

  var svg = d3.select(".data-vis").append("svg")
    .attr("width", width)
    .attr("height", height)
    .attr("viewBox", "0 0 " + Math.min(width, height) + " " + Math.min(width, height))
    .attr("preserveAspectRatio", "xMidYMid")
    .append("g")
    .attr("transform", "translate(" + (width / 2 - 0) + "," + (height / 2 + 10) + ")");

  var partition = d3.layout.partition()
    .sort(null)
    .value(function(d) { return 1; });

  var arc = d3.svg.arc()
    .startAngle(function(d) { return Math.max(0, Math.min(2 * Math.PI, x(d.x))); })
    .endAngle(function(d) { return Math.max(0, Math.min(2 * Math.PI, x(d.x + d.dx))); })
    .innerRadius(function(d) { return Math.max(0, y(d.y)); })
    .outerRadius(function(d) { return Math.max(0, y(d.y + d.dy)); });

  var tooltipDiv = d3.select(".data-vis").append("div")
    .attr("class", "tooltip sunburst hidden")
    .style("opacity", 0);

  var node = root;
  var path = svg.selectAll("path")
    .data(partition.nodes(root))
    .enter().append("path")
    .attr("opacity", 0)
    .attr("d", arc)
    .style("fill", function(d) { return color((d.children ? d : d.parent).index); })
    .style("stroke", function(d) { return strokeColors((d.children ? d: d.parent).index); })
    // .style("stroke", "#1D1C4E")
    // .style("stroke-width", 16)
    .on("click", click)
    .on("mouseover", showTooltip)
    .on("mouseout", hideTooltip)
    .each(stash);

  path.transition()
    .duration(500)
    .attr("opacity", function(d) { return d.depth ? 1 : 0; });

  function changeScaling(sizing) {
    var value = sizing  === 'count'
      ? function() { return 1; }
    : function(d) { return d.size; };

    path
      .data(partition.value(value).nodes(root))
      .transition()
      .duration(1000)
      .attrTween("d", arcTweenData);
  };

  isChanging = false;
  function changeData(dataset) {
    if (!isChanging) {

      isChanging = true;
      timing = 150;

      path
        .transition()
        .duration(timing)
        .attr("opacity", 0)
        .remove();

      root = dataset;
      node = root;

      setTimeout(function() {
        path = svg.selectAll("path")
          .data(partition.nodes(root))
          .enter().append("path")
          .attr("opacity", 0)
          .attr("d", arc)
          .style("fill", function(d) { return color((d.children ? d : d.parent).index); })
          .style("stroke", function(d) { return strokeColors((d.children ? d: d.parent).index); })
          .on("click", click)
          .on("mouseover", showTooltip)
          .on("mouseout", hideTooltip)
          .each(stash);

        path
          .transition()
          .duration(timing)
          .attr("opacity", function(d) { return d.depth ? 1 : 0; })

        isChanging = false;
      }, timing + 100);
    }

  };


  function click(d) {
    node = d;
    path.transition()
      .duration(1000)
      .attrTween("d", arcTweenZoom(d));
    updateWindow(d);
  }

  function updateWindow(d) {
    if (d.id) {
      // champion selected
      // create window html
      championInnerHtml = "<div class='champion-portrait column'></div>\
        <div class='items column'></div>"
      $('.window').html(championInnerHtml);

      // populate window html with data
      // champion portrait and name
      championPortraitHtml = "<img src=" + (championImage + d.image) + "> " + "<div class='name'>" + d.name + "</div>"
      $('.window .champion-portrait').html(championPortraitHtml)

      // champion items
      championItemHtml = "<div class='heading'>Items</div>\
        <img class='item' src=" + (itemImage + d.items[0]) + ">\
        <img class='item' src=" + (itemImage + d.items[1]) + ">\
        <img class='item' src=" + (itemImage + d.items[2]) + ">\
        <img class='item' src=" + (itemImage + d.items[3]) + ">\
        <img class='item' src=" + (itemImage + d.items[4]) + ">\
        <img class='item' src=" + (itemImage + d.items[5]) + ">"
      $('.window .items').html(championItemHtml)

    } else {
      // cluster selected
      clusterInnerHtml = "<div class='items cluster column'></div>"
      $('.window').html(clusterInnerHtml);

      clusterItemHtml = "<div class='heading'>Cluster Items</div>\
        <img class='item' src=" + (itemImage + d.items[0]) + ">\
        <img class='item' src=" + (itemImage + d.items[1]) + ">\
        <img class='item' src=" + (itemImage + d.items[2]) + ">\
        <img class='item' src=" + (itemImage + d.items[3]) + ">\
        <img class='item' src=" + (itemImage + d.items[4]) + ">\
        <img class='item' src=" + (itemImage + d.items[5]) + ">"
      $('.window .items').html(clusterItemHtml)
    }
  }

  function showTooltip(d) {
    tooltipDiv.transition()
      .duration(200)
      .style("opacity", 0.9);
    tooltipDiv.html( d.depth ? ((d.id ? ("<img src=" + (championImage + d.image) + "> " + d.name) : ("<img class='item' src=" + (itemImage + d.items[0]) + "> <img class='item' src=" + (itemImage + d.items[1]) + "> <img class='item' src=" + (itemImage + d.items[2]) + "> <img class='item' src=" + (itemImage + d.items[3]) + ">"))) : ("Yo."))
      .classed("hidden", false)
      .style("left", (d3.event.pageX) + "px")
      .style("top", (d3.event.pageY - 28) + "px");
  }

  function hideTooltip(d) {
    tooltipDiv.transition()
      .duration(500)
      .style("opacity", 0)
      .each("end", function() { tooltipDiv.classed("hidden", true); });
  }

  d3.select(self.frameElement).style("height", height + "px");

  // Setup for switching data: stash the old values for transition.
  function stash(d) {
    d.x0 = d.x;
    d.dx0 = d.dx;
  }

  // When switching data: interpolate the arcs in data space.
  function arcTweenData(a, i) {
    var oi = d3.interpolate({x: a.x0, dx: a.dx0}, a);
    function tween(t) {
      var b = oi(t);
      a.x0 = b.x;
      a.dx0 = b.dx;
      return arc(b);
    }
    if (i == 0) {
      // If we are on the first arc, adjust the x domain to match the root node
      // at the current zoom level. (We only need to do this once.)
      var xd = d3.interpolate(x.domain(), [node.x, node.x + node.dx]);
      return function(t) {
        x.domain(xd(t));
        return tween(t);
      };
    } else {
      return tween;
    }
  }

  // When zooming: interpolate the scales.
  function arcTweenZoom(d) {
    var xd = d3.interpolate(x.domain(), [d.x, d.x + d.dx]),
    yd = d3.interpolate(y.domain(), [d.y, 1]),
    yr = d3.interpolate(y.range(), [d.y ? 20 : 0, radius]);
    return function(d, i) {
      return i
        ? function(t) { return arc(d); }
      : function(t) { x.domain(xd(t)); y.domain(yd(t)).range(yr(t)); return arc(d); };
    };
  }

}
