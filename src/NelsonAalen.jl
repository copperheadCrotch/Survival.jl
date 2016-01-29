type NAsurv <: NonParasurv
    t::Vector{Float64}
    n::Vector{Int}
    c::Vector{Int}
    d::Vector{Int}
    d_n::Vector{Float64}
    hazard::Vector{Float64}
end


function NAest(survobj::SurvObject)
    time = survobj.time
    event = survobj.event
    t = sort(unique(time))

    c = [count(i->(i==0), event[findin(time, j)]) for j in t]
    n = [count(i->(i>=j),time) for j in t]
    d = [sum(event[findin(time, i)]) for i in t]
    d_n = [1-d[i]/n[i] for i = 1:length(n)]
    hazard = cumsum(d_n)
    return NAsurv(t, n, c, d, d_n, hazard)
end
