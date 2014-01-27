'use strict'

angular.module('twimpressApp')
  .filter 'entities', ['$sce', ($sce) ->
    (input, entities) ->

      index_map = {}

      if entities?.urls then for entry in entities.urls
        index_map[entry.indices[0]] = [entry.indices[1], "<a href='#{entry.expanded_url}'>#{entry.url}</a>"]

      if entities?.hashtags then for entry in entities.hashtags
        index_map[entry.indices[0]] = [entry.indices[1], "<a href='http://twitter.com/search?q=##{encodeURI entry.text}'>##{entry.text}</a>"]

      if entities?.user_mentions then for entry in entities.user_mentions
        index_map[entry.indices[0]] = [entry.indices[1], "<a href='http://twitter.com/#{entry.screen_name}'>@#{entry.screen_name}</a>"]

      result = ""
      i = 0

      while i < input.length
        ind = index_map[i]
        if ind
          result += ind[1]
          i = ind[0]
        else
          result += input[i]
          i++

      $sce.trustAsHtml result
  ]