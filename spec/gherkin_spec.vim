source spec/support/helpers.vim

describe "Gherkin"

  before
    cd spec/fixtures/gherkin
  end

  after
    call Teardown()
    cd -
  end

  it "runs nearest tests"
    view +1 features/normal.feature
    TestNearest

    Expect g:test#last_command == 'cucumber features/normal.feature:1'
  end

  it "runs file tests"
    view features/normal.feature
    TestFile

    Expect g:test#last_command == 'cucumber features/normal.feature'
  end

  it "runs test suites"
    view features/normal.feature
    TestSuite

    Expect g:test#last_command == 'cucumber'
  end

  it "uses whatever gherkin framework is given"
    let g:test#ruby#gherkin#framework = 'spinach'

    view features/normal.feature
    TestSuite

    Expect g:test#last_command == 'spinach'

    unlet g:test#ruby#gherkin#framework
  end

end
