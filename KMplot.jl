# Survival analysis
# Julia script for plotting Kaplan-Meier curve
using PyPlot
using DataFrames

# KMobject
# Create a survival object
immutable SurvObject
   time::Vector{Real}
   event::Vector{Bool}

   # validator
   function SurvObject(t, e)
       if length(t) != length(e)
           error("Length unmatched: the event vector should have same length as time vector\n")
       end
       if any(i->(i<0.0), t)
           error("Time could not be negative")
       end
       new(t, e)
   end
end # end type

# KMsurv
# return object for K-M curve
type KMsurv
    t::Vector{Real}
    n::Vector{Int}
    c::Vector{Int}
    d::Vector{Int}
    d_n::Vector{Float64}
    surv_func::Vector{Float64}
end



#=
KMobject
Calculate the K-M estiamtes
Input:
One with all the time points, another vector contain 0, 1, where 0
represent censoring, 1 represent the event (default)

Create an object contain the following information
time: unique time points
c: censored object at time i
d: number of events at time i
n: people at risk at time i
di/ni: event rate at time i
survival probability: the survival proabability at time i

This object could be further used to plot the K-M curve
=#

function KMest(SurvObject)
    time = SurvObject.time
    event = SurvObject.event
    t = sort(unique(time))
    if t[1] != 0.0
        unshift!(t, 0)
        warn("Add 0 to time points")
    end
    n = [count(i->(i>=j),time) for j in t]
    c = sort(unique(time[findin(event, 0)]))
    d = [sum(event[findin(time, i)]) for i in t]
    d_n = map(i->1-d[i]/n[i], [i for i = 1:length(n)])
    surv_func = [prod(d_n[1:i]) for i = 1:length(n)]
    return KMsurv(t, n, c, d, d_n, surv_func)
end

#=
K-M curve
Input: KMsurv object
=#

function KMplot(args...; markersize=15, color=[], label=[], ylim=(0, 1.1), xlim=(xmin=0))
# calculate the Kaplan-Meier estimators

    num = length(args)
    # step plot
    try
       isempty(color)? color = collect(take(cycle(["b", "r", "g", "c", "m", "y", "k"]), num)) : color = [color]
       isempty(label) ? label = [1:num] : label
    catch e
       error("Catch an error $e")
    end
    for (index, arg) in enumerate(args)
        x = arg.t
        y = arg.surv_func
        # markers
        censor_x = arg.c
        censor_y = y[findin(x, censor_x)]

        PyPlot.step(x, y, where="post", color= color[index], label=label[index])  # plot K-M curve
        PyPlot.plot(censor_x, censor_y, linestyle="None", marker="+", markersize=markersize, color="Black")
    end
    PyPlot.ylim(ylim) # y limit (0 - 1)
    PyPlot.xlim(xlim) # x limit (0 - max time)
    # PyPlot.legend(handles=[plot1]) legend
end

# test for plot
# dev test
# get an composite variable KMsurv

# Example 1
# test for type SurvObject
# create a survival object
surv_obj1 = SurvObject([1, 2, 5, 5, 5, 7, 8, 8, 9, 9],[1, 1, 1, 1, 0, 0, 0, 1, 0, 0])
# calculate K-M estimators, could be used in K-M plots
km_object1 = KMest(surv_obj1)
km_object1.surv_func
# Example 2
surv_obj2 = SurvObject([1,12,4,11,16,2,29,21,35,20], [1,0,1,0,1,0,1,1,0,0])
km_object2 = KMest(surv_obj2)

km_object2.t
km_object2.surv_func
# Example 3
KMplot(km_object1)
KMplot(km_object1, color=["red"], ylim=(0, 1.2))
KMplot(km_object1, color="red", ylim=(0, 1.2))
# Example 4
KMplot(km_object1, km_object2, color=["y", "k"])
