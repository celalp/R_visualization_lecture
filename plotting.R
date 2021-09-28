

# install dependencies
install.packages(c("ggplot2", "pheatmap", "dplyr", "patchwork", "viridis"))

# load packages
library(ggplot2)
library(patchwork)
library(pheatmap)
library(dplyr)

# load data
data(diamonds)
head(diamonds)
summary(diamonds)

# empty plot
ggplot()

# add data
ggplot(data=diamonds)

# add aesthetics (changes with plot type)
ggplot(data=diamonds, aes(x=carat, y=price))

# add type of plot (scatter)
ggplot(data=diamonds, aes(x=carat, y=price))+geom_point()

# alternative way to describing the plot
ggplot()+geom_point(data=diamonds, aes(x=carat, y=price))

# color by clarity
ggplot()+geom_point(data=diamonds, aes(x=carat, y=price, color=clarity))

# color by clarity, shape by cut
ggplot()+geom_point(data=diamonds, aes(x=carat, y=price, color=clarity, shape=cut))

#other types of plots

# boxplot
ggplot(data=diamonds, aes(x=clarity, y=price))+geom_boxplot()

#color and fill by cut
ggplot(data=diamonds, aes(x=clarity, y=price, color=cut))+geom_boxplot()
ggplot(data=diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()

# violin
ggplot(data=diamonds, aes(x=clarity, y=price))+geom_violin()
ggplot(data=diamonds, aes(x=clarity, y=price, fill=cut))+geom_violin()

#histogram
ggplot(data=diamonds, aes(x=price))+geom_histogram()
ggplot(data=diamonds, aes(x=cut))+geom_histogram(stat="count")

diamonds_count<-diamonds %>%
  group_by(cut)%>%
  count()

diamonds_count
ggplot(data=diamonds_count, aes(x=cut, y=n))+geom_bar(stat="identity")

diamonds_count2<-diamonds %>%
  group_by(cut, clarity)%>%
  count()

# barplot
ggplot(data=diamonds_count2, aes(x=cut, y=n, fill=clarity))+geom_bar(stat="identity")
ggplot(data=diamonds_count2, aes(x=cut, y=n, fill=clarity))+geom_bar(position="fill", stat = "identity")
ggplot(data=diamonds_count2, aes(x=cut, y=n, fill=clarity))+geom_bar(position="dodge", stat = "identity")


# text
data(mtcars)
head(mtcars)
summary(mtcars)

ggplot(data=mtcars, aes(x=mpg, y=hp, label=cyl))+geom_text()

# density
ggplot(diamonds, aes(x=price))+geom_density()
ggplot(diamonds, aes(x=price, color=cut))+geom_density()
ggplot(diamonds, aes(x=price, fill=cut))+geom_density()
ggplot(diamonds, aes(x=price, fill=cut))+geom_density(alpha=0.2)


# 2D density
ggplot(data=diamonds, aes(x=depth, y=table))+geom_density2d()
ggplot(data=diamonds, aes(x=depth, y=table, color=cut))+geom_density2d()

# boxplot and scatter

ggplot(diamonds, aes(x=clarity, y=price))+geom_boxplot()+geom_jitter(alpha=0.05)
ggplot(diamonds, aes(x=clarity, y=price, color=cut))+geom_point(position = position_jitterdodge())

ggplot(diamonds, aes(x=clarity, y=price, color=cut, fill=cut))+geom_point(position = position_jitterdodge(), alpha=0.1)+geom_boxplot()
ggplot()+geom_boxplot(data=diamonds, aes(x=clarity, y=price, fill=cut))+
  geom_point(data=diamonds, aes(x=clarity, y=price, color=cut), position=position_jitterdodge(), alpha=0.05)


# modifiying the plot

ggplot(diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()

# add title and change axis labels
ggplot(diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()+ggtitle("Awesome diamonds")

ggplot(diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()+ggtitle("Awesome diamonds")+
  ylab("Price of diamonds in USD ($)")+xlab("Clarity of the diamond")

# move the legend
ggplot(diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()+ggtitle("Awesome diamonds")+
  ylab("Price of diamonds in USD ($)")+xlab("Clarity of the diamond")+
  theme(legend.position = "bottom")

# scale y axis by log2
ggplot(diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()+ggtitle("Awesome diamonds")+
  ylab("Price of diamonds in USD ($)")+xlab("Clarity of the diamond")+
  theme(legend.position = "bottom")+scale_y_log10()

# more elaborate modifications to y
ggplot(diamonds, aes(x=clarity, y=log10(price)*2/pi, fill=cut))+geom_boxplot()+ggtitle("Awesome diamonds")+
  ylab("Price of diamonds in USD ($)")+xlab("Clarity of the diamond")+
  theme(legend.position = "bottom")

# switch coordinates
ggplot(diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()+ggtitle("Awesome diamonds")+
  ylab("Price of diamonds in USD ($)")+xlab("Clarity of the diamond")+
  theme(legend.position = "bottom")+coord_flip()

# change palette 
# see http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/ for more info on colors

ggplot(diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()+ggtitle("Awesome diamonds")+
  ylab("Price of diamonds in USD ($)")+xlab("Clarity of the diamond")+
  theme(legend.position = "bottom")+scale_fill_brewer(palette = "Set1")

ggplot(diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()+ggtitle("Awesome diamonds")+
  ylab("Price of diamonds in USD ($)")+xlab("Clarity of the diamond")+
  theme(legend.position = "bottom")+scale_fill_manual(values=c("red", "blue", "green", "black", "orange"))

# color by continuous variable
ggplot(diamonds, aes(x=clarity, y=price, color=carat))+geom_jitter()+
  scale_color_gradient2(low="navy", mid="white", high = "red")

ggplot(diamonds, aes(x=clarity, y=carat, color=price))+geom_jitter()+
  scale_color_gradient2(low="navy", mid="white", high = "red", midpoint = mean(diamonds$price))

# see https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html for more info on viridis
library(viridis)

ggplot(diamonds, aes(x=clarity, y=carat, color=price))+geom_jitter()+
  scale_color_viridis_c()


#themes

ggplot(diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()+ggtitle("Awesome diamonds")+
  ylab("Price of diamonds in USD ($)")+xlab("Clarity of the diamond")+
  theme(legend.position = "bottom")+scale_fill_brewer(palette = "Set1")+theme_dark()

ggplot(diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()+ggtitle("Awesome diamonds")+
  ylab("Price of diamonds in USD ($)")+xlab("Clarity of the diamond")+
  theme(legend.position = "bottom")+scale_fill_brewer(palette = "Set1")+theme_linedraw()

ggplot(diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()+ggtitle("Awesome diamonds")+
  ylab("Price of diamonds in USD ($)")+xlab("Clarity of the diamond")+
  theme(legend.position = "bottom")+scale_fill_brewer(palette = "Set1")+theme_void()

ggplot(diamonds, aes(x=clarity, y=price, fill=cut))+geom_boxplot()+ggtitle("Awesome diamonds")+
  ylab("Price of diamonds in USD ($)")+xlab("Clarity of the diamond")+
  theme(legend.position = "bottom")+scale_fill_brewer(palette = "Set1")+theme_minimal()

# additional annotations

ggplot(diamonds, aes(x=carat, y=price))+geom_point()+
  ylim(10000, 15000)

ggplot(diamonds, aes(x=carat, y=price))+geom_point()+
  geom_hline(yintercept = c(5000, 10000), color="red", linetype="dashed")

ggplot(diamonds, aes(x=carat, y=price))+geom_point()+
  geom_hline(yintercept = c(5000, 10000), color="red", linetype="dashed")+
  geom_vline(xintercept = c(1,2), color="blue", linetype="dotdash")

ggplot(diamonds, aes(x=carat, y=price))+geom_point()+
  geom_rect(xmin=1, xmax=2, ymin=5000, ymax=10000, alpha=0.05, color="goldenrod", fill="goldenrod")


# add a specific line to the plot
ggplot(diamonds, aes(x=carat, y=price))+geom_point()+geom_abline(slope = 400, intercept = 0)

# add a regression lines to the plot
ggplot(diamonds, aes(x=carat, y=price))+geom_point()+geom_smooth(method="lm")
ggplot(diamonds, aes(x=carat, y=price, color=clarity))+geom_point()+geom_smooth(method="lm")


#facets

ggplot(diamonds, aes(x=carat, y=price, color=clarity))+geom_point()+facet_wrap(.~cut)
ggplot(diamonds, aes(x=carat, y=price, color=clarity))+geom_point()+facet_wrap(.~cut, ncol=5)
ggplot(diamonds, aes(x=carat, y=price, color=clarity))+geom_point()+facet_wrap(.~cut, nrow=1)

ggplot(diamonds, aes(x=carat, y=price, color=clarity))+geom_point()+facet_wrap(clarity~cut)
ggplot(diamonds, aes(x=carat, y=price, color=clarity))+geom_point()+facet_grid(clarity~cut)


# see #https://patchwork.data-imaginist.com/index.html for more info on patchwork
library(patchwork)

plot1<-ggplot(diamonds, aes(x=cut, y=price, color=color))+geom_boxplot()
plot2<-ggplot(diamonds, aes(x=color, y=price, color=clarity))+geom_boxplot()

plot1+plot2
plot1/plot2

plot3<-ggplot(mtcars, aes(x=cyl, y=mpg))+geom_point()

(plot1/plot2)-plot3
(plot1+plot2)/plot3

(plot1/plot2)-plot3+plot_annotation(title="This is going to be published in nature", subtitle = "but not really")

(plot1/plot2)-plot3+plot_layout(guides="collect")

(plot1/plot2)-plot3+plot_layout(guides="collect", widths = c(2,1))

plot4<-ggplot(mtcars, aes(x=cyl, y=wt, color=gear))+geom_point()

layout<-"
#AAAACC
BBBBBD#
BBBBBD#
"

plot1+plot2+plot3+plot4+plot_layout(guides = "collect", design = layout)



library(pheatmap)

expression_data<-read.table("r-sample-data.2020.txt", header = T, sep = "\t")
head(expression_data)
expression_matrix<-as.matrix(expression_data[, -c(1,2)])
# add rownames
rownames(expression_matrix)<-expression_data$Probe

pheatmap(expression_matrix)

pheatmap(expression_matrix, fontsize_row = 6, fontsize_col = 6)

pheatmap(expression_matrix, fontsize_row = 6, fontsize_col = 6, cluster_rows = F)

pheatmap(expression_matrix, fontsize_row = 6, fontsize_col = 6, 
         color = colorRampPalette(  c('navy', 'white', 'firebrick4'))(100))

pheatmap(expression_matrix, fontsize_row = 6, fontsize_col = 8, 
         color = colorRampPalette(  c('navy', 'white', 'firebrick4'))(100), 
         treeheight_row = 0)

#annotation cols create the data frame
annotation_col<-data.frame(treatment_group=case_when(grepl("c", colnames(expression_data[, -c(1,2)])) ~ "control", 
                                           grepl("d", colnames(expression_data[, -c(1,2)])) ~ "group1", 
                                           grepl("u", colnames(expression_data[, -c(1,2)])) ~ "group2"), 
                           genotype=ifelse(as.integer(gsub("[a-z]", "", colnames(expression_data[, -c(1,2)]))) %% 2 ==0, "KO", "WT")
)

# add rownames to the annotaiton columns, they MUST match the names of the samples (rows of the expression matrix)
rownames(annotation_col)<-colnames(expression_data[, -c(1,2)])

pheatmap(expression_matrix, fontsize_row = 6, fontsize_col = 8, 
         color = colorRampPalette(  c('navy', 'white', 'firebrick4'))(100), 
         treeheight_row = 0, annotation_col = annotation_col)

pheatmap(expression_matrix, fontsize_row = 8, fontsize_col = 8, show_rownames = T, 
         color = colorRampPalette(  c('navy', 'white', 'firebrick4'))(100), 
         treeheight_row = 0, annotation_col = annotation_col, clustering_distance_cols = "euclidean", 
         clustering_distance_rows = "manhattan")



#programmatically saving plots advanced

ggplot(expression_data, aes(x=c155))+geom_density()+ggtitle(paste("sample:", "c155"))

samples<-colnames(expression_data)[-c(1,2)]
dir.create("./plots")

for(sample in samples){
  expression_plot<-ggplot(expression_data, aes_string(x=sample))+geom_density()+ggtitle(paste("Sample:", sample))
  pdf(file=paste0("./plots/", sample, ".pdf"))
  print(expression_plot)
  dev.off()
}

pdf(file="./plots/combined.pdf", height = 6, width = 8)
for(sample in samples){
  expression_plot<-ggplot(expression_data, aes_string(x=sample))+geom_density()+ggtitle(paste("Sample:", sample))
  print(expression_plot)
}
dev.off()












