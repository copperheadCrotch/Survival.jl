"""
$(TYPEDEF)

Constructors
------------
* `Surv(time::Vector{Real}, event::Vector{Bool})`

Arguments
---------
* `time`: A vector of survival time for patients.

* `event`: A vector of censorship indicators. If event = 1, the patient has the event, if event = 0 and time < final time, the patient is
censored.

Fields
------
$(FIELDS)
"""
immutable Surv

   time::Vector{Real}
   event::Vector{Bool}
   # validator
   function Surv(time, event)

       if length(time) != length(event)
           error("Time and event should have the same length\n")
       end
       if any(i -> (i < 0.0), time)
           error("Time should always be non-negative!")
       end
       new(time, event)

   end

end # end type


"""
$(SIGNATURES)

Create a survival data object for survival analysis for normal data layout.

Arguments
---------
* `time` --  A vector of survival time for patients.

* `event` -- A vector of censorship indicators. If event = 1, the patient has the event, if event = 0 and time < final time, the patient is
censored.

Fields
------
$(FIELDS)
"""
function SurvObject(time::Vector{Real}, event::Vector{Bool})

    Surv(time, event)

end


"""
$(SIGNATURES)

Create a survival data object for survival analysis for interval data layout

Arguments
---------
* `time_start` --  A vector of start time for patients

* `time_end` -- A vector of end time for patients, end time should be greater than start time

* `event` -- A vector of censorship indicators. If event = 1, the patient has the event, if event = 0 and time < final time, the patient is
censored.

Fields
------
$(FIELDS)
"""
function SurvObject(time_start::Vector{Real}, time_end::Vector{Real}, event::Vector{Bool})

    time = time_end - time_start
    Surv(time, event)

end
