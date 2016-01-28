# Survival.jl
<body>
<h4>Julia package for survival analysis (under development)	</h4><br/>
---
The module aims to provide comprehensive functions used in survival analysis. Plot requires [PyPlot](https://github.com/stevengj/PyPlot.jl) package installed to Julia.To install the package `PyPlot`, 
simply run `Pkg.add("PyPlot")`.
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
