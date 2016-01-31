# transform to Dataframe
function SurvLayout(survobj::KMSurv)
    Survtable = DataFrame(Time=survobj.t, Total=survobj.n, Censored=survobj.c,
                          Event=survobj.d, Survival_Prob=survobj.d_n, Survival=survobj.surv_func)
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
