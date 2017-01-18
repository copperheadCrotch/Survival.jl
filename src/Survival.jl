# main module
# Survival analysis
module Survival

    using Gadfly
    using Distributions
    using DataFrames
    using DocStringExtensions

    # non-parametric type
    abstract NonParamSurvival
    abstract ParamSurvival

    # type alias
    typealias Vector{T} Array{T,1}
    
    # type
    export
        Surv

    # function
    export
        SurvObject
        # KaplanMeierEst,
        # NAEst,
        # MeanResidLife,
        # SurvPlot,
        # SurvLayout


    const global ZDIST = Normal(0, 1)
    # A default color pool
    const global PLOT_COLOR = ["#EE1616","#0000FF","#FF007F","#3399FF","#99FF33","00FFFF","9999FF","#009900","#FFFF00","#FF00FF","#CC6600"]


    include("SurvBase.jl")
    # include("KaplanMeier.jl")
    # include("NelsonAalen.jl")
    # include("MeanResidLife.jl")
    # include("SurvPlot.jl")
    # include("SurvLayout.jl")

end
