# Julia script for plotting Kaplan-Meier curve
# KMsurv
# return object for K-M curve
type KMsurv <: NonParasurv
    t::Vector{Float64}
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

function KMest(survobj::SurvObject)
    time = survobj.time
    event = survobj.event
    t = sort(unique(time))
    if t[1] != 0
        unshift!(t, 0)
        warn("Add 0 to time points")
    end
    n = [count(i->(i>=j),time) for j in t]
    # c = sort(unique(time[findin(event, 0)]))
    c = [count(i->(i==0), event[findin(time, j)]) for j in t]
    d = [sum(event[findin(time, i)]) for i in t]
    # d_n = map(i->1-d[i]/n[i], [i for i = 1:length(n)])
    d_n = [1-d[i]/n[i] for i = 1:length(n)]
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
       isempty(color) ? color = collect(take(cycle(["b", "r", "g", "c", "m", "y", "k"]), num)) : color = [color]
       isempty(label) ? label = [1:num] : label
    catch e
       error("Catch an error $e")
    end
    for (index, arg) in enumerate(args)
        if !isa(arg, KMsurv)
            error("Input is not a KMsurv object!\n")
        end
        x = arg.t
        y = arg.surv_func
        # markers
        censor_x = x[find(arg.c)]
        censor_y = y[findin(x, censor_x)]

        PyPlot.step(x, y, where="post", color= color[index], label=label[index])  # plot K-M curve
        PyPlot.plot(censor_x, censor_y, linestyle="None", marker="+", markersize=markersize, color="Black")
    end
    PyPlot.ylim(ylim) # y limit (0 - 1)
    PyPlot.xlim(xlim) # x limit (0 - max time)
    # PyPlot.legend(handles=[plot1]) legend
end
