
;; Function q.op (q__op, funcdef_no=2, decl_uid=4567, cgraph_uid=0, symbol_order=0)

q.op (interfaces__integer_64[16] & l, interfaces__integer_64[16] & r)
{
  interfaces__integer_64 R.2[16];
  interfaces__integer_64 R.1[16];
  interfaces__integer_64 R.0[16];

  <bb 2> [local count: 1073741825]:
  R.2 = p."*" (l_2(D), r_3(D)); [return slot optimization]
  R.1 = p.n3 (&R.2); [return slot optimization]
  R.2 ={v} {CLOBBER};
  R.0 = p.n2 (&R.1); [return slot optimization]
  R.1 ={v} {CLOBBER};
  <retval> = p.n1 (&R.0); [return slot optimization]
  R.0 ={v} {CLOBBER};
  return <retval>;

}



;; Function q.op2 (q__op2, funcdef_no=3, decl_uid=4570, cgraph_uid=1, symbol_order=1)

q.op2 (interfaces__integer_64[16] & x)
{
  <bb 2> [local count: 1073741825]:
  <retval> = *x_2(D);
  return <retval>;

}


