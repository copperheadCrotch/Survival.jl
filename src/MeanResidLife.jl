# calculate mean residual life for censored data
function MeanResidLife(survobj::Surv)
    censor = find(survobj.event)
    time = survobj.time
    surv_func = survobj.surv_func

    if sum(censor) == 0
        error("There is no censored objects in the data!")
    end

    time_interval = diff(survobj.time)
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
