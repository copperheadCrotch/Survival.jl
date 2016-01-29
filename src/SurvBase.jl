# Create a survival object
type SurvObject
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
abstract NonParasurv


#=Calculate basic survival statistics
immutable SurvBasic

end



function SurvFunc(λ, t; family="exp")
    return exp(-λ*t)
end
=#
