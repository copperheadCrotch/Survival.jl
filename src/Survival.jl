# main module
# Survival analysis
module Survival
    using Reexport
    using Compat
    @reexport using DataFrames
    @reexport using PyPlot
    
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
