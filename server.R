#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    dataset1 <- reactive({
        high_yield = c(input$init, rep(0, input$year-1))
        us_bonds = c(input$init, rep(0, input$year-1))
        us_stocks = c(input$init, rep(0, input$year-1))
        
        set.seed(input$seed)
        
        rate_yield <- input$yield_rate/100
        vol_yield <- input$yield_vol/100
        
        rate_bonds <- input$income_rate/100
        vol_bonds <- input$income_vol/100
        
        rate_equity <- input$equity_rate/100
        vol_equity <- input$equity_vol/100
        
        for (i in 2:input$year) {
            r1 <- rnorm(1, mean = rate_yield, sd = vol_yield)
            r2 <- rnorm(1, mean = rate_bonds, sd = vol_bonds)
            r3 <- rnorm(1, mean = rate_equity, sd = vol_equity)
            high_yield[i] <- high_yield[i-1]*(1 + r1) + input$contribute*(1 + input$growth_rate/100)^i
            us_bonds[i] <- us_bonds[i-1]*(1 + r2) + input$contribute*(1 + input$growth_rate/100)^i
            us_stocks[i] <- us_stocks[i-1]*(1 + r3) + input$contribute*(1 + input$growth_rate/100)^i
        }
        
        return(data.frame(data.frame(high_yield = high_yield, 
                              us_bonds = us_bonds, us_stocks = us_stocks, year = 1:input$year)))
        
    })

    
    dataset2 <- reactive({
        years <- rep(1:input$year, 3)
        dataset1 <- dataset1()
        amount <- c(dataset1$high_yield, dataset1$us_bonds, dataset1$us_stocks)
        type <- c(rep("high_yield", input$year), rep("us_bonds", input$year), rep("us_stocks", input$year))
        data.frame(years, amount, type)
    })
    
    output$plot <- renderPlot({
        
        if(input$facet == "No"){
            v <- dataset1()
            p1 <- v %>% ggplot() + geom_line(aes(x = year, y = high_yield, colour = "high_yield")) + geom_point(aes(x = year, y = high_yield, colour = "high_yield")) +
                geom_line(aes(x = year, y = us_bonds, colour = "us_bonds")) + geom_point(aes(x = year, y = us_bonds, colour = "us_bonds")) +
                geom_line(aes(x = year, y = us_stocks, colour = "us_stocks")) + geom_point(aes(x = year, y = us_stocks, colour = "us_stocks")) +
                ggtitle("Three indices") + ylab("amount")
            p1
        }

        else {
            u <- dataset2()
            p2 <- u %>% ggplot(aes(x = years, y = amount)) + geom_line(aes(colour = type)) + geom_point(aes(x = years, y = amount, colour = type)) +
                facet_wrap(~type) + ggtitle("Three indices") + ylab("amount") + geom_area(aes(fill = type))
            p2
        }

    })

})
