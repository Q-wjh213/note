#let mat(..args)={
  let q=()
  for i in args.pos(){
      for j in i{
        q.push([#j])
      }
    }
  table(columns:args.at(0).len(),..q)
}
#mat(
  (1,2,3),
  (4,5,6),
  (7,3,4),
  (1,2,3,4),
  (1,)
)

#let k(a,b)=a+b

#let q=(2,3)

#k(..q)
