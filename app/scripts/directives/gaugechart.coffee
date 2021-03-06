'use strict'

angular.module('twimpressApp')
  .directive('gaugechart', () ->
    chartConfig =
      chart:
        type: 'gauge'
        plotBackgroundColor: null
        plotBackgroundImage: null
        plotBorderWidth: 0
        plotShadow: false
        height: 300
      title:
        text: ''
      pane:
        startAngle: -150
        endAngle: 150
      yAxis:
        min: 0,
        max: 100,
        tickPosition: 'outside',
        lineColor: '#933',
        lineWidth: 2,
        minorTickPosition: 'outside',
        tickColor: '#933',
        minorTickColor: '#933',
        tickLength: 5,
        minorTickLength: 5,
        labels:
          distance: 12,
          rotation: 'auto'
        offset: -20,
        endOnTick: false
      series: [
        data: []
      ]

    return {
      restrict: 'E',
      scope:
        value: '='
      link: (scope, element, attrs) ->
        config = $.extend true, {}, chartConfig
        config.chart.renderTo = element[0]
        config.title.text = attrs.title
        config.yAxis.lineColor = config.yAxis.tickColor = config.yAxis.minorTickColor = attrs.color
        config.series[0].data[0] = scope.value
        config.chart.width = element.parent().width()
        config.chart.height = attrs.height || config.chart.height
        chart = new Highcharts.Chart config
        scope.$watch 'value', (newValue) ->
          point = chart.series[0].points[0]
          point.update newValue
    }
  )
