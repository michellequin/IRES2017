## UTILS

# computation of the standard error of the mean
sem <- function(x) result <- sd(x)/sqrt(length(x))
# 95% confidence intervals of the mean
ciLow <- function(x) mean(x)-2*sem(x)
ciUp <- function(x) mean(x)+2*sem(x)

## PREPARATION

# remove timestamp column (first column)
#sed -i 's/^[^,]*,//' <NAME>.csv
demographic <- read.csv("demographic.csv")
ratings <- read.csv("parameter_feedback.csv")

# ratings$modality TODO 1-9, A-P -> 25
get_modality <- function(x) { 
	if(x == '1' | x == '2' | x == '3' | x == '4' | x == '5' | x == '8' | x == '9' | x == 'A' | x == 'B' | x == 'E' | x == 'F' | x == 'G' | x == 'H' | x == 'K' | x == 'L' | x == 'O') y <- "audio"
	if(x == '6' | x == '7' | x == 'C' | x == 'D' | x == 'I' | x == 'J' | x == 'M' | x == 'N' | x == 'P') y <- "vibration"
	return(y)
}
# applying function to data frame
ratings$modality <- factor(sapply(ratings$cue,get_modality))

# ratings$cue proper names TODO 1-9, A-P -> 25
get_name <- function(x) { 
	if(x == '1') y <- "50hz (A)"
	if(x == '2') y <- "200hz (A)"
	if(x == '3') y <- "750hz (A)"
	if(x == '4') y <- "200hz/1000hz (A)"
	if(x == '5') y <- "500hz/50hz (A)"
	if(x == '6') y <- "200% Int (V)"
	if(x == '7') y <- "75% Int (V)"
	if(x == '8') y <- "200hz/50hz/500hz (A)"
	if(x == '9') y <- "1000hz/500hz/50hz (A)"
	if(x == 'A') y <- "Harmonic Up (A)"
	if(x == 'B') y <- "Harmonic Down (A)"
	if(x == 'C') y <- "750ms Gap Dur (V)"
	if(x == 'D') y <- "100ms Gap Dur (V)"
	if(x == 'E') y <- "750ms Dur (A)"
	if(x == 'F') y <- "100ms Dur (A)"
	if(x == 'G') y <- "500ms/50ms Rate Dur (A)"
	if(x == 'H') y <- "100ms/250ms Rate Dur (A)"
	if(x == 'I') y <- "1000ms Dur (V)"
	if(x == 'J') y <- "100ms Dur (V)"
	if(x == 'K') y <- "100ms Rate (A)"
	if(x == 'L') y <- "750ms Rate (A)"
	if(x == 'M') y <- "250ms/500ms Rate (V)"
	if(x == 'N') y <- "750ms/100ms Rate (V)"
	if(x == 'O') y <- "Rhythm (A)"
	if(x == 'P') y <- "Rhythm (V)"
	return(y)
}
# applying function to data frame
ratings$cue <- factor(sapply(ratings$cue,get_name))

## DEMOGRAPHIC
summary(demographic)
#  participant        age           gender  hearing_disability handedness
# Min.   : 1.0   Min.   :21.00   Female:3   No:11              Left : 1  
# 1st Qu.: 3.5   1st Qu.:23.50   Male  :8                      Right:10  
# Median : 6.0   Median :27.00                                           
# Mean   : 6.0   Mean   :26.64                                           
# 3rd Qu.: 8.5   3rd Qu.:29.50                                           
# Max.   :11.0   Max.   :34.00                                           
mean(demographic$age)
#[1] 26.63636
sd(demographic$age)
#[1] 4.225464

## PLOTS
summary(ratings)
#  participant      cue         urgency        perception     distraction   
# Min.   : 1   1      : 11   Min.   :1.000   Min.   :1.000   Min.   :1.000  
# 1st Qu.: 3   2      : 11   1st Qu.:3.000   1st Qu.:4.000   1st Qu.:3.000  
# Median : 6   3      : 11   Median :4.000   Median :5.000   Median :4.000  
# Mean   : 6   4      : 11   Mean   :3.513   Mean   :4.538   Mean   :3.458  
# 3rd Qu.: 9   5      : 11   3rd Qu.:4.000   3rd Qu.:5.000   3rd Qu.:4.000  
# Max.   :11   6      : 11   Max.   :5.000   Max.   :5.000   Max.   :5.000  
#              (Other):209                                                  
#  alarmingness   discomfort_pain
# Min.   :1.000   Min.   :1.000  
# 1st Qu.:2.500   1st Qu.:1.000  
# Median :3.000   Median :2.000  
# Mean   :3.345   Mean   :2.138  
# 3rd Qu.:4.000   3rd Qu.:3.000  
# Max.   :5.000   Max.   :5.000  

