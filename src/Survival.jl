# main module
# Survival analysis
module Survival
    using Reexport
    using Compat
    @reexport using DataFrames
    @reexport using Distributions
    @reexport using PyPlot

    export
        # type
        SurvObject,

        # function
        KMEst,
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
