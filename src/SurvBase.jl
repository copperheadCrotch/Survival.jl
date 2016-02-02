# Create a survival object
immutable SurvObject
   time::Vector{Float64}
   event::Vector{Bool}

   # validator
   function SurvObject(t, e)
       if length(t) != length(e)
           error("Length unmatched: the event vector should have same length as time vector\n")
       end
       if any(i->(i<0.0), t)
           error("Time could not be negative")
       end
       new(t, e)
   end
end # end type

# non-parametric type
abstract NonParaSurv
global Z = Normal(0, 1)

immutable SurvConfidenceInterval
    upper::Vector{Float64}
    lower::Vector{Float64}
end

#=
function SurvBasic(::Exponential)

    surv_func = exp(-λ)
    hazard = λ
    println("survival function: $surv_func")
    println("hazard function: $hazard")
    println("cumulative hazard: $cum_hazard")
    println("mean residual life: $mean_res_life")
end


function SurvBasic(::Weibull)

end
=#
