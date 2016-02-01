# Julia script for plotting Kaplan-Meier curve
# KMsurv
# return object for K-M curve
immutable KMSurv <: NonParaSurv
    t::Vector{Float64}
    n::Vector{Int}
    c::Vector{Int}
    d::Vector{Int}
    d_n::Vector{Float64}
    surv_func::Vector{Float64}
    std::Vector{Float64}
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

function KMEst(survobj::SurvObject; stdtype="Greenwood")
    time = survobj.time
    event = survobj.event
    t = sort(unique(time))
    if t[1] != 0
        unshift!(t, 0)
        println("Add 0 to time points")
    end
    n = [count(i->(i>=j),time) for j in t]
    # c = sort(unique(time[findin(event, 0)]))
    c = [count(i->(i==0), event[findin(time, j)]) for j in t]
    d = [sum(event[findin(time, i)]) for i in t]
    # d_n = map(i->1-d[i]/n[i], [i for i = 1:length(n)])
    d_n = [1-d[i]/n[i] for i = 1:length(n)]
    surv_func = [prod(d_n[1:i]) for i = 1:length(n)]
    if stdtype == "Greenwood"
        std_prod = cumsum([d[i]/(n[i]*(n[i]-d[i])) for i = 1:length(n)])
        var = (surv_func.^2).*std_prod
        std = sqrt(float64(var))
    end
    return KMSurv(t, n, c, d, d_n, surv_func, std)
end
