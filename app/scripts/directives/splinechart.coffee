'use strict'

angular.module('twimpressApp')
  .directive('splinechart', () ->
    chartConfig =
      chart:
        type: 'spline'
        height: 300
        plotBackgroundColor: null
        plotBackgroundImage: null
        plotBorderWidth: 0
        plotShadow: false
        marginRight: 10
      legend: false
      title:
        text: ''
      xAxis:
        type: 'datetime'
        tickPixelInterval: 150
      plotOptions:
        spline:
          dataLables: false
          marker:
            enabled: false
      tooltip: false
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
        config.chart.width = element.parent().width()
        config.chart.height = attrs.height || config.chart.height
        chart = new Highcharts.Chart config
        scope.$watch 'value', (newValue) ->
          newTime = (new Date()).getTime()
          dataLength = chart.series[0].data.length
          toShift = dataLength > 100
          chart.series[0].addPoint([newTime, newValue], true, toShift);
    }
  )
