
# Create fake data for sample size tutorial and save it in the project folder

library(lme4)
library(readstata13) 
library(sm)
library(ggplot2)

setwd("C:/Users/coh334/Google Drive/Other/CEPR/Open SDP/Statistical Power/Learnr tests/Sample Size Tutorial TEST")
Stud.Admin <- read.dta13("student_administrative_data.dta")
# -------------------------------
# Necessary Variables in Dataset
# ------------------------------

# Identification variables:
# - nctesid (Stud.Admin)
# - class_id_m (Math class id - Stud.Admin)
# - nctetid (Stud.Admin, Teach.Bkgd)
# - schoolid (Stud.Admin)
# - district (Stud.Admin)

# Pre-Outcome variable [
# This variable will be used to predict the outcome
# - s_state_std_m (Stud.Admin)

# Other variables of interest
# - schoolyear_sp            (student level, year)
# - test_grade               (student level, grade level)
# - test_grade_tm1           (student level, grade level prior year)
# - s_state_std_m_tm1        (student level, prior year math test score)
# - s_state_std_e_tm1        (student leve, prior year ela test score)
# - s_male                   (student level, male indicator)
# - s_frpl                   (studnet level, frpl indicator)
# - daysattended             (student level, attendance)
# - _Cclass_size             (class level, size)
# - _Cs_male                 (class level, %male)
# - _Cs_frpl                 (class level, %frpl)
# - _Sschool_size            (school level, size)

# ---- Create new subset of Student Admin dataset to be used for power calculation ----
# ---- This dataset will only include grade 4 students from 2012 ---
# ---- (can later be modified to include other grades)

# -------------------------------------------------------
# create subset with just students in 4th grade in  2012
# -------------------------------------------------------
NCTE <- Stud.Admin[Stud.Admin$schoolyear_sp == "2012" & Stud.Admin$test_grade == 4, c("nctesid", "class_id_m", "nctetid", "schoolid", "district", 
                                                                                      "schoolyear_sp",   
                                                                                      "test_grade",       
                                                                                      "test_grade_tm1",  
                                                                                      "s_state_std_m", 
                                                                                      "s_state_std_m_tm1",
                                                                                      "s_state_std_e_tm1",
                                                                                      "s_male",           
                                                                                      "s_frpl",           
                                                                                      "daysattended",     
                                                                                      "_Cclass_size",     
                                                                                      "_Cs_male",         
                                                                                      "_Cs_frpl",         
                                                                                      "_Sschool_size")]  


# Faketucky dataset cleaning

#setwd("C:/Users/coh334/Google Drive/Other/CEPR/Open SDP/Statistical Power/Possible Data Files/faketucky-master")
load("faketucky.rda")
# rename as "faketucky" and remove the original
faketucky <- faketucky_20160923
remove(faketucky_20160923)
faketucky$pct_absent_in_ms <- faketucky$pct_absent_in_hs

Sylvan <- faketucky[faketucky$first_hs_name == "Sylvan" | faketucky$first_hs_name == "Fawzi" , c("sid", "pct_absent_in_ms", "male", "race_ethnicity", "frpl_ever_in_hs", "sped_ever_in_hs", "lep_ever_in_hs", "scale_score_8_read", "scale_score_8_math") ]
names(Sylvan) <- c("sid", "pct_absent_in_ms", "male", "race_ethnicity", "frpl", "sped", "lep", "scale_score_8_read", "scale_score_8_math")

# suppose there are 75 sections of math
set.seed(5)
Sylvan$ClassroomID <- sample(1:75, dim(Sylvan)[1], replace = TRUE)

head(Sylvan)




setwd("C:/Users/coh334/Google Drive/Other/CEPR/Open SDP/Statistical Power/Sample Size Draft3 Markdown")
save(NCTE, Sylvan, file = "Sample Size Tutorial Datasets.Rdata")
