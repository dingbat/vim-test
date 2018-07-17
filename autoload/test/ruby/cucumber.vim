if !exists('g:test#ruby#gherkin#framework')
  let g:test#ruby#gherkin#framework = 'cucumber'
endif

if !exists('g:test#ruby#gherkin#file_pattern')
  let g:test#ruby#cucumber#file_pattern = '\v\.feature$'
endif

function! test#ruby#gherkin#test_file(file) abort
  if a:file =~# g:test#ruby#gherkin#file_pattern
    return !empty(glob('features/**/*.rb'))
  endif
endfunction

function! test#ruby#gherkin#build_position(type, position) abort
  if a:type ==# 'nearest'
    return [a:position['file'].':'.a:position['line']]
  elseif a:type ==# 'file'
    return [a:position['file']]
  else
    return []
  endif
endfunction

function! test#ruby#gherkin#build_args(args) abort
  let args = a:args

  if test#base#no_colors()
    let args = ['--no-color'] + args
  endif

  return args
endfunction

function! test#ruby#gherkin#executable() abort
  if !empty(glob('.zeus.sock'))
    return 'zeus ' . g:test#ruby#gherkin#framework
  elseif filereadable('./bin/' . g:test#ruby#gherkin#framework) && get(g:, 'test#ruby#use_binstubs', 1)
    return './bin/' . g:test#ruby#gherkin#framework
  elseif filereadable('Gemfile') && get(g:, 'test#ruby#bundle_exec', 1)
    return 'bundle exec ' . g:test#ruby#gherkin#framework
  else
    return g:test#ruby#gherkin#framework
  endif
endfunction
