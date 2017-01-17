# main module
# Survival analysis
module Survival

    using PyPlot
    using Gadfly
    using Distributions
    using DocStringExtensions

    # non-parametric type
    abstract NonParamSurvival
    abstract ParamSurvival

    const global NORMAL = Normal(0, 1)
    const global PLOT_COLOR = ["#EE1616","#0000FF","#FF007F","#3399FF","#99FF33","00FFFF","9999FF","#009900","#FFFF00","#FF00FF","#CC6600"]

    export
        # type
        SurvObject,
        # function
        KaplanMeierEst,
        NAEst,
        MeanResidLife,
        SurvPlot,
        SurvLayout


    include("SurvBase.jl")
    include("KaplanMeier.jl")
    include("NelsonAalen.jl")
    include("MeanResidLife.jl")
    include("SurvPlot.jl")
    include("SurvLayout.jl")

end
