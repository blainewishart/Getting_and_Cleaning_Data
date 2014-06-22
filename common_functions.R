# functions used in run_analysis.R
name_activities <- function(x){
  if (x == 1) return("walking")
  else if (x == 2) return("walking_upstairs")
  else if (x == 3) return("walking_downstairs")
  else if (x == 4) return("sitting")
  else if (x == 5) return("standing")
  else if (x == 6) return("laying")
  else return("data_problem")
}

#####
## do a sanity check on number of observations
## based on sizes of original uci_har, uci_har_reduced
## we expect 10299 observations
## with 10299 observations, we expect 10299 obs * 30 subjects * 6 activites == 494352 rows in uci_melt
## since everythign lines up, we are pretty confident the 
##########
count_all_observations_by_subject_activity <- function (ds){
line_count<- 0
row_total<- 0
for (i in 1:30){
  for (j in 1:6){
    line_count = line_count+1
    a<-subset(ds, activity==j & subject==i)
    b<- nrow(a)
    row_total<- row_total + b
    print(sprintf("activity %i and subject %i have length %i at line count %i with rows so far %i", i,j,b, line_count, row_total))
  }
}
}