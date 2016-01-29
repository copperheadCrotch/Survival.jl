# main module
# Survival analysis
module Survival
    using DataFrames
    using PyPlot
    export
        # type
        SurvObject,

        # function
        KMest,
        KMlayout,
        KMplot,
        NAest,
        SurvLayout


    include("SurvBase.jl")
    include("KaplanMeier.jl")
    include("NelsonAalen.jl")
    include("SurvLayout.jl")

end
