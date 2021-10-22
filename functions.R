
my_print<-function(label,fit,all_obs,l){
  str2<-paste(label,"=")
  for( i in c(1:(length(fit[1,])/2))*2-1 ){
    if (!is.na(fit[1,i]))
      str2 <- paste(str2,"  ",mean_print(fit[1,i],fit[1,i+1]) )
  }
  str2 <- paste(str2,"  $\\chi^2/dof=$",all_obs[l,4])
  cat(str2,'\n\n')
}
add_plot<-function(string,all_obs,mt,gg ,log,number=NULL, nudge=0.0){
  string=sprintf("\\b%s\\b",string)# need to put the delimiters on the word to grep  
  label<-paste0(gsub('\\\\b','',string),"(L",L,"T",T,")")
  if (is.null(number)){
      l<-grep(string,all_obs[,"corr"])
      n<-all_obs[l,"n"]
  }
  else {
    n=number
    l=n
  }
  
  d<- get_block_n(mt,n)
  fit<- get_fit_n(mt,n)
  fit_range<- get_plateaux_range(mt,n)
  gg<- many_fit_ggplot(d,fit,fit_range,T/2,log,gg,  label ,nudge )
  my_print(label,fit,all_obs,l)
  
  return(gg)
}
add_res_plot<-function(string,all_obs,mt,gg ,log){
  string=sprintf("\\b%s\\b",string)# need to put the delimiters on the word to grep  
  l<-grep(string,all_obs[,"corr"])
  label<-paste0(gsub('\\\\b','',string),"(L",L,"T",T,")")
  n<-all_obs[l,"n"]
  d<- get_block_n(mt,n)
  fit<- get_fit_n(mt,n)
  fit_range<- get_plateaux_range(mt,n)
  gg<- residual_ggplot(d,fit,fit_range,T/2,log,gg,  label  )
  return(gg)
}
get_energy<-function(string,all_obs,mt){
  string=sprintf("\\b%s\\b",string)# need to put the delimiters on the word to grep  
  l<-grep(string,all_obs[,"corr"])
  label<-paste(gsub('\\\\b','',string),"(L",L,"T",T,")")
  n<-all_obs[l,"n"]
  d<- get_block_n(mt,n)
  fit<- get_fit_n(mt,n)
  
  return(c(fit[1,1],fit[1,2]))
}

add_plateaux_scan_plot<-function(string,all_obs,mt,gg ,offset=0, ribbon=FALSE){
  string=sprintf("\\b%s\\b",string)# need to put the delimiters on the word to grep  
  l<-grep(string,all_obs[,"corr"])
  label<-paste0(gsub('\\\\b','',string),"(L",L,"T",T,")")
  n<-all_obs[l,"n"]
  d<- get_block_n(mt,n)
  fit<- get_fit_n(mt,n)
  fit_range<- get_plateaux_range(mt,n)
  gg<- gg+ geom_point(data=d, mapping=aes(x=offset+d[,1]+0.01*d[,2], y=d[,4], color=label ),size=0.2  )
  gg<- gg+ geom_errorbar(data=d, mapping=aes(x=offset+d[,1]+0.01*d[,2],
                                  ymin=d[,4]-d[,5], ymax=d[,4]+d[,5] , color=label)  )+ theme_bw()
 # if(ribbon){
    label<-paste(gsub('\\\\b','',string),"(L",L,"T",T,")")
    gg<-gg+geom_ribbon(data=d,mapping= aes(x=d[,1],
             ymin=fit[1,1]-fit[1,2],ymax=fit[1,1]+fit[1,2], fill=label ),
             color=NA  ,alpha=0.2      ,inherit.aes = FALSE, show.legend = FALSE)
  #}
  return(gg)
}