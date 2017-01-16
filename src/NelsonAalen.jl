immutable NASurv <: NonParaSurv
    t::Vector{Float64}
    n::Vector{Int}
    c::Vector{Int}
    d::Vector{Int}
    d_n::Vector{Float64}
    cum_hazard::Vector{Float64}
end


function NAEst(survobj::SurvObject)
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
    d_n = 1 - d./n
    cum_hazard = cumsum(d_n)
    return NASurv(t, n, c, d, d_n, cum_hazard)
end
