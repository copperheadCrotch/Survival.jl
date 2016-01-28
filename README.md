# Survival.jl
<body>
<h4>Julia package for survival analysis (under development)	</h4><br/>
---
The module aims to provide comprehensive data analytic approaches used in survival analysis. This includes survival data layout, calculate survival and hazard function, as well as building models. Plot requires [PyPlot](https://github.com/stevengj/PyPlot.jl) package pre-installed to Julia. If the the package `PyPlot` is not installed yet, run `Pkg.add("PyPlot")` to add the package.
---
<h5>Kaplan-Meier Estimator</h5>

Create a survival object for further use<br/>
`survobj = SurvObject(time, event)`

<h6>Example</h6>
For example 

Caculate the Kaplan-Meier Estimator<br/>
`km_est = KMest(survobj)`

Get the Kaplan-Meier Estimator<br/>
`km_est.surv_func`

<h5>Kaplan-Meier Curve</h5>
Plot the Kaplan-Meier Curve<br/>
`KMplot(km_est)`
</body>
