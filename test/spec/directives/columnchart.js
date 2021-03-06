// Generated by CoffeeScript 1.6.3
(function() {
  'use strict';
  describe('Directive: columnchart', function() {
    var scope;
    beforeEach(module('twimpressApp'));
    scope = {};
    beforeEach(inject(function($controller, $rootScope) {
      return scope = $rootScope.$new();
    }));
    return it('should make hidden element visible', inject(function($compile) {
      var element;
      element = angular.element('<columnchart></columnchart>');
      element = $compile(element)(scope);
      return expect(element.text()).toBe('this is the columnchart directive');
    }));
  });

}).call(this);

/*
//@ sourceMappingURL=columnchart.map
*/
