/**
 * Created by kseniamahorkina on 17.01.16.
 */

//$.getScript('//d3js.org/topojson.v1.min.js', function(){
//
//});

document.addEventListener('DOMContentLoaded', function() {
    var $ = jQuery;
    if ($('#podcastMap').length>0){
        var podcastMap = $('#podcastMap');
        var object = {};
        object = $.extend(object, {
            episode_id: +podcastMap.data('id'),
            time_period: podcastMap.data('time')
        });
        var getDataByType = function(object){
            var dfd = $.Deferred();
            $.ajax({
                type: "POST",
                dataType: 'JSON',
                url: '/stat',
                data: object,
                success:function(res){
                    return dfd.resolve(res);
                }
            });
            return dfd.promise();
        };
        getDataByType(object).then(function(places){

            var width = 760,
                height = 480;

            var projection = d3.geo.mercator()
                .scale(103)
                .translate([width / 2, height / 2 + 100])
                .precision(.1);

            var path = d3.geo.path()
                .projection(projection);

            var graticule = d3.geo.graticule();

            var svg = d3.select("#podcastMap").insert("svg", ':first-child')
                .attr("width", width)
                .attr("height", height);
            var g = svg.append("g");

            g.append("path")
                .datum(graticule)
                .attr("class", "graticule")
                .attr("d", path);

            var map = {
                max_r: 12,
                min_r: 5,
                radius: function(count){
                    if (count>1000)
                        return this.max_r;
                    else{
                        var r = Math.ceil(count*this.max_r/1000);
                        return (r<this.min_r)?this.min_r:r;
                    }
                },
                tooltip: function(data){
                    return '<div class="tooltip__city">'+data.city+'</div>' +
                        '<div class="tooltip__count">Активные пользователи: '+data.sum_count+'</div>';
                }
            };

            var tooltip = d3.select('.tooltip');

            d3.json("/assets/stat/world-map.json", function(error, world) {



                if (error) throw error;
                // create map

                g.insert("path", ".graticule")
                    .datum(topojson.feature(world, world.objects.land))
                    .attr("class", "land")
                    .attr("d", path);

                g.insert("path", ".graticule")
                    .datum(topojson.mesh(world, world.objects.countries, function(a, b) { return a !== b; }))
                    .attr("class", "boundary")
                    .attr("d", path);

                /* Define the data for the circles */
                var elem = g.selectAll("g myCircleText")
                    .data(places);

                /*Create and place the "blocks" containing the circle and the text */
                var elemEnter = elem.enter()
                    .append("g")
                    .attr("transform", function(d) {
                        return "translate(" + projection([
                                d.latitude,
                                d.longitude
                            ]) + ")";
                    });

                /*Create the circle for each block */
                var circle = elemEnter.append("circle")
                    .attr("r", function(d){return map.radius(d.sum_count)} )
                    .attr("stroke","#327984")
                    .attr("fill", "#45A6B5")
                    .on("mouseenter", function(d, i){
                        var mouse = d3.mouse(svg.node()).map( function(d) { return parseInt(d); } );
                        var coords = projection([d.latitude, d.longitude]);
                        tooltip
                            .classed("visible", true)
                            .attr("style", "left:"+ (coords[0]+map.radius(d.sum_count))+"px;top:"+(coords[1]-map.radius(d.sum_count))+"px")
                            .html(map.tooltip(d));
                    })
                    .on("mouseleave", function(d){
                        tooltip
                            .classed("visible", false);
                    });
            });


            // zoom and pan
            var zoom = d3.behavior.zoom()
                .on("zoom",function() {
                    g.attr("transform","translate("+
                        d3.event.translate.join(",")+")scale("+d3.event.scale+")");
                    g.selectAll("path")
                        .attr("d", path.projection(projection));
                });

            svg.call(zoom);

            d3.select(self.frameElement).style("height", height + "px");
        });
    }
});