#--------------------------------------------------------------------------------
# Define the simulation date range and "todays" date
#--------------------------------------------------------------------------------
# date_start and date_end are for now defined in global.R.
# potomac.data.df is a placeholder for the various data sources
#   - it's loaded with data from date_start to date_end by potomac_flows_init.R.
# 
# We want to simulate up to date_today, and see things graphed
#   up thru date_today + (not yet implemented) some forecasts (fcs) 
#   up thru some period - maybe 15 days out into the future?
date_today <- as.Date("1930-04-01") # later to be reactive
#--------------------------------------------------------------------------------
flows.data.df <- flows.daily.mgd.df %>%
  filter(date_time < data_date_end, date_time >= date_start) %>%
  select(date_time, lfalls_nat, por_nat)
#
demands.data.df <- demands.daily.df %>%
  filter(date_time < data_date_end, date_time >= date_start) %>%
  select(date_time, demands = demands_total_unrestricted)

# date_today <- input$DREXtoday - this doesn't work
# sim_n <- as.numeric(as.POSIXct(date_today) - as.POSIXct(date_start),
#                     units = "days")
# 
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
# Main program - run the daily simulation
#--------------------------------------------------------------------------------
#--------------------------------------------------------------------------------
#
# Define an initial dataframe
flows.df0 <- flows.data.df %>%
  filter(date_time < date_start + 10)
demands.df0 <- demands.data.df %>%
  filter(date_time < date_start + 10)
ts0 <- list(flows = flows.df0, demands = demands.df0)
#
# This takes the initialized flow df and adds data up thru today
sim_main_func <- function(date_today, flows.df0){
  date_first <- last(flows.df0$date_time)
  flows.added <- flows.data.df %>%
    filter(date_time > date_first, date_time <= date_today)
  temp <- rbind(flows.df0, flows.added)
  return(temp)
}
#
# This adds another chunk of data
sim_add_func <- function(added_days, flows.df){
  date_first <- last(flows.df$date_time)
  flows.added <- flows.data.df %>%
    filter(date_time > date_first, date_time <= date_first + added_days)
  temp <- rbind(flows.df, flows.added)
  return(temp)
}

flows.df <- sim_main_func(date_today, flows.df0)

#
# *************************************************
# *************************************************

 
