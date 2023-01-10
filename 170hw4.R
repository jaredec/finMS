binomCall <- function(n,T,S0,K,r)
{  
  h <- T/n
  d<-exp(-0.25*sqrt(h)); u<-exp(0.25*sqrt(h)); q<- 1/(1+exp(0.25*sqrt(h)))
  Sbin <- S0*d^n*(u/d)^(0:n)  # possible values of stock price
  qbin <- dbinom(0:n,n,q)  # corresponding probabilities using q
  Payoff <- pmax(Sbin-K,0)
  return(exp(-r*T)*sum(qbin*Payoff))
}

q5 <- binomCall(4,1,100,100,0.05)
q5

