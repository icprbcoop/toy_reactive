# 
# This is the user-interface of a Shiny web application for the 2018 DREX.
# Run the application by clicking 'Run App' above.
#

dashboardPage(skin = "blue",
  dashboardHeader(title = "WMA 2018 DREX"),
  dashboardSidebar(
    width = 250,

    dateRangeInput("plot_range",
                   "Specify plot range",
                   start = "1929-10-01",
                   end = "1930-12-31",
                   format = "yyyy-mm-dd",
                   width = NULL), #"250px"),
    
    dateInput("DREXtoday",
          "Change today's date",
          value = "1930-06-01",
          min = "1929-10-02",
          max = "1931-12-31",
          format = "yyyy-mm-dd",
          width = "180px"),

actionButton("run_main",
             "Run simulation",
             icon = NULL,
             width = "150px"),

numericInput("chunkofdays",
             "Chunk of days",
             value = 7,
             min = 1,
             max = 30,
             width = "180px"),

actionButton("run_add",
             "Add days to simulation",
             icon = NULL,
             width = "150px")
      ),
  dashboardBody(

    fluidRow(
      column(
        width = 10,
        box(
          title = "Potomac River flow",
          width = NULL,
          plotOutput("potomacFlows")
          )
        ),
      column(
        width = 2,
        valueBoxOutput("por_flow", width = NULL),
        valueBoxOutput("lfaa_alert", width = NULL)
      )
    ) # end fluidRow with Potomac flows
) # end dashboardBody
) # end dashboardPage

