
;; Function q.op (q__op, funcdef_no=2, decl_uid=4567, cgraph_uid=0, symbol_order=0)

q.op (interfaces__integer_64[16] & l, interfaces__integer_64[16] & r)
{
  interfaces__integer_64 R.2[16];
  interfaces__integer_64 R.1[16];
  interfaces__integer_64 R.0[16];

  R.2 = p."*" (l, r); [return slot optimization]
  R.1 = p.n3 (&R.2); [return slot optimization]
  R.2 = {CLOBBER};
  goto <D.4612>;
  <D.4612>:
  R.0 = p.n2 (&R.1); [return slot optimization]
  R.1 = {CLOBBER};
  goto <D.4614>;
  <D.4614>:
  <retval> = p.n1 (&R.0); [return slot optimization]
  goto <D.4617>;
  <D.4617>:
  R.0 = {CLOBBER};
  goto <D.4611>;
  <D.4611>:
  return <retval>;
  <D.4613>:
  R.2 = {CLOBBER};
  resx 3
  <D.4615>:
  R.1 = {CLOBBER};
  resx 2
  <D.4616>:
  R.0 = {CLOBBER};
  resx 1
}



;; Function q.op2 (q__op2, funcdef_no=3, decl_uid=4570, cgraph_uid=1, symbol_order=1)

q.op2 (interfaces__integer_64[16] & x)
{
  interfaces__integer_64 r[16] [value-expr: <retval>];

  <retval> = *x;
  goto <D.4619>;
  <D.4619>:
  return <retval>;
}


