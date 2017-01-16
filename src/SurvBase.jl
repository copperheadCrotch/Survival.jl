"""
$(TYPEDEF)

Create a survival object for analysis.

Constructors
------------
* `SurvObject(time::Vector{Real}, event::Vector{Bool})`

Arguments
---------
* `time`: The survival time for the patient

* `event`: The indicator for censoring. If event = 1, the patient is censored.

Fields
------
$(FIELDS)
"""
immutable SurvObject

   time::Vector{Real}
   event::Vector{Bool}

   # validator
   function SurvObject(time, event)

       if length(time) != length(event)
           error("Time and event should have the same length\n")
       end
       if any(i -> (i < 0.0), time)
           error("Time should always be non-negative!")
       end
       new(time, event)

   end

end # end type


# immutable SurvConfidenceInterval
#     upper::Vector{Float64}
#     lower::Vector{Float64}
# end
#
# function SurvBasic(::Exponential)
#
#     surv_func = exp(-λ)
#     hazard = λ
#     println("survival function: $surv_func")
#     println("hazard function: $hazard")
#     println("cumulative hazard: $cum_hazard")
#     println("mean residual life: $mean_res_life")
# end
#
#
# function SurvBasic(::Weibull)
#
# end
