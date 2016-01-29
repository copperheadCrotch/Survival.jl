# using Survival
using Survival

# test for KMplot.jl
# Example 1
# test for type SurvObject
# create a survival object
surv_obj1 = SurvObject([1,2,5,5,5,7,8,8,9,9],[1,1,1,1,0,0,0,1,0,0])
# calculate K-M estimators, could be used in K-M plots
km_object1 = KMest(surv_obj1)
km_object1.surv_func

# Example 2
# create another K-M object
surv_obj2 = SurvObject([1,12,4,11,16,2,29,21,35,20], [1,0,1,0,1,0,1,1,0,0])
km_object2 = KMest(surv_obj2)
# get a DataFrame object
SurvLayout(km_object1)



# Example 3
# plot K-M curves
KMplot(km_object1)
KMplot(km_object1, color=["red"], ylim=(0, 1.2))

# Example 4
# plot two curves
KMplot(km_object1, km_object2, color=["y", "b"])


# Example 5
# Nelson-Aalen estimators
na_object1 = NAest(surv_obj1)
SurvLayout(na_object1)
