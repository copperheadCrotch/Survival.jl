# transform to Dataframe
function SurvLayout(survobj::KMSurv)
    if !isnull(survobj.conf_interval)
        conf_interval = get(survobj.conf_interval)
        Survtable = DataFrame(Time=survobj.t, Total=survobj.n, Censored=survobj.c,
                             Event=survobj.d, Survival_Prob=survobj.d_n, Survival=survobj.surv_func, Std_Error=survobj.std,
                             LowerCI=conf_interval.lower, UpperCI=conf_interval.upper)
    else
        Survtable = DataFrame(Time=survobj.t, Total=survobj.n, Censored=survobj.c,
                             Event=survobj.d, Survival_Prob=survobj.d_n, Survival=survobj.surv_func, Std_Error=survobj.std)
    end
    return Survtable
end

function SurvLayout(survobj::NASurv)
    Survtable = DataFrame(Time=survobj.t, Total=survobj.n, Censored=survobj.c,
                          Event=survobj.d, Survival_Prob=survobj.d_n, Cumulative_Hazard=survobj.cum_hazard)
    return Survtable
end

function SurvLayout(survobj::MRLSurv)
    Survtable = DataFrame(Time=survobj.t, Mean_Residual_Life=survobj.mean_resid_life)
    return Survtable
end

