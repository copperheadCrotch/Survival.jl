#Julia package for survival analysis (under development)#
This module aims to provide support for most of up-to-date staistical analytic approach used in survival analysis. It will include functions through baisc layout of data from survival analysis to built-up survival model. The plots require package [PyPlot] pre-installed to Julia. If not installed yet, run `Pkg.add("PyPlot")`. It is developed under Julia 0.4.3.
##Update##
01/27/2016 Function for Kaplan-Meier analysis
##Usage##
####Create a survival data object for further use####
Most of the survival data we collected contains the information about time-to-event and indicator whether the patient is censored. To create a survival object for further use, run `SurvObject(time, event)`. Where `time` is a vector of time-to-event data and `event` is a vector of corresponding indicators, 0 as being censored, 1 as having events. This data object is used in further analysis.

#####Example 1.1#####

In a study of remission of poststroke depression in weeks for two groups of stroke patients, with 10 patients in each group. Group 1 was the treatment group with mood treatment and group2 was the control, the study went on for 9 weeks. At the end of study, in group 1, 5 had remissions during the intervention, the rest of patients were censored. The data for group 1 was collected: 1, 2, 5, 5, 5+, 7+, 8+, 8, 9+, 9+, where '+' denotes censoring. 

We create two vectors for this, `time=[1, 2, 5, 5, 5, 7, 8, 8, 9, 9]` and `event=[1, 1, 1, 1, 0, 0, 0, 1, 0, 0]`, then we could create a survival data object `survobj`,

`survobj = SurvObject(time, event)`

####Alternative Data Layout for Kaplan-Meier Curves####

Alternative data layout is required for Kaplan-Meier(K-M) curves, K-M estimator is calculated using the product limit formula. Using the survival data object generated above, we could get a K-M data object for layout and K-M curve through `KMest(survobj)`.

`kmobject = KMest(survobj)` will return you an object used in data layout and K-M plots

To get the Kaplan-Meier estimator from the returned data object,

`kmobject.surv_func`
 
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
To transform the returned object into a `DataFrame` object in Julia,  [DataFrame](https://github.com/JuliaStats/DataFrames.jl) needs to be installed. Using `KMlayout(kmobject)` performs the transformation, a dataframe for the alternative survival data layout is then returned

```
11x5 DataFrames.DataFrame
| Row | Time | Total | Event | Death    | Survival |
|-----|------|-------|-------|----------|----------|
| 1   | 0.0  | 10    | 0     | 1.0      | 1.0      |
| 2   | 1.0  | 10    | 1     | 0.9      | 0.9      |
| 3   | 2.0  | 9     | 0     | 1.0      | 0.9      |
| 4   | 4.0  | 8     | 1     | 0.875    | 0.7875   |
| 5   | 11.0 | 7     | 0     | 1.0      | 0.7875   |
| 6   | 12.0 | 6     | 0     | 1.0      | 0.7875   |
| 7   | 16.0 | 5     | 1     | 0.8      | 0.63     |
| 8   | 20.0 | 4     | 0     | 1.0      | 0.63     |
| 9   | 21.0 | 3     | 1     | 0.666667 | 0.42     |
| 10  | 29.0 | 2     | 1     | 0.5      | 0.21     |
| 11  | 35.0 | 1     | 0     | 1.0      | 0.21     |
```

####Kaplan-Meier Curve####
To plot the survival data using K-M curves, `KMplot(kmobject)`

<img src="https://github.com/conta1992/Survival.jl/blob/master/Example/Figures/Figure1.1.png" width="450">

Specify a color of the curve,
`KMplot(km_object1, color="red", xlim=(0, 10))`

<img src="https://github.com/conta1992/Survival.jl/blob/master/Example/Figures/Figure1.2.png" width="450">

To plot multiple curves in a same figure,`KMplot(km_object1, km_object2...)`