# alarmingness
pdf("alarmingness_cue.pdf", width=8)
with(ratings, boxplot(alarmingness ~ cue, notch=F, ylim=c(0,5), ylab="alarmingness",xlab="cue"))
dev.off()

# distraction
pdf("distraction.pdf", width=8)
with(ratings, boxplot(distraction ~ cue, notch=F, ylim=c(0,5), ylab="distraction",xlab="cue"))
dev.off()

# perception
pdf("perception_cue.pdf", width=8)
with(ratings, boxplot(perception ~ cue, notch=F, ylim=c(0,5), ylab="perception",xlab="cue"))
dev.off()

# discomfort_pain
pdf("discomfort_pain_cue.pdf", width=8)
with(ratings, boxplot(discomfort_pain ~ cue, notch=F, ylim=c(0,5), ylab="discomfort_pain",xlab="cue"))
dev.off()

# urgency
pdf("urgency_cue.pdf", width=8)
with(ratings, boxplot(urgency ~ cue, notch=F, ylim=c(0,5), ylab="urgency",xlab="cue"))
dev.off()

# fancy plot
library(ggplot2)

#ggplot(data = gaze.reactiontime, aes(x = reorder(cue, mean(urgency)), y = mean(urgency), fill = cue)) +
urgency_cue.plot <- ggplot(ratings, aes(reorder(factor(cue), urgency), urgency)) + #factor(cue)
	#geom_bar(stat= "identity", position = position_dodge(), alpha = 0.8) +
	#geom_point(aes(shape="2"), size=5)+
	#geom_errorbar(aes(ymin = ciLow(urgency), ymax = ciUp(urgency)), width = .3, size = .3, position = position_dodge(0)) +
	#geom_hline(yintercept=3, linetype="longdash", color = "black", alpha = 0.6)+  # overall mean
	geom_boxplot(notch=F) +
	ylim(0,5) +
	scale_fill_grey(start = 0.4, end = 0.8) +
	theme_bw(base_size = 20) +
	theme(legend.position = "none", axis.text=element_text(size=14), axis.title=element_text(size=23,face="bold"), axis.text.x=element_text(angle=45, hjust=1), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) + 
	#geom_signif(data = df.corrected, comparisons = list(c("1", "2")), test = "wilcox.test", test.args = list(paired = T), map_signif_level = T, textsize = 5, step_increase=0.1) +
	ylab("Urgency") +
	xlab("Cue") # +
	#ggtitle("Title")
pdf("urgency_cue_fancy.pdf", width = 12, height = 7)
urgency_cue.plot
dev.off()

# mean, sd, sem, ciUp, ciLow
urgency.mean.data <- cbind(cue = unique(ratings$cue), data.frame(mean = tapply(ratings$urgency, ratings$cue, mean), sd = tapply(ratings$urgency, ratings$cue, sd), sem = tapply(ratings$urgency, ratings$cue, sem), ciUp = tapply(ratings$urgency, ratings$cue, ciUp), ciLow = tapply(ratings$urgency, ratings$cue, ciLow)))

urgency_cue.plot.mean <- ggplot(data = urgency.mean.data, aes(x = reorder(cue, mean), y = mean, fill = cue)) +
	geom_bar(stat= "identity", position = position_dodge(), alpha = 0.8) +
	#geom_point(aes(shape="2"), size=5) +
	geom_errorbar(aes(ymin = ciLow, ymax = ciUp), width = .3, size = .3, position = position_dodge(0)) +
	#geom_hline(yintercept=3.512727, linetype="longdash", color = "black", alpha = 0.6) +  # overall mean
	ylim(0,5) +
	scale_fill_grey(start = 0.4, end = 0.8) +
	theme_bw(base_size = 20) +
	theme(legend.position = "none", axis.text=element_text(size=12), axis.title=element_text(size=23,face="bold"), axis.text.x=element_text(angle=45, hjust=1), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) + 
	#geom_signif(data = df.corrected, comparisons = list(c("1", "2")), test = "wilcox.test", test.args = list(paired = T), map_signif_level = T, textsize = 5, step_increase=0.1) +
	ylab("Urgency") +
	xlab("Cue")
