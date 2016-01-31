# Kaplan-Meier plot
function SurvPlot(args::KMSurv...; color=[], label=[], markercolor="black", markersize=15,
                ylim=(0, 1.1), xlim=(xmin=0), title="", xlabel="time",
                ylabel="Kaplan-Meier Estimator")
# calculate the Kaplan-Meier estimators

    # PyPlot.figure()
    num = length(args)
    # step plot
    try
       isempty(color) ? color = collect(take(cycle(["b", "r", "g", "c", "m", "y", "k"]), num)) : color = [color]
       isempty(label) ? label = [1:num] : label
    catch e
       error("Catch an error $e")
    end
    for (index, arg) in enumerate(args)

        x = arg.t
        y = arg.surv_func
        censor = find(arg.c)
        # markers
        censor_x = x[censor]
        # censor_y = y[findin(x, censor_x)]
        censor_y = y[censor]

        PyPlot.step(x, y, where="post", color= color[index], label=label[index])  # plot K-M curve
        PyPlot.plot(censor_x, censor_y, linestyle="None", marker="+", markersize=markersize, color=markercolor)
    end
    PyPlot.ylim(ylim) # y limit (0 - 1)
    PyPlot.xlim(xlim) # x limit (0 - max time)
    PyPlot.title(title)
    PyPlot.xlabel(xlabel)
    PyPlot.ylabel(ylabel)
    # PyPlot.legend(handles=[plot1]) legend
end


# Nelson-Aalen plot
function SurvPlot(args::NASurv...; color=[], label=[],
                ylim=(ymin=0), xlim=(xmin=0), title="",
                xlabel="time", ylabel="Nelson-Aalen Estimator")

    # PyPlot.figure()
    # calculate the Nelson-Aalen estimators
    num = length(args)
    # step plot
    try
       isempty(color) ? color = collect(take(cycle(["b", "r", "g", "c", "m", "y", "k"]), num)) : color = [color]
       isempty(label) ? label = [1:num] : label
    catch e
       error("Catch an error $e")
    end
    for (index, arg) in enumerate(args)
        x = arg.t
        y = arg.cum_hazard
        PyPlot.plot(x, y, color=color[index], label=label[index])  # plot N-A curve
    end
    PyPlot.ylim(ylim) # y limit (0 - 1)
    PyPlot.xlim(xlim) # x limit (0 - max time)
    PyPlot.title(title)
    PyPlot.xlabel(xlabel)
    PyPlot.ylabel(ylabel)
    # PyPlot.legend(handles=[plot1]) legend
end
