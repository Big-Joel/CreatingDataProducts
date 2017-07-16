#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
   
    fit<-NULL
    fit1<-lm(qsec~hp,data=mtcars)#hp
    fit2<-lm(qsec~hp+disp,data=mtcars)#hp and disp
    fit3<-lm(qsec~hp+wt,data=mtcars)#hp and wt
    fit4<-lm(qsec~hp+wt+disp,data=mtcars)#hp and wt and disp
    
    adjustedR2<-reactive({
        wtBool<-input$include_weight
        dispBool<-input$include_disp
        if(wtBool){
            if(dispBool){
                #wt and disp
                fit<-fit4
            }
            else {
                #wt only
                fit<-fit3
            }
        }
        else {
            if(dispBool){
                #disp only
                fit<-fit2
            }
            else {
                #neither wt nor disp
                fit<-fit1
            }
        }
        paste0("R squared: ",summary(fit)$adj.r.squared)
    })
    
    output$qsecPlot <- renderPlot({
        ggplot(mtcars,aes(hp,qsec))+
            geom_point(aes(color = wt, size = disp))+
            geom_smooth(method = lm, se=FALSE)
    })
    
    output$residualsPlot <- renderPlot({
        
        wtBool<-input$include_weight
        dispBool<-input$include_disp
        
        if(wtBool){
            if(dispBool){
                #wt and disp
                fit<-fit4
            }
            else {
                #wt only
                fit<-fit3
            }
        }
        else {
            if(dispBool){
                #disp only
                fit<-fit2
            }
            else {
                #neither wt nor disp
                fit<-fit1
            }
        }
        
        par(mfrow=c(2,2))
        plot(fit)
    
  })
    
    output$adjustedR<-renderText({
        adjustedR2()
    })
  
})