pdf("urgency_cue_mean_fancy.pdf", width = 12, height = 8)
urgency_cue.plot.mean
dev.off()

##alarmingness
#ggplot(data = gaze.reactiontime, aes(x = reorder(cue, mean(alarmingness)), y = mean(alarmingness), fill = cue)) +
alarmingness_cue.plot <- ggplot(ratings, aes(reorder(factor(cue), alarmingness), alarmingness)) + #factor(cue)
  #geom_bar(stat= "identity", position = position_dodge(), alpha = 0.8) +
  #geom_point(aes(shape="2"), size=5)+
  #geom_errorbar(aes(ymin = ciLow(alarmingness), ymax = ciUp(alarmingness)), width = .3, size = .3, position = position_dodge(0)) +
  #geom_hline(yintercept=3, linetype="longdash", color = "black", alpha = 0.6)+  # overall mean
  geom_boxplot(notch=F) +
  ylim(0,5) +
  scale_fill_grey(start = 0.4, end = 0.8) +
  theme_bw(base_size = 20) +
  theme(legend.position = "none", axis.text=element_text(size=14), axis.title=element_text(size=23,face="bold"), axis.text.x=element_text(angle=45, hjust=1), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) + 
  #geom_signif(data = df.corrected, comparisons = list(c("1", "2")), test = "wilcox.test", test.args = list(paired = T), map_signif_level = T, textsize = 5, step_increase=0.1) +
  ylab("Alarmingness") +
  xlab("Cue") # +
#ggtitle("Title")
pdf("alarmingness_cue_fancy.pdf", width = 12, height = 7)
alarmingness_cue.plot
dev.off()

# mean, sd, sem, ciUp, ciLow
alarmingness.mean.data <- cbind(cue = unique(ratings$cue), data.frame(mean = tapply(ratings$alarmingness, ratings$cue, mean), sd = tapply(ratings$alarmingness, ratings$cue, sd), sem = tapply(ratings$alarmingness, ratings$cue, sem), ciUp = tapply(ratings$alarmingness, ratings$cue, ciUp), ciLow = tapply(ratings$alarmingness, ratings$cue, ciLow)))

alarmingness_cue.plot.mean <- ggplot(data = alarmingness.mean.data, aes(x = reorder(cue, mean), y = mean, fill = cue)) +
  geom_bar(stat= "identity", position = position_dodge(), alpha = 0.8) +
  #geom_point(aes(shape="2"), size=5) +
  geom_errorbar(aes(ymin = ciLow, ymax = ciUp), width = .3, size = .3, position = position_dodge(0)) +
  #geom_hline(yintercept=3.512727, linetype="longdash", color = "black", alpha = 0.6) +  # overall mean
  ylim(0,5) +
  scale_fill_grey(start = 0.4, end = 0.8) +
  theme_bw(base_size = 20) +
  theme(legend.position = "none", axis.text=element_text(size=12), axis.title=element_text(size=23,face="bold"), axis.text.x=element_text(angle=45, hjust=1), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) + 
  #geom_signif(data = df.corrected, comparisons = list(c("1", "2")), test = "wilcox.test", test.args = list(paired = T), map_signif_level = T, textsize = 5, step_increase=0.1) +
  ylab("Alarmingness") +
  xlab("Cue")
pdf("alarmingness_cue_mean_fancy.pdf", width = 12, height = 8)
alarmingness_cue.plot.mean
dev.off()

##perception
#ggplot(data = gaze.reactiontime, aes(x = reorder(cue, mean(perception)), y = mean(perception), fill = cue)) +
perception_cue.plot <- ggplot(ratings, aes(reorder(factor(cue), perception), perception)) + #factor(cue)
  #geom_bar(stat= "identity", position = position_dodge(), alpha = 0.8) +
  #geom_point(aes(shape="2"), size=5)+
  #geom_errorbar(aes(ymin = ciLow(perception), ymax = ciUp(perception)), width = .3, size = .3, position = position_dodge(0)) +
  #geom_hline(yintercept=3, linetype="longdash", color = "black", alpha = 0.6)+  # overall mean
  geom_boxplot(notch=F) +
  ylim(0,5) +
  scale_fill_grey(start = 0.4, end = 0.8) +
  theme_bw(base_size = 20) +
  theme(legend.position = "none", axis.text=element_text(size=14), axis.title=element_text(size=23,face="bold"), axis.text.x=element_text(angle=45, hjust=1), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) + 
  #geom_signif(data = df.corrected, comparisons = list(c("1", "2")), test = "wilcox.test", test.args = list(paired = T), map_signif_level = T, textsize = 5, step_increase=0.1) +
  ylab("perception") +
  xlab("Cue") # +
