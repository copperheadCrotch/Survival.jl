# MRLSurv type
immutable MRLSurv <: NonParaSurv
    time::Vector{Float64}
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
    pop!(surv_func)
    area = time_interval .* surv_func # calculate area under the curve
    area_under_curve = reverse(cumsum(reverse(area)))
    push!(area_under_curve, 0)

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
