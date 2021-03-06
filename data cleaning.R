#### Mise en place ###########################################################################################

# installing and loading packages
install.packages("meta")
library(meta)
library(metafor)
library(dplyr)

# load data from file
neet <- read.csv("~/Dropbox/PEPP/NEET meta-analysis/metaanalysis/neet 20200608.csv")

# write cleaned dataframe to file
write.csv(neet,'neet 20200616.csv')


#### Rederiving variables ######################################################################
# first written 2019 Oct 21

# fixing a value in the dataframe
neet$study_no <- as.character(neet$study_no)  # making this column into characters (were factors before)
neet[12,2] <- "bania 2019 6"  # adding the value that was missing
View(neet)

# re-deriving OR_ln in R
neet$OR_ln <- log(neet$OR)
View(neet)
class(neet$OR_ln)
head(neet$OR_ln)
str(neet)

# re-deriving lower_ln and upper_ln
class(neet$LowerCI)
neet$lower_ln <- log(neet$LowerCI)
neet$upper_ln <- log(neet$UpperCI)
str(neet)
View(neet)

# re-deriving SE [ (upper_ln - lower_ln) / 3.92 ]
class(neet$SE)
neet$SE <- ((neet$upper_ln-neet$lower_ln)/3.92)
class(neet$SE)
View(neet)
str(neet)

# making LowerCI_sens numeric

neet$LowerCI_sens <- as.numeric(neet$LowerCI_sens)
class(neet$LowerCI_sens)
str(neet)

#### Editing study names #####################################################################
# first written 2020 June 16-19

library(dplyr)

neet <- read.csv("~/Dropbox/PEPP/NEET meta-analysis/metaanalysis/neet 20201027.csv")
View(neet)
str(neet$Study)
levels(neet$Study)

levels(neet$Study) <- c("Baggio et al 2015",
                        "Bania et al 2019",
                        "Basta et al 2019",
                        "Benjet et al 2012", 
                        "Bynner & Parsons 2002",
                        "Gariépy & Iyer 2019",
                        "Goldman-Mellor et al 2016",
                        "Gutierrez-Garcia et al 2017",
                        "Gutierrez-Garcia et al 2018",
                        "Hale & Viner 2018",
                        "Hammerton et al 2019",
                        "Henderson et al 2017",
                        "López-López et al 2019",
                        "Manhica et al 2019",
                        "O'Dea et al 2014",
                        "O'Dea et al 2016", 
                        "Power et al 2015",
                        "Rodwell et al 2018",
                        "Stea, Abildsnes et al 2019",
                        "Stea, de Ridder et al 2019")

# removing that nogoodnik column of numbers, likely generated by R
neet <- select(neet, -X)

write.csv(neet,'neet 20210423.csv')


#### Adding study n's #####################################################################
# first written 2020 June 17

library(dplyr)

neet <- read.csv("~/Dropbox/PEPP/NEET meta-analysis/metaanalysis/neet 20200616.csv")
View(neet)
str(neet)
summary(neet)

# creating new column, N, and populating it with number of study participants
neet <- neet %>%
  mutate(N = NA)

neet <- neet %>%
  mutate(N=replace(N, Study=="Baggio et al 2015", 4758)) %>%
  mutate(N=replace(N, Study=="Bania et al 2019", 3987)) %>%
  mutate(N=replace(N, Study=="Basta et al 2019", 2771)) %>%
  mutate(N=replace(N, Study=="Benjet et al 2012", 3005)) %>%
  mutate(N=replace(N, Study=="Bynner et al 2002", 930)) %>%
  mutate(N=replace(N, Study=="Gariepy et al 2018", 5622)) %>%
  mutate(N=replace(N, Study=="Goldman-Mellor et al 2016", 2232)) %>%
  mutate(N=replace(N, Study=="Gutierrez-Garcia et al 2017", 1071)) %>%
  mutate(N=replace(N, Study=="Gutierrez-Garcia et al 2018", 1071)) %>%
  mutate(N=replace(N, Study=="Hale et al 2018", 8682)) %>%
  mutate(N=replace(N, study_no=="Hammerton 2019 1", 3939)) %>%
  mutate(N=replace(N, study_no=="Hammerton 2019 2", 5079)) %>%
  mutate(N=replace(N, Study=="Henderson et al 2017", 2576)) %>%
  mutate(N=replace(N, Study=="Lopez-Lopez et al 2019", 4501)) %>%
  mutate(N=replace(N, Study=="Manhica et al 2019", 485839)) %>%
  mutate(N=replace(N, Study=="O'Dea et al 2014", 676)) %>%
  mutate(N=replace(N, Study=="O'Dea et al 2016", 448)) %>%
  mutate(N=replace(N, Study=="Power et al 2015", 168)) %>%
  mutate(N=replace(N, Study=="Rodwell et al 2018", 1938)) %>%
  mutate(N=replace(N, Study=="Stea et al 2019a", 480)) %>%
  mutate(N=replace(N, Study=="Stea et al 2019b", 480))

# removing that nogoodnik column of numbers, likely generated by R
neet <- select(neet, -X)


write.csv(neet,'neet 20200617.csv')
