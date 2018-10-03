
- why is "Bartlett" being lowercased in citation (inference.rnw) ?
- add cloglog?

- fix parameterization notes

Logistic examples
gg0 <- ggplot(Contraception,aes(age,as.numeric(use)-1,colour=urban))+
stat_sum(alpha=0.5)+facet_wrap(~livch,labeller=label_both)

gg0 + geom_smooth(method="gam",method.args=list(family=binomial),
formula=y~s(x,k=20))

gg0 + geom_smooth(method="glm",method.args=list(family=binomial),
formula=y~poly(x,2))

download.file infelicity!!!!

xkcd toaster stab
"will remove the file if ~there~"

crash blossom
A progress bar tracks the transfer platform specifically:

A progress bar tracks the transfer:

Contraception data, original source?

https://rdrr.io/cran/epiDisplay/man/bang.html
http://data.princeton.edu/pop510/bangladesh.html
