#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggiraph)
library(readr)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("The Dimensions of the CMDS analysis"),

    inputPanel(
      selectInput("dim1", label = "Dimension on x-axis",
                  choices = c("Dimension1", "Dimension2", "Dimension3", "Dimension4", "Dimension5", "Dimension6"), selected = "Dimension1"),
      selectInput("dim2", "Dimension on y-axis", choices = c("Dimension1", "Dimension2", "Dimension3", "Dimension4", "Dimension5", "Dimension6"), selected = "Dimension2")),

    girafeOutput("plot")
)


server <- function(input, output, session) {
  df<-read.table("dimensions.csv", sep=";", header=T)
    output$plot <- renderGirafe({
        # generate bins based on input$bins from ui.R
#      , tooltip=Verse, data_id=Verse
      g <- ggplot(data=df) + geom_point_interactive(aes(x=df[,input$dim1], y=df[,input$dim2], tooltip=Verse_text, data_id=Verse), shape=19, size=3) + ylab(input$dim2) + xlab(input$dim1)
      girafe(ggobj=g)
    })
}

#color=as.factor(df[,input$dim1]
# Run the application 
shinyApp(ui = ui, server = server)
