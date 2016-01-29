# transform to Dataframe
function SurvLayout(survobj::KMsurv)
    Survtable = DataFrame(Time=survobj.t, Total=survobj.n, Censored=survobj.c,
                          Event=survobj.d, Death_Prob=survobj.d_n, Survival=survobj.surv_func)
    return Survtable
end

function SurvLayout(survobj::NAsurv)
    Survtable = DataFrame(Time=survobj.t, Total=survobj.n, Censored=survobj.c,
                          Event=survobj.d, Death_Prob=survobj.d_n, Cumulative_Hazard=survobj.hazard)
    return Survtable
end