#ggtitle("Title")
pdf("perception_cue_fancy.pdf", width = 12, height = 7)
perception_cue.plot
dev.off()

# mean, sd, sem, ciUp, ciLow
perception.mean.data <- cbind(cue = unique(ratings$cue), data.frame(mean = tapply(ratings$perception, ratings$cue, mean), sd = tapply(ratings$perception, ratings$cue, sd), sem = tapply(ratings$perception, ratings$cue, sem), ciUp = tapply(ratings$perception, ratings$cue, ciUp), ciLow = tapply(ratings$perception, ratings$cue, ciLow)))

perception_cue.plot.mean <- ggplot(data = perception.mean.data, aes(x = reorder(cue, mean), y = mean, fill = cue)) +
  geom_bar(stat= "identity", position = position_dodge(), alpha = 0.8) +
  #geom_point(aes(shape="2"), size=5) +
  geom_errorbar(aes(ymin = ciLow, ymax = ciUp), width = .3, size = .3, position = position_dodge(0)) +
  #geom_hline(yintercept=3.512727, linetype="longdash", color = "black", alpha = 0.6) +  # overall mean
  ylim(0,5) +
  scale_fill_grey(start = 0.4, end = 0.8) +
  theme_bw(base_size = 20) +
  theme(legend.position = "none", axis.text=element_text(size=12), axis.title=element_text(size=23,face="bold"), axis.text.x=element_text(angle=45, hjust=1), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) + 
  #geom_signif(data = df.corrected, comparisons = list(c("1", "2")), test = "wilcox.test", test.args = list(paired = T), map_signif_level = T, textsize = 5, step_increase=0.1) +
  ylab("perception") +
  xlab("Cue")
pdf("perception_cue_mean_fancy.pdf", width = 12, height = 8)
perception_cue.plot.mean
dev.off()

##discomfort_pain
#ggplot(data = gaze.reactiontime, aes(x = reorder(cue, mean(discomfort_pain)), y = mean(discomfort_pain), fill = cue)) +
discomfort_pain_cue.plot <- ggplot(ratings, aes(reorder(factor(cue), discomfort_pain), discomfort_pain)) + #factor(cue)
  #geom_bar(stat= "identity", position = position_dodge(), alpha = 0.8) +
  #geom_point(aes(shape="2"), size=5)+
  #geom_errorbar(aes(ymin = ciLow(discomfort_pain), ymax = ciUp(discomfort_pain)), width = .3, size = .3, position = position_dodge(0)) +
  #geom_hline(yintercept=3, linetype="longdash", color = "black", alpha = 0.6)+  # overall mean
  geom_boxplot(notch=F) +
  ylim(0,5) +
  scale_fill_grey(start = 0.4, end = 0.8) +
  theme_bw(base_size = 20) +
  theme(legend.position = "none", axis.text=element_text(size=14), axis.title=element_text(size=23,face="bold"), axis.text.x=element_text(angle=45, hjust=1), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) + 
  #geom_signif(data = df.corrected, comparisons = list(c("1", "2")), test = "wilcox.test", test.args = list(paired = T), map_signif_level = T, textsize = 5, step_increase=0.1) +
  ylab("discomfort_pain") +
  xlab("Cue") # +
#ggtitle("Title")
pdf("discomfort_pain_cue_fancy.pdf", width = 12, height = 7)
discomfort_pain_cue.plot
dev.off()

# mean, sd, sem, ciUp, ciLow
discomfort_pain.mean.data <- cbind(cue = unique(ratings$cue), data.frame(mean = tapply(ratings$discomfort_pain, ratings$cue, mean), sd = tapply(ratings$discomfort_pain, ratings$cue, sd), sem = tapply(ratings$discomfort_pain, ratings$cue, sem), ciUp = tapply(ratings$discomfort_pain, ratings$cue, ciUp), ciLow = tapply(ratings$discomfort_pain, ratings$cue, ciLow)))

