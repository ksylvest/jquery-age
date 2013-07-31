describe "Age", ->

  beforeEach ->
    $("body").append("<time class='age' id='test' datetime='2010-01-01T12:00:00Z'>January 1, 2010 12:00</time>")

  afterEach ->
    $("#test").remove()

  it "should use an age", ->
    $("#test").age()
    expect($('#test').text()).not.toBe('January 1, 2010 12:00')
