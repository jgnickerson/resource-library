'use strict'

describe 'Controller: DocControllerCtrl', ->

  # load the controller's module
  beforeEach module 'resourceLibraryApp'

  DocControllerCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    DocControllerCtrl = $controller 'DocControllerCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(DocControllerCtrl.awesomeThings.length).toBe 3
