# Survival.jl
<body>
<h4>Julia package for survival analysis (under development)	</h4>

---
<h5>Kaplan-Meier Estimator</h5>
<a>Create a survival object for further use </a>
`survobj = SurvObject(time, event)`

Caculate the Kaplan-Meier Estimator
`km_est = KMest(survobj)`

Get the Kaplan-Meier Estimator
`km_est.surv_func`

<h5>Kaplan-Meier Curve</h5>
Plot the Kaplan-Meier Curve
`KMplot(km_est)`
</body>
