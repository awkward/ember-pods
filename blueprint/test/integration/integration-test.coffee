describe "Integration test:", ->
  beforeEach ->
    App.reset()

  describe "The first test", ->
    it "should pass", (done) ->
      visit "/"
      andThen ->
        expect($("body")).to.have.length 1
        done()
