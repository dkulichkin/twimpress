'use strict'

angular.module('twimpressApp')
  .directive('columnchart', () ->
    chartConfig =
      chart:
        type: 'column'
        height: 300
        plotBackgroundColor: null
        plotBackgroundImage: null
        plotBorderWidth: 0
        plotShadow: false
      legend: false
      title:
        text: ''
      xAxis:
        type: 'category'
        categories: [
          'Delta'
          'Tetha'
          'Low Alpha'
          'High Alpha'
          'Low Beta'
          'High Beta'
          'Low Gamma'
          'High Gamma'
        ]
      series:[
        data: [
          { name: 'Delta', color: '#DC143C', y: 0 }
          { name: 'Tetha', color: '#FFA500', y: 0 }
          { name: 'Low Alpha', color: '#FFFF00', y: 0 }
          { name: 'High Alpha', color: '#32CD32', y: 0 }
          { name: 'Low Beta', color: '#00CED1', y: 0 }
          { name: 'High Beta', color: '#0000CD', y: 0 }
          { name: 'Low Gamma', color: '#4B0082', y: 0 }
          { name: 'High Gamma', color: '#9400D3', y: 0 }
        ]
      ]

    return {
      restrict: 'E',
      scope:
        delta: '='
        theta: '='
        lowAlpha: '='
        highAlpha: '='
        lowBeta: '='
        highBeta: '='
        lowGamma: '='
        highGamma: '='

      link: (scope, element, attrs) ->
        config = $.extend true, {}, chartConfig
        config.chart.renderTo = element[0]
        config.title.text = attrs.title
        config.chart.width = element.parent().width()
        config.chart.height = attrs.height || config.chart.height
        chart = new Highcharts.Chart config

        scope.$watch () ->
          chart.series[0].points[0].update scope.delta, false
          chart.series[0].points[1].update scope.theta, false
          chart.series[0].points[2].update scope.lowAlpha, false
          chart.series[0].points[3].update scope.highAlpha, false
          chart.series[0].points[4].update scope.lowBeta, false
          chart.series[0].points[5].update scope.highBeta, false
          chart.series[0].points[6].update scope.lowGamma, false
          chart.series[0].points[7].update scope.highGamma, false

          chart.redraw()

    }
  )
