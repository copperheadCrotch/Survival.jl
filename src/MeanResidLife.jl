# MRLSurv type
immutable MRLSurv <: NonParaSurv
    t::Vector{Float64}
    mean_resid_life::Vector{Float64}
end


# calculate mean residual life for censored data
function MeanResidLife(survobj::KMSurv)
    censor = find(survobj.c)
    time = survobj.t
    surv_func = survobj.surv_func

    if sum(censor) == 0
        error("There is no censored objects in the data!")
    end

    time_interval = diff(survobj.t)
    unshift!(time_interval, 0)
    area = time_interval .* surv_func # calculate area under the curve
    area_under_curve = reverse(cumsum(reverse(area)))

    censor_time = time[censor]
    mean_resid_life = area_under_curve[censor]
    #=
    unshift!(area, 0)
    cumsum(reverse(area))
    censor_time = time[censor]
    mean_resid_life = area[censor]
    =#
    return MRLSurv(censor_time, mean_resid_life)
end
