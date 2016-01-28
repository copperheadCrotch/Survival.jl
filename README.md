# Survival.jl
####Julia package for survival analysis (under development)####
---
---
#####Kaplan-Meier Estimator#####

Create a survival object for further use<br/>
`survobj = SurvObject(time, event)`

#####Example#####
For example 

#####Caculate the Kaplan-Meier Estimator#####
`km_est = KMest(survobj)`

#####Get the Kaplan-Meier Estimator#####
`km_est.surv_func`

#####Kaplan-Meier Curve#####
Plot the Kaplan-Meier Curve<br/>
`KMplot(km_est)`
