  
inoremap <buffer> <expr> {
      \ (cpp#lexical#before_class() ? ";\<Left>" : '').lexima#expand('{', 'i')
