#include "tweetnacl.h"
#include "d.h"

#define FOR(i,n) for (i = 0;i < n;++i)
#define sv static void

typedef unsigned char u8;
typedef unsigned long u32;
typedef unsigned long long u64;
typedef long long i64;
typedef i64 gf[16];

static const gf
  _121665 = {0xDB41,1};

sv car25519(gf o)
{
    // Faster version owing to WireGuard, and also unroll the final
    // iteration
    int i;
    for (i = 0; i < 15; ++i) {
        o[(i + 1)] += (o[i] >> 16);
        o[i] &= 0xffff;
    }
    o[0] += 38 * (o[15] >> 16);
    o[15] &= 0xffff;
}

sv A(gf o,const gf a,const gf b)
{
  int i;

  FOR(i,16) o[i]=a[i]+b[i];
}

sv Z(gf o,const gf a,const gf b)
{
  int i;

  FOR(i,16) o[i]=a[i]-b[i];
}

sv M(gf o,const gf a,const gf b)
{
  i64 lt,i,j,t[31];

  FOR(i,31) t[i]=0;

  FOR(i,16)
  {
    // Inner loop unrolled and refactored as per SPARKNaCl
    lt = a[i];
    t[i]  +=lt*b[0];
    t[i+1]+=lt*b[1];
    t[i+2]+=lt*b[2];
    t[i+3]+=lt*b[3];
    t[i+4]+=lt*b[4];
    t[i+5]+=lt*b[5];
    t[i+6]+=lt*b[6];
    t[i+7]+=lt*b[7];
    t[i+8]+=lt*b[8];
    t[i+9]+=lt*b[9];
    t[i+10]+=lt*b[10];
    t[i+11]+=lt*b[11];
    t[i+12]+=lt*b[12];
    t[i+13]+=lt*b[13];
    t[i+14]+=lt*b[14];
    t[i+15]+=lt*b[15];
  }

  FOR(i,15) t[i]+=38*t[i+16];
  FOR(i,16) o[i]=t[i];

  car25519(o);
  car25519(o);
}

sv S(gf o,const gf a)
{
  M(o,a,a);
}

sv inv25519(gf o,const gf i)
{
  gf c;
  int a;
  FOR(a,16) c[a]=i[a];
  for(a=253;a>=0;a--) {
    S(c,c);
    if(a!=2&&a!=4) M(c,c,i);
  }
  FOR(a,16) o[a]=c[a];
}

sv sel25519(gf p,gf q,int b)
{
  i64 t,i,c=~(b-1);
  FOR(i,16) {
    t= c&(p[i]^q[i]);
    p[i]^=t;
    q[i]^=t;
  }
}

sv pack25519(u8 *o,const gf n)
{
  int i,j,b;
  gf m,t;
  FOR(i,16) t[i]=n[i];
  car25519(t);
  car25519(t);
  car25519(t);
  FOR(j,2) {
    m[0]=t[0]-0xffed;
    for(i=1;i<15;i++) {
      m[i]=t[i]-0xffff-((m[i-1]>>16)&1);
      m[i-1]&=0xffff;
    }
    m[15]=t[15]-0x7fff-((m[14]>>16)&1);
    b=(m[15]>>16)&1;
    m[14]&=0xffff;
    sel25519(t,m,1-b);
  }
  FOR(i,16) {
    o[2*i]=t[i]&0xff;
    o[2*i+1]=t[i]>>8;
  }
}

sv unpack25519(gf o, const u8 *n)
{
  int i;
  FOR(i,16) o[i]=n[2*i]+((i64)n[2*i+1]<<8);
  o[15]&=0x7fff;
}

int crypto_scalarmult(u8 *q,const u8 *n,const u8 *p)
{
  u8 z[32];
  i64 x[80],r,i;
  gf a,b,c,d,e,f;

  FOR(i,31) z[i]=n[i];
  z[31]=(n[31]&127)|64;
  z[0]&=248;
  unpack25519(x,p);


  FOR(i,16) {
    b[i]=x[i];
    d[i]=a[i]=c[i]=0;
  }

  a[0]=d[0]=1;

  for(i=254;i>=0;--i) {
    r=(z[i>>3]>>(i&7))&1;

    {
      u8 tr = (u8) r;
    }

    sel25519(a,b,r);
    sel25519(c,d,r);

    A(e,a,c);

    Z(a,a,c);
    A(c,b,d);
    Z(b,b,d);
    S(d,e);
    S(f,a);
    M(a,c,a);
    M(c,b,e);
    A(e,a,c);
    Z(a,a,c);
    S(b,a);
    Z(c,d,f);
    M(a,c,_121665);
    A(a,a,d);
    M(c,c,a);
    M(a,d,f);
    M(d,b,x);
    S(b,e);
    sel25519(a,b,r);
    sel25519(c,d,r);
  }

  FOR(i,16) {
    x[i+16]=a[i];
    x[i+32]=c[i];
    x[i+48]=b[i];
    x[i+64]=d[i];
  }
  inv25519(x+32,x+32);
  M(x+16,x+16,x+32);
  pack25519(q,x+16);

  return 0;
}

int crypto_scalarmult_base(u8 *q,const u8 *n)
{
  return crypto_scalarmult(q,n,_9);
}
