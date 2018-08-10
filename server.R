#
#------------------------------------------------------------------
# 
#------------------------------------------------------------------

shinyServer(function(input, output, session) {
  #
  #------------------------------------------------------------------
  # Create the graphs etc to be displayed by the Shiny app
  #------------------------------------------------------------------
  #
  # date_start is currently hard-coded to be "2018-02-01"
  # First run doesn't have reactive inputs
  # This will display without pressing any buttons
  ts <- sim_main_func(date_start + 15, ts0)
  #  
  # Now make ts reactive
  ts <- reactiveValues()
  # This doesn't work unless I initialize ts
  ts$flows <- flows.df0
  ts$demands <- demands.df0
  #
  observeEvent(input$run_main, {
    ts <- sim_main_func(input$DREXtoday, ts)
  })
  #
  observeEvent(input$run_add, {
    ts <- sim_add_func(input$chunkofdays, ts)
  })
  

  #------------------------------------------------------------------
  output$potomacFlows <- renderPlot({
#    potomac.graph.df <- potomac.graph.df %>%
    potomac.graph.df0 <- ts$flows
    # potomac.graph.df0 <- flows.df
    potomac.graph.df <- potomac.graph.df0 %>%
      gather(key = "location", 
             value = "flow_mgd", -date_time) %>%
      filter(date_time >= input$plot_range[1],
             date_time <= input$plot_range[2])
    ggplot(data = potomac.graph.df, aes(x = date_time, y = flow_mgd, group = location)) +
      geom_line(aes(color = location))
    })

  #

  #



  })

