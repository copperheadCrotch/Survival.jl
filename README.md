#Julia package for survival analysis (under development)#
This module aims to provide support for most of up-to-date staistical analytic approaches used in survival analysis. It will include functions through basic layout of survival data from survival analysis to complex survival models. The plots require package [PyPlot] pre-installed to Julia, which provides an interface to `Mathplotlib` in Python. If not installed yet, run `Pkg.add("PyPlot")`. This module is developed under Julia 0.4.3.
##Update##
01/27/2016 Function for Kaplan-Meier analysis
           Calculate Nelson-Aalen estimator
##Usage##
####Create a survival data object for further use####
To carry out some non-parametric survival analysis, we usually collect data of time-to-event and censoring information. This module allows to create a survival object for further use by running `SurvObject(time, event)`. Where `time` is a vector of time-to-event data and `event` is a vector of corresponding indicators, where 0 denotes being censored, 1 denotes having events. 

#####Example 1.1#####

In a study of remission of poststroke depression in weeks for two groups of stroke patients, with 10 patients in each group. Group 1 was the treatment group with mood treatment and group2 was the control, the study went on for 9 weeks. At the end of study, 5 patients had remissions in the intervention arm, 5 were censored during the trial. The time-to-remission data for group 1 was also collected: 1, 2, 5, 5, 5+, 7+, 8+, 8, 9+, 9+, where '+' denotes censoring. 

In general survival analysis, we should obtain two vectors for this, `time=[1, 2, 5, 5, 5, 7, 8, 8, 9, 9]` and `event=[1, 1, 1, 1, 0, 0, 0, 1, 0, 0]`. Therefore we could create the object first, `survobj = SurvObject(time, event)`,

####Alternative Data Layout for Kaplan-Meier Curves####

Alternative data layout is required for Kaplan-Meier(K-M) curves. K-M estimator is calculated from the product limit of survival probabilities. With the data object we instantiated above, a K-M data object for data layout and K-M curve is returned from `kmobject = KMest(survobj)`.

To get the Kaplan-Meier estimator from the returned data object, retrieve the attribute `surv_func` in the K-M object, `kmobject.surv_func`, in the same Example 1.1, the K-M estimators of survival probability at each time points are returned in a vector.

 ```
 7-element Array{Float64,1}:
 1.0 
 0.9 
 0.8 
 0.6 
 0.6 
 0.45
 0.45
 ```
To transform the returned object into a `DataFrame` object in Julia,  [DataFrame](https://github.com/JuliaStats/DataFrames.jl) needs to be installed. Using `Survlayout(kmobject)` performs the transformation, a dataframe for the alternative survival data layout is then returned.

```
7x6 DataFrames.DataFrame
| Row | Time | Total | Censored | Event | Death_Prob | Survival |
|-----|------|-------|----------|-------|------------|----------|
| 1   | 0.0  | 10    | 0        | 0     | 1.0        | 1.0      |
| 2   | 1.0  | 10    | 0        | 1     | 0.9        | 0.9      |
| 3   | 2.0  | 9     | 0        | 1     | 0.888889   | 0.8      |
| 4   | 5.0  | 8     | 1        | 2     | 0.75       | 0.6      |
| 5   | 7.0  | 5     | 1        | 0     | 1.0        | 0.6      |
| 6   | 8.0  | 4     | 1        | 1     | 0.75       | 0.45     |
| 7   | 9.0  | 2     | 2        | 0     | 1.0        | 0.45     |
```

####Kaplan-Meier Curve####
To plot the survival data using K-M curves, `KMplot(kmobject)`

<img src="https://github.com/conta1992/Survival.jl/blob/master/Example/Figures/Figure1.1.png" width="450">

Specify a color of the curve,
`KMplot(km_object1, color="red", xlim=(0, 10))`

<img src="https://github.com/conta1992/Survival.jl/blob/master/Example/Figures/Figure1.2.png" width="450">

To plot multiple curves in a same figure,`KMplot(km_object1, km_object2...)`

<img src="https://github.com/conta1992/Survival.jl/blob/master/Example/Figures/Figure1.3.png" width="450">

####Nelson-Aalen Estimator####
To get the Nelson-Aalen (N-A) estimator, run `naobject = NAest(surv_obj1)`, the returned object could also be transformed into a `DataFrame`, by running `DataFrame(naobject)`.
```
6x6 DataFrames.DataFrame
| Row | Time | Total | Censored | Event | Death_Prob | Cumulative_Hazard |
|-----|------|-------|----------|-------|------------|-------------------|
| 1   | 1.0  | 10    | 0        | 1     | 0.9        | 0.9               |
| 2   | 2.0  | 9     | 0        | 1     | 0.888889   | 1.78889           |
| 3   | 5.0  | 8     | 1        | 2     | 0.75       | 2.53889           |
| 4   | 7.0  | 5     | 1        | 0     | 1.0        | 3.53889           |
| 5   | 8.0  | 4     | 1        | 1     | 0.75       | 4.28889           |
| 6   | 9.0  | 2     | 2        | 0     | 1.0        | 5.28889           |
```
