#
#------------------------------------------------------------------
# 
#------------------------------------------------------------------

shinyServer(function(input, output, session) {
  #
  #------------------------------------------------------------------
  # Create the graphs etc to be displayed by the Shiny app
  #------------------------------------------------------------------
   
  ts <- reactiveValues()
  # This doesn't work unless I initialize ts
  ts$flows <- flows.df0
  ts$demands <- demands.df0
  #
  observeEvent(input$run_main, {
     ts$flows <- sim_main_func(input$DREXtoday, flows.df0)
   })
  #
  # observeEvent(input$run_main, {
  #   ts$flows <- sim_main_func(input$DREXtoday, ts0$flows)
  # })
  # #
  observeEvent(input$run_add, {
    ts$flows <- sim_add_func(input$chunkofdays, ts$flows)
  })

  #------------------------------------------------------------------
  output$potomacFlows <- renderPlot({
#    potomac.graph.df <- potomac.graph.df %>%
    potomac.graph.df0 <- ts$flows
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