discomfort_pain_cue.plot.mean <- ggplot(data = discomfort_pain.mean.data, aes(x = reorder(cue, mean), y = mean, fill = cue)) +
  geom_bar(stat= "identity", position = position_dodge(), alpha = 0.8) +
  #geom_point(aes(shape="2"), size=5) +
  geom_errorbar(aes(ymin = ciLow, ymax = ciUp), width = .3, size = .3, position = position_dodge(0)) +
  #geom_hline(yintercept=3.512727, linetype="longdash", color = "black", alpha = 0.6) +  # overall mean
  ylim(0,5) +
  scale_fill_grey(start = 0.4, end = 0.8) +
  theme_bw(base_size = 20) +
  theme(legend.position = "none", axis.text=element_text(size=12), axis.title=element_text(size=23,face="bold"), axis.text.x=element_text(angle=45, hjust=1), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) + 
  #geom_signif(data = df.corrected, comparisons = list(c("1", "2")), test = "wilcox.test", test.args = list(paired = T), map_signif_level = T, textsize = 5, step_increase=0.1) +
  ylab("discomfort_pain") +
  xlab("Cue")
pdf("discomfort_pain_cue_mean_fancy.pdf", width = 12, height = 8)
discomfort_pain_cue.plot.mean
dev.off()

##distraction
#ggplot(data = gaze.reactiontime, aes(x = reorder(cue, mean(distraction)), y = mean(distraction), fill = cue)) +
distraction_cue.plot <- ggplot(ratings, aes(reorder(factor(cue), distraction), distraction)) + #factor(cue)
  #geom_bar(stat= "identity", position = position_dodge(), alpha = 0.8) +
  #geom_point(aes(shape="2"), size=5)+
  #geom_errorbar(aes(ymin = ciLow(distraction), ymax = ciUp(distraction)), width = .3, size = .3, position = position_dodge(0)) +
  #geom_hline(yintercept=3, linetype="longdash", color = "black", alpha = 0.6)+  # overall mean
  geom_boxplot(notch=F) +
  ylim(0,5) +
  scale_fill_grey(start = 0.4, end = 0.8) +
  theme_bw(base_size = 20) +
  theme(legend.position = "none", axis.text=element_text(size=14), axis.title=element_text(size=23,face="bold"), axis.text.x=element_text(angle=45, hjust=1), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) + 
  #geom_signif(data = df.corrected, comparisons = list(c("1", "2")), test = "wilcox.test", test.args = list(paired = T), map_signif_level = T, textsize = 5, step_increase=0.1) +
  ylab("distraction") +
  xlab("Cue") # +
#ggtitle("Title")
pdf("distraction_cue_fancy.pdf", width = 12, height = 7)
distraction_cue.plot
dev.off()

# mean, sd, sem, ciUp, ciLow
distraction.mean.data <- cbind(cue = unique(ratings$cue), data.frame(mean = tapply(ratings$distraction, ratings$cue, mean), sd = tapply(ratings$distraction, ratings$cue, sd), sem = tapply(ratings$distraction, ratings$cue, sem), ciUp = tapply(ratings$distraction, ratings$cue, ciUp), ciLow = tapply(ratings$distraction, ratings$cue, ciLow)))

distraction_cue.plot.mean <- ggplot(data = distraction.mean.data, aes(x = reorder(cue, mean), y = mean, fill = cue)) +
  geom_bar(stat= "identity", position = position_dodge(), alpha = 0.8) +
  #geom_point(aes(shape="2"), size=5) +
  geom_errorbar(aes(ymin = ciLow, ymax = ciUp), width = .3, size = .3, position = position_dodge(0)) +
  #geom_hline(yintercept=3.512727, linetype="longdash", color = "black", alpha = 0.6) +  # overall mean
  ylim(0,5) +
  scale_fill_grey(start = 0.4, end = 0.8) +
  theme_bw(base_size = 20) +
  theme(legend.position = "none", axis.text=element_text(size=12), axis.title=element_text(size=23,face="bold"), axis.text.x=element_text(angle=45, hjust=1), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.background = element_blank()) + 
  #geom_signif(data = df.corrected, comparisons = list(c("1", "2")), test = "wilcox.test", test.args = list(paired = T), map_signif_level = T, textsize = 5, step_increase=0.1) +
  ylab("distraction") +
  xlab("Cue")
pdf("distraction_cue_mean_fancy.pdf", width = 12, height = 8)
distraction_cue.plot.mean
dev.off()

## TESTS

# homogenity
library(car)
with(ratings, leveneTest(y=urgency, group=as.factor(cue), center=mean))

# normality
with(ratings, shapiro.test(urgency))

# cue
friedman.test(urgency ~ cue | participant, data = ratings)
with(ratings, pairwise.wilcox.test(x=urgency,g=cue, p.adjust.method="holm", paired=T))

# modality
wilcox.test(urgency ~ modality, data = ratings, paired=T)



