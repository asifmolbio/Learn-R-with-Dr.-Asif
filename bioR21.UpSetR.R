
#install.packages("UpSetR")


library(UpSetR)
outFile="intersectGenes2.txt"        #output intersection gene file
outPic="upset2.pdf"                  #outputimage
setwd("/Volumes/ANALYSIS & MEDIA/Dr. Asif's Mol. Biology/R/2") #seting working dir


files=dir()                          #retrieve all files from directory
files=grep("txt$",files,value=T)     #Extracting all files ending with .txt
geneList=list()

#Saving the genetic informaton to geneList
for(i in 1:length(files)){
    inputFile=files[i]
	if(inputFile==outFile){next}
    rt=read.table(inputFile,header=F)         #read input file
    geneNames=as.vector(rt[,1])               #extract gene names
    geneNames=gsub("^ | $","",geneNames)      #removing spaces at the begin and end
    uniqGene=unique(geneNames)                #unique gene selction, unique gene list
    header=unlist(strsplit(inputFile,"\\.|\\-"))
    geneList[[header[1]]]=uniqGene
    uniqLength=length(uniqGene)
    print(paste(header[1],uniqLength,sep=" "))
}

#drawUpSet diagram
upsetData=fromList(geneList)
pdf(file=outPic,onefile = FALSE,width=9,height=6)
upset(upsetData,
      nsets = length(geneList),               #How many data are displayed
      nintersects = 50,                       #display the number of gene sets
      order.by = "freq",                      #sorting by number
      show.numbers = "yes",                   #is the numerical values displayed above the chart
      number.angles = 20,                     #Font angle
      point.size = 2,                         #point size
      matrix.color="red",                     #interaction point color
      line.size = 0.8,                        #Thick lines\
      mainbar.y.label = "Gene Intersections", 
      sets.x.label = "Set Size")
dev.off()

#saving interasection file 
intersectGenes=Reduce(intersect,geneList)
write.table(file=outFile,intersectGenes,sep="\t",quote=F,col.names=F,row.names=F)


