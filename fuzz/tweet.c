#define FOR(i,n) for (i = 0;i < n;++i)

typedef long long i64;
typedef i64 gf[16];

void car25519(gf o)
{
  int i;
  i64 c;

  FOR(i,16) {
    o[i]+=(1LL<<16);
    c=o[i]>>16;
    o[(i+1)*(i<15)]+=c-1+37*(c-1)*(i==15);
    o[i]-=c<<16;
  }
}

void M(gf o,const gf a,const gf b)
{
  i64 i,j,t[31];

  FOR(i,31) t[i]=0;
  FOR(i,16) FOR(j,16) t[i+j]+=a[i]*b[j];
  FOR(i,15) t[i]+=38*t[i+16];
  FOR(i,16) o[i]=t[i];

  car25519(o);
  car25519(o);
}
