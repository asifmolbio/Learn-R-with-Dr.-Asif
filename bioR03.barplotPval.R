

#install.packages("ggplot2")


#Three columns of information
#Term: GO names
#Count:Number of genes enriched
#FDR: FDD corrected


library(ggplot2)
setwd("/Volumes/ANALYSIS & MEDIA/Dr. Asif's Mol. Biology/R/1")

inputFile="input.txt"     #Input File
outFile="barplot3.pdf"     #Output File

rt = read.table(inputFile, header=T, sep="\t", check.names=F)     #read

#sorting by FDR
labels=rt[order(rt$FDR,decreasing =T),"Term"]
rt$Term = factor(rt$Term,levels=labels)

#Drawing
p=ggplot(data=rt)+geom_bar(aes(x=Term, y=Count, fill=FDR), stat='identity')+
    coord_flip() + scale_fill_gradient(low="red", high = "blue")+ 
    xlab("Term") + ylab("Gene count") + 
    theme(axis.text.x=element_text(color="black", size=10),axis.text.y=element_text(color="black", size=10)) + 
    scale_y_continuous(expand=c(0, 0)) + scale_x_discrete(expand=c(0,0))+
    theme_bw()
ggsave(outFile,width=7,height=5)      #saving image


